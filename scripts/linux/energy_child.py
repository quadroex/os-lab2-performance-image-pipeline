#!/usr/bin/env python3
"""Bracket one Linux child with a READY/GO/DONE/ACK/RESULT protocol.

The Windows parent starts measuring only after READY. After the child exits this
wrapper sends DONE and remains alive until ACK, so WSL startup/teardown stay
outside the energy interval. Standard output is reserved for JSON protocol lines.
No shell interpretation, binary modifications, or extra dependencies are used.
"""
import argparse
import json
import os
import select
import signal
import subprocess
import sys
import time


def emit(message):
    print(json.dumps(message, ensure_ascii=True, separators=(",", ":")), flush=True)


def read_control(expected, timeout):
    ready, _, _ = select.select([sys.stdin], [], [], timeout)
    if not ready:
        raise TimeoutError(f"Timed out waiting for {expected}")
    line = sys.stdin.readline()
    if not line:
        raise EOFError(f"Parent closed stdin while waiting for {expected}")
    if line.strip() != expected:
        raise ValueError(f"Expected {expected}, received {line.strip()!r}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--timeout", type=float, default=90)
    parser.add_argument("--control-timeout", type=float, default=30)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    options = parser.parse_args()
    command = options.command
    if command[:1] == ["--"]:
        command = command[1:]
    if not command or options.timeout <= 0 or options.control_timeout <= 0:
        parser.error("A command and positive timeout values are required")

    emit({"type": "READY", "protocol": 1, "pid": os.getpid(), "command": command})
    read_control("GO", options.control_timeout)
    monotonic_started_ns = time.monotonic_ns()
    realtime_started_ns = time.time_ns()
    child = None
    timed_out = False
    stdout = ""
    stderr = ""
    exit_code = 127
    error = None
    try:
        child = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                                 text=True, encoding="utf-8", errors="replace",
                                 start_new_session=True)
        try:
            stdout, stderr = child.communicate(timeout=options.timeout)
        except subprocess.TimeoutExpired:
            timed_out = True
            os.killpg(child.pid, signal.SIGTERM)
            try:
                stdout, stderr = child.communicate(timeout=3)
            except subprocess.TimeoutExpired:
                os.killpg(child.pid, signal.SIGKILL)
                stdout, stderr = child.communicate()
        exit_code = child.returncode
    except Exception as exc:
        error = f"{type(exc).__name__}: {exc}"
        if child is not None and child.poll() is None:
            os.killpg(child.pid, signal.SIGKILL)
            stdout, stderr = child.communicate()
            exit_code = child.returncode
    monotonic_ended_ns = time.monotonic_ns()
    realtime_ended_ns = time.time_ns()
    elapsed = (monotonic_ended_ns - monotonic_started_ns) / 1e9
    realtime_elapsed = (realtime_ended_ns - realtime_started_ns) / 1e9
    clock_data = {
        "child_wall_seconds": elapsed,
        "child_realtime_seconds": realtime_elapsed,
        "monotonic_start_ns": str(monotonic_started_ns),
        "monotonic_end_ns": str(monotonic_ended_ns),
        "realtime_start_ns": str(realtime_started_ns),
        "realtime_end_ns": str(realtime_ended_ns),
    }
    # Send the short completion message before serializing child output. The
    # parent captures its energy endpoint before ACK permits wrapper teardown.
    emit({"type": "DONE", "exit_code": exit_code, "timed_out": timed_out,
          **clock_data})
    read_control("ACK", options.control_timeout)
    emit({"type": "RESULT", "exit_code": exit_code, "timed_out": timed_out,
          **clock_data, "stdout": stdout, "stderr": stderr,
          "error": error})
    return 0 if exit_code == 0 and not timed_out and error is None else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except Exception as exc:
        emit({"type": "ERROR", "error": f"{type(exc).__name__}: {exc}"})
        sys.exit(1)
