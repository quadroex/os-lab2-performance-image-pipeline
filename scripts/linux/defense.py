#!/usr/bin/env python3
"""Short, visible defense commands. Run in Ubuntu as the student's normal user."""
from __future__ import annotations

import argparse
import ast
from contextlib import nullcontext
import getpass
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import statistics
import subprocess
import sys
from datetime import datetime, timezone
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[2]
STATE = ROOT / "build/defense"
VARIANTS = ("image_o0", "image_scalar", "image_o3")
LABELS = {"image_o0": "O0", "image_scalar": "O3 scalar", "image_o3": "O3"}
REPEATS = 100
PERF = os.environ.get("PERF", "/usr/lib/linux-tools/6.8.0-147-generic/perf")
ENV = dict(os.environ, LC_ALL="C")
ENERGY_MAIN = ROOT / "results/energy-sync-host-20261023T195827031Z"


def command_path(value):
    if isinstance(value, Path) and value != ROOT:
        try:
            return str(value.relative_to(ROOT))
        except ValueError:
            pass
    return str(value)


def run(argv, output=None, error=None):
    argv = [command_path(x) for x in argv]
    suffix = (" > " + shlex.quote(command_path(output))) if output else ""
    suffix += (" 2> " + shlex.quote(command_path(error))) if error else ""
    print("\n$ " + shlex.join(argv) + suffix, flush=True)
    with open(output, "w") if output else nullcontext() as out:
        with open(error, "w") if error else nullcontext() as err:
            subprocess.run(argv, cwd=ROOT, env=ENV, stdout=out, stderr=err, check=True)


def session():
    marker = STATE / "current.txt"
    if not marker.exists():
        raise RuntimeError("First run: python3 scripts/linux/defense.py prepare")
    folder = Path(marker.read_text().strip()).resolve()
    if folder.parent != STATE.resolve() or not folder.is_dir():
        raise RuntimeError("Invalid demonstration directory; run prepare again.")
    return folder


def target(variant):
    return ["taskset", "-c", "0", "./build/" + variant,
            "--width", "2048", "--height", "2048",
            "--repeats", str(REPEATS), "--seed", "12345"]


def validate_outputs(paths):
    data = [json.loads(p.read_text()) for p in paths]
    expected = (2048, 2048, REPEATS, 12345)
    for item in data:
        assert tuple(item[k] for k in ("width", "height", "repeats", "seed")) == expected
    assert len({item["checksum"] for item in data}) == 1, "Different results!"
    print("Same workload and checksum: " + data[0]["checksum"])


def prepare():
    for tool in (PERF, "/usr/bin/time", "taskset", "perl", "g++", "objdump"):
        if not shutil.which(tool):
            raise RuntimeError("Missing tool: " + tool)
    STATE.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    folder = STATE / stamp
    folder.mkdir()
    for variant in VARIANTS:
        (folder / variant).mkdir()
    (STATE / "current.txt").write_text(str(folder) + "\n")
    run(["bash", "scripts/linux/fetch_flamegraph.sh"])
    dirty = subprocess.check_output(
        ["git", "-C", str(ROOT / "tools/FlameGraph"), "status", "--porcelain"], text=True)
    if dirty.strip():
        raise RuntimeError("FlameGraph has local changes; restore the official source first.")
    print(f"\nUser: {getpass.getuser()}; demo: 2048x2048, {REPEATS} repeats, seed 12345")
    print(f"New results: {folder}\nMain 300-repeat measurements remain separate.")


def check():
    prepare()
    folder = session()
    print("\nChecking source and measured binary hashes...")
    manifest = json.loads((ROOT / "results/linux-main/manifest.json").read_text())
    for variant, expected in manifest["binary_sha256"].items():
        assert hashlib.sha256((ROOT / "build" / variant).read_bytes()).hexdigest() == expected
    for item in json.loads((ROOT / "results/assembly/source_hashes.json").read_text()):
        assert hashlib.sha256((ROOT / item["path"]).read_bytes()).hexdigest() == item["sha256"]
    for path in (ROOT / "scripts").rglob("*.py"):
        ast.parse(path.read_text(), filename=str(path))
    for path in (ROOT / "scripts").rglob("*.sh"):
        run(["bash", "-n", path])
    # Rebuild into an isolated directory; keep the measured ELF/build IDs intact.
    build = "build/defense/check-build"
    run(["make", "-j2", "BUILD_DIR=" + build, "ARCH_FLAGS=-mavx2", "all", "assembly"])
    for variant in VARIANTS:
        run(["./" + build + "/" + variant, "--self-test"])
    run([PERF, "stat", "-e", "cycles:u,instructions:u", "--",
         "./build/image_o3", "--size", "64", "--repeats", "1"])
    for variant in VARIANTS:
        for args in (["--width", "0"], ["--repeats", "0"], ["--unknown"]):
            result = subprocess.run(["./build/" + variant] + args, cwd=ROOT,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            assert result.returncode != 0, (variant, args)
    (folder / "check-passed.txt").write_text("Build, 3x722 reference tests, hashes, syntax, CLI and PMU: PASS\n")
    print("\nPASS: fresh builds; 722 reference tests per variant; 9 invalid CLI checks; hashes; scripts; perf.")


def assembly():
    folder = session()
    for variant in VARIANTS:
        path = folder / variant / "grayscale.asm.txt"
        run(["objdump", "-d", "-Mintel", "--no-show-raw-insn",
             "--disassemble=rgb_to_grayscale", "build/" + variant], output=path)
        lines = [line for line in path.read_text().splitlines()
                 if re.match(r"\s*[0-9a-f]+:\s", line)]
        needle = "vpmulld" if variant == "image_o3" else "imul"
        i = next(i for i, line in enumerate(lines) if needle in line)
        selected = lines[max(0, i - (5 if variant == "image_o0" else 1)):i + 5]
        print(f"\n{LABELS[variant]}: selected real instructions (other lines omitted)")
        print("\n".join(selected))
        if variant == "image_o3":
            print("... finishing the vector block ...")
            shift = next(i for i, line in enumerate(lines) if "vpsrld" in line and "ymm" in line)
            print("\n".join(lines[shift:shift + 5]))
    print("\nO0: extra stack/address work. Scalar: one pixel. AVX2: 8 x uint32, step 32 bytes.")


def stats():
    folder = session()
    outputs = []
    for variant in VARIANTS:
        part = folder / variant
        print("\n=== " + LABELS[variant] + " ===")
        run(["/usr/bin/time", "--verbose", "--output", part / "time.txt"] + target(variant),
            output=part / "time-program.json")
        print((part / "time.txt").read_text(), flush=True)
        run([PERF, "stat", "-d", "--no-big-num", "--output", part / "perf-stat.txt", "--"]
            + target(variant), output=part / "perf-program.json")
        print((part / "perf-stat.txt").read_text(), flush=True)
        outputs.extend([part / "time-program.json", part / "perf-program.json"])
    validate_outputs(outputs)
    print("LLC 'not supported' means unavailable. With an ordinary user, perf stat may show :u (user space).")


def record():
    folder = session()
    outputs = []
    for variant in ("image_o0", "image_o3"):
        part = folder / variant
        run([PERF, "record", "-e", "cpu-clock:u", "-F", "199",
             "--call-graph", "dwarf,16384", "-o", part / "perf.data", "--"] + target(variant),
            output=part / "record-program.json", error=part / "record.stderr.txt")
        print((part / "record.stderr.txt").read_text(), flush=True)
        outputs.append(part / "record-program.json")
    validate_outputs(outputs)
    print("\nRecorded O0 and O3. Next: lab report; later: lab flame.")


def flame():
    folder = session()
    for variant in ("image_o0", "image_o3"):
        if not (folder / variant / "perf.data").is_file():
            raise RuntimeError("First run lab record in the statistics stage.")
    for variant in ("image_o0", "image_o3"):
        part = folder / variant
        run([PERF, "script", "-i", part / "perf.data"],
            output=part / "stacks.txt", error=part / "script.stderr.txt")
        run(["perl", "tools/FlameGraph/stackcollapse-perf.pl", part / "stacks.txt"],
            output=part / "stacks.folded")
        assert (part / "stacks.folded").stat().st_size > 0, "Empty profile"
        run(["perl", "tools/FlameGraph/flamegraph.pl", "--hash", "--countname", "nanoseconds",
             "--title", "CPU FlameGraph: " + LABELS[variant] + ", 100 repeats",
             "--subtitle", "Period-weighted CPU time; each graph normalized; x is not chronology",
             part / "stacks.folded"], output=part / "flamegraph.svg")
        ET.parse(part / "flamegraph.svg")
    print("\nCreated two new SVGs. Open: python3 scripts/linux/defense.py open")


def report():
    folder = session()
    for variant in ("image_o0", "image_o3"):
        if not (folder / variant / "perf.data").is_file():
            raise RuntimeError("First run lab record.")
    for variant in ("image_o0", "image_o3"):
        part = folder / variant
        run([PERF, "report", "--stdio", "--show-nr-samples", "--no-children",
             "-i", part / "perf.data"], output=part / "report-self.txt")
        text = (part / "report-self.txt").read_text()
        if "# Total Lost Samples: 0" not in text:
            raise RuntimeError("Inspect lost samples before interpreting this profile.")
        print("\n" + LABELS[variant] + "\n" + "\n".join(text.splitlines()[:32]), flush=True)


def energy_table(folder):
    data = json.loads((folder / "summary.json").read_text(encoding="utf-8-sig"))
    assert data["Status"] == "ok" and data["CompletedRuns"] == data["RequestedRuns"]
    rows = data["Measurements"]
    print("\n" + str(folder))
    print("Medians. System = named domain during execution; App = incremental ESTIMATE.")
    print(f"{'Variant':<11} {'Domain':<6} {'System J':>10} {'System W':>10} {'App est.J':>11} {'App est.W':>11}")
    for variant in VARIANTS:
        for domain in ("PKG", "DRAM"):
            group = [r for r in rows if r["Executable"] == variant and r["Domain"].endswith("_" + domain)]
            if not group:
                raise RuntimeError("Missing energy domain: " + domain)
            devices = {r["Device"] for r in group}
            assert len(devices) == 1, "Multiple devices need separate domain tables."
            med = lambda field: statistics.median(float(r[field]) for r in group)
            net_watts = statistics.median(float(r["IncrementalEstimateJoules"]) /
                                          float(r["EnergyDurationSeconds"]) for r in group)
            print(f"{LABELS[variant]:<11} {domain:<6} {med('ActiveEnergyJoules'):10.2f} "
                  f"{med('ActiveAverageWatts'):10.2f} {med('IncrementalEstimateJoules'):11.2f} {net_watts:11.2f}")
    print("PKG/DRAM only, not whole-PC input. App values are background-subtracted estimates.")


def find_pwsh():
    candidates = [os.environ.get("PERFLAB_PWSH"), shutil.which("pwsh.exe"),
                  "/mnt/c/Program Files/PowerShell/7/pwsh.exe"]
    # A normal PowerShell/WSL session need not inherit the Codex runtime PATH.
    # Reuse the explicit, already configured host executable as a fallback.
    settings_path = ROOT / ".vscode/settings.json"
    if settings_path.is_file():
        settings = json.loads(settings_path.read_text(encoding="utf-8-sig"))
        candidates.extend(settings.get("powershell.powerShellAdditionalExePaths", {}).values())
    for value in candidates:
        if not value:
            continue
        if re.match(r"^[A-Za-z]:[\\/]", value):
            value = subprocess.check_output(["wslpath", "-u", value], text=True).strip()
        candidate = Path(value)
        if candidate.is_file():
            return str(candidate)
    raise RuntimeError("PowerShell 7 was not found. Check .vscode/settings.json or set PERFLAB_PWSH.")


def energy():
    folder = session()
    pwsh = find_pwsh()
    win = lambda p: subprocess.check_output(["wslpath", "-w", str(p)], text=True).strip()
    # The command is entered in Ubuntu; the Windows host reads EMI.
    run([pwsh, "-NoLogo", "-NoProfile", "-NonInteractive", "-File",
         win(ROOT / "scripts/windows/run_sync_energy_series.ps1"),
         "-Distro", "Ubuntu-24.04", "-LinuxUser", getpass.getuser(),
         "-LinuxProjectPath", ROOT, "-Width", "2048", "-Height", "2048",
         "-Repeats", str(REPEATS), "-Cpu", "0", "-Rounds", "1", "-SettleSeconds", "2",
         "-OutputRoot", win(folder / "energy")])
    created = sorted((folder / "energy").glob("energy-sync-host-*"))
    if not created:
        raise RuntimeError("No energy results were created.")
    energy_table(created[-1])


def results():
    data = json.loads((ROOT / "results/analysis/summary.json").read_text())
    print("MAIN SERIES: 2048x2048, 300 repeats, seed 12345; 5 timing/counter runs per variant.")
    print(f"{'Variant':<11} {'Compute s':>10} {'Elapsed s':>10} {'Instructions B':>15} {'Cycles B':>10} {'IPC':>7}")
    for variant in VARIANTS:
        row = data["variants"][variant]
        perf = row["perf"]
        print(f"{LABELS[variant]:<11} {row['compute']['compute_seconds_median']:10.2f} "
              f"{row['time']['wall_seconds']['median']:10.2f} "
              f"{perf['instructions']['median']/1e9:15.2f} {perf['cycles']['median']/1e9:10.2f} "
              f"{perf['ipc']['median']:7.2f}")


def open_graphs():
    folder = session()
    paths = [folder / v / "flamegraph.svg" for v in ("image_o0", "image_o3")]
    for path in paths:
        if not path.exists():
            raise RuntimeError("First run flame.")
    browsers = [Path("/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"),
                Path("/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe")]
    browser = next((p for p in browsers if p.exists()), None)
    if browser is None:
        raise RuntimeError("Open these SVG files manually in a browser:\n" + "\n".join(map(str, paths)))
    uris = []
    for path in paths:
        win_path = subprocess.check_output(["wslpath", "-w", str(path)], text=True).strip()
        uris.append("file:///" + win_path.replace("\\", "/"))
    launcher = subprocess.Popen([str(browser), "--new-window"] + uris,
                                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    try:
        code = launcher.wait(timeout=3)
        if code != 0:
            raise RuntimeError("Browser launcher failed: " + str(code))
    except subprocess.TimeoutExpired:
        pass  # A new browser process may keep running; leave its window open.
    print("Opened two new FlameGraphs in " + browser.name + ".")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("step", choices=("prepare", "check", "asm", "stats", "record", "report", "flame",
                                         "results", "energy", "energy-results", "open"))
    args = parser.parse_args()
    actions = {"prepare": prepare, "check": check, "asm": assembly, "stats": stats,
               "record": record, "flame": flame, "report": report, "results": results, "energy": energy,
               "energy-results": lambda: energy_table(ENERGY_MAIN), "open": open_graphs}
    os.chdir(ROOT)
    actions[args.step]()


if __name__ == "__main__":
    try:
        main()
    except (OSError, RuntimeError, AssertionError, subprocess.CalledProcessError) as exc:
        print("\nERROR: " + str(exc), file=sys.stderr)
        sys.exit(1)
