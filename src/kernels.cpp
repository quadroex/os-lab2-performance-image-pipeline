#include "kernels.hpp"

#include <algorithm>

extern "C" {

void rgb_to_grayscale(const std::uint32_t* PERFLAB_RESTRICT red,
                      const std::uint32_t* PERFLAB_RESTRICT green,
                      const std::uint32_t* PERFLAB_RESTRICT blue,
                      std::uint32_t* PERFLAB_RESTRICT gray,
                      std::size_t count) noexcept {
    for (std::size_t i = 0; i < count; ++i) {
        // Integer approximation of luminance; the weights sum to 256.
        gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
    }
}

void adjust_contrast(const std::uint32_t* PERFLAB_RESTRICT gray,
                     std::uint32_t* PERFLAB_RESTRICT contrast,
                     std::size_t count) noexcept {
    for (std::size_t i = 0; i < count; ++i) {
        // Gain 1.5 around the midpoint, followed by saturation to [0,255].
        const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
        contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
    }
}

static std::uint32_t blurred_edge(const std::uint32_t* row,
                                  std::size_t x, std::size_t width) noexcept {
    const std::size_t left2 = x >= 2 ? x - 2 : 0;
    const std::size_t left1 = x >= 1 ? x - 1 : 0;
    const std::size_t right1 = std::min(x + 1, width - 1);
    const std::size_t right2 = std::min(x + 2, width - 1);
    return (row[left2] + 4u * row[left1] + 6u * row[x]
            + 4u * row[right1] + row[right2] + 8u) >> 4;
}

void horizontal_blur_5tap(const std::uint32_t* PERFLAB_RESTRICT source,
                          std::uint32_t* PERFLAB_RESTRICT destination,
                          std::size_t width, std::size_t height) noexcept {
    for (std::size_t y = 0; y < height; ++y) {
        const std::uint32_t* row = source + y * width;
        std::uint32_t* out = destination + y * width;
        if (width < 5) {
            for (std::size_t x = 0; x < width; ++x) {
                out[x] = blurred_edge(row, x, width);
            }
            continue;
        }
        out[0] = blurred_edge(row, 0, width);
        out[1] = blurred_edge(row, 1, width);
        // A straight interior loop gives the compiler room to use SIMD.
        for (std::size_t x = 2; x < width - 2; ++x) {
            out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
                      + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
        }
        out[width - 2] = blurred_edge(row, width - 2, width);
        out[width - 1] = blurred_edge(row, width - 1, width);
    }
}

}
