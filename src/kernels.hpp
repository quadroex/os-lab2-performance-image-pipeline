#pragma once

#include <cstddef>
#include <cstdint>

#if defined(_MSC_VER)
#define PERFLAB_RESTRICT __restrict
#define PERFLAB_NOINLINE __declspec(noinline)
#elif defined(__GNUC__) || defined(__clang__)
#define PERFLAB_RESTRICT __restrict__
#define PERFLAB_NOINLINE __attribute__((noinline))
#else
#define PERFLAB_RESTRICT
#define PERFLAB_NOINLINE
#endif

// All source and destination buffers passed to a call must be distinct.
// Keeping these three stages out of line makes their CPU samples interpretable.
extern "C" {
PERFLAB_NOINLINE void rgb_to_grayscale(
    const std::uint32_t* PERFLAB_RESTRICT red,
    const std::uint32_t* PERFLAB_RESTRICT green,
    const std::uint32_t* PERFLAB_RESTRICT blue,
    std::uint32_t* PERFLAB_RESTRICT gray, std::size_t count) noexcept;

PERFLAB_NOINLINE void adjust_contrast(
    const std::uint32_t* PERFLAB_RESTRICT gray,
    std::uint32_t* PERFLAB_RESTRICT contrast, std::size_t count) noexcept;

PERFLAB_NOINLINE void horizontal_blur_5tap(
    const std::uint32_t* PERFLAB_RESTRICT source,
    std::uint32_t* PERFLAB_RESTRICT destination,
    std::size_t width, std::size_t height) noexcept;
}
