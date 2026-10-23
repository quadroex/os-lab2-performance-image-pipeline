#include "kernels.hpp"

#include <algorithm>
#include <array>
#include <charconv>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <exception>
#include <iomanip>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

#ifndef PERFLAB_VARIANT
#define PERFLAB_VARIANT "unspecified"
#endif
#define PERFLAB_STRINGIFY_INNER(x) #x
#define PERFLAB_STRINGIFY(x) PERFLAB_STRINGIFY_INNER(x)

namespace {

struct Options {
    std::size_t width = 2048;
    std::size_t height = 2048;
    std::uint32_t repeats = 20;
    std::uint32_t seed = 12345;
    bool self_test = false;
};

struct Image {
    std::vector<std::uint32_t> red, green, blue, gray, contrast, output;
    explicit Image(std::size_t count)
        : red(count), green(count), blue(count), gray(count), contrast(count), output(count) {}
};

std::uint32_t next_random(std::uint32_t& state) noexcept {
    state ^= state << 13;
    state ^= state >> 17;
    state ^= state << 5;
    return state;
}

void initialize(Image& image, std::uint32_t seed) {
    // xorshift32 has an all-zero fixed point, so map seed zero explicitly.
    std::uint32_t state = seed == 0 ? 0x9e3779b9u : seed;
    for (std::size_t i = 0; i < image.red.size(); ++i) {
        image.red[i] = next_random(state) & 255u;
        image.green[i] = next_random(state) & 255u;
        image.blue[i] = next_random(state) & 255u;
    }
}

void pipeline(Image& image, std::size_t width, std::size_t height, std::uint32_t repeats) {
    for (std::uint32_t iteration = 0; iteration < repeats; ++iteration) {
        rgb_to_grayscale(image.red.data(), image.green.data(), image.blue.data(),
                         image.gray.data(), image.red.size());
        adjust_contrast(image.gray.data(), image.contrast.data(), image.red.size());
        horizontal_blur_5tap(image.contrast.data(), image.output.data(), width, height);
        // Feed the result back as the next red channel. No copying and no aliasing:
        // six separately allocated buffers remain distinct after this swap.
        image.red.swap(image.output);
    }
}

std::uint64_t checksum(const std::vector<std::uint32_t>& values) noexcept {
    // This is an explicitly specified checksum, not a security hash.
    std::uint64_t hash = 14695981039346656037ull;
    for (std::uint32_t value : values) {
        hash ^= value;
        hash *= 1099511628211ull;
    }
    return hash;
}

std::uint64_t number(std::string_view text, const std::string& option) {
    std::uint64_t value = 0;
    const auto result = std::from_chars(text.data(), text.data() + text.size(), value);
    if (text.empty() || result.ec != std::errc() || result.ptr != text.data() + text.size()) {
        throw std::invalid_argument("invalid nonnegative integer for " + option);
    }
    return value;
}

Options parse_options(int argc, char** argv) {
    Options options;
    for (int i = 1; i < argc; ++i) {
        const std::string option = argv[i];
        if (option == "--help" || option == "-h") {
            std::cout << "Usage: image_VARIANT [--size N | --width W --height H]\n"
                         "                     [--repeats R] [--seed S] [--self-test]\n"
                         "Defaults: width=2048 height=2048 repeats=20 seed=12345\n"
                         "Output: one JSON object. The timed region covers the three image\n"
                         "stages and buffer swaps; allocation, initialization, and checksum\n"
                         "are outside it. External time/perf measure the entire process.\n";
            std::exit(0);
        }
        if (option == "--self-test") {
            options.self_test = true;
            continue;
        }
        if (option != "--size" && option != "--width" && option != "--height"
            && option != "--repeats" && option != "--seed") {
            throw std::invalid_argument("unknown option: " + option);
        }
        if (++i == argc) {
            throw std::invalid_argument("missing value for " + option);
        }
        const std::uint64_t value = number(argv[i], option);
        if (option == "--size" || option == "--width" || option == "--height") {
            if (value < 1 || value > 65536) {
                throw std::invalid_argument(option + " must be in [1,65536]");
            }
            if (option != "--height") options.width = static_cast<std::size_t>(value);
            if (option != "--width") options.height = static_cast<std::size_t>(value);
        } else if (option == "--repeats") {
            if (value < 1 || value > 1000000) {
                throw std::invalid_argument("--repeats must be in [1,1000000]");
            }
            options.repeats = static_cast<std::uint32_t>(value);
        } else {
            if (value > std::numeric_limits<std::uint32_t>::max()) {
                throw std::invalid_argument("--seed must fit an unsigned 32-bit integer");
            }
            options.seed = static_cast<std::uint32_t>(value);
        }
    }
    // Bound allocation and ensure multiplication is valid even on 32-bit targets.
    constexpr std::size_t max_pixels = 100000000;
    if (options.width > max_pixels / options.height) {
        throw std::invalid_argument("image is too large; at most 100000000 pixels are allowed");
    }
    return options;
}

void reference_step(Image& image, std::size_t width, std::size_t height) {
    // Independent scalar specification: compute each blurred output pixel directly
    // from five RGB samples. It does not reuse any production stage or edge helper.
    constexpr std::array<unsigned, 5> weights{1, 4, 6, 4, 1};
    for (std::size_t y = 0; y < height; ++y) {
        for (std::size_t x = 0; x < width; ++x) {
            unsigned sum = 0;
            for (int tap = -2; tap <= 2; ++tap) {
                const auto sample_x = static_cast<std::size_t>(std::clamp<std::int64_t>(
                    static_cast<std::int64_t>(x) + tap, 0, static_cast<std::int64_t>(width) - 1));
                const std::size_t index = y * width + sample_x;
                const unsigned luminance = (image.red[index] * 77 + image.green[index] * 150
                                            + image.blue[index] * 29 + 128) / 256;
                int adjusted = static_cast<int>((luminance * 3 + 1) / 2) - 64;
                if (adjusted < 0) adjusted = 0;
                if (adjusted > 255) adjusted = 255;
                sum += weights[static_cast<std::size_t>(tap + 2)] * static_cast<unsigned>(adjusted);
            }
            image.output[y * width + x] = (sum + 8) / 16;
        }
    }
    image.red.swap(image.output);
}

int self_test() {
    // Widths include narrow images, SIMD boundaries, and nonmultiple tail lengths.
    constexpr std::array<std::size_t, 15> widths{1, 2, 3, 4, 5, 7, 8, 9, 15, 16, 17, 31, 32, 33, 67};
    constexpr std::array<std::size_t, 3> heights{1, 2, 5};
    constexpr std::array<std::uint32_t, 4> seeds{0, 1, 12345, 0xffffffffu};
    std::size_t cases = 0;
    for (std::size_t width : widths) {
        for (std::size_t height : heights) {
            for (std::uint32_t seed : seeds) {
                Image actual(width * height);
                initialize(actual, seed);
                Image expected = actual;
                for (unsigned step = 0; step < 4; ++step) {
                    pipeline(actual, width, height, 1);
                    reference_step(expected, width, height);
                    if (actual.red != expected.red) {
                        std::cerr << "Self-test mismatch: width=" << width << " height=" << height
                                  << " seed=" << seed << " step=" << step << '\n';
                        return 1;
                    }
                    ++cases;
                }
            }
        }
    }
    // Hand-checkable extremes and clamp behavior supplement the independent model.
    for (std::uint32_t value : {0u, 255u}) {
        Image image(7);
        std::fill(image.red.begin(), image.red.end(), value);
        std::fill(image.green.begin(), image.green.end(), value);
        std::fill(image.blue.begin(), image.blue.end(), value);
        pipeline(image, 7, 1, 1);
        if (!std::all_of(image.red.begin(), image.red.end(), [value](auto pixel) { return pixel == value; })) {
            std::cerr << "Self-test failed for constant extreme " << value << '\n';
            return 1;
        }
        ++cases;
    }
    std::cout << "{\"status\":\"pass\",\"cases\":" << cases
              << ",\"build_variant\":\"" << PERFLAB_VARIANT << "\"}\n";
    return 0;
}

const char* compiler_name() noexcept {
#if defined(__clang__)
    return "Clang " __clang_version__;
#elif defined(_MSC_VER)
    return "MSVC " PERFLAB_STRINGIFY(_MSC_VER);
#elif defined(__GNUC__)
    return "GCC " __VERSION__;
#else
    return "unknown";
#endif
}

const char* compiled_isa() noexcept {
#if defined(__AVX2__)
    return "AVX2-enabled";
#elif defined(__AVX__)
    return "AVX-enabled";
#elif defined(__SSE2__) || defined(_M_X64)
    return "SSE2-baseline";
#elif defined(__aarch64__) || defined(_M_ARM64)
    return "ARM64";
#else
    return "portable-baseline";
#endif
}

} // namespace

int main(int argc, char** argv) {
    try {
        const Options options = parse_options(argc, argv);
        if (options.self_test) return self_test();
        const std::size_t count = options.width * options.height;
        Image image(count);
        initialize(image, options.seed);
        const auto start = std::chrono::steady_clock::now();
        pipeline(image, options.width, options.height, options.repeats);
        const auto finish = std::chrono::steady_clock::now();
        const double seconds = std::chrono::duration<double>(finish - start).count();
        const auto result_checksum = checksum(image.red);
        std::cout << std::setprecision(12)
                  << "{\"width\":" << options.width << ",\"height\":" << options.height
                  << ",\"repeats\":" << options.repeats << ",\"seed\":" << options.seed
                  << ",\"pixels_per_repeat\":" << count
                  << ",\"compute_seconds\":" << seconds
                  << ",\"checksum\":\"" << result_checksum << "\""
                  << ",\"build_variant\":\"" << PERFLAB_VARIANT << "\""
                  << ",\"compiler\":\"" << compiler_name() << "\""
                  << ",\"compiled_isa\":\"" << compiled_isa() << "\"}\n";
        return 0;
    } catch (const std::exception& error) {
        std::cerr << "Error: " << error.what() << '\n';
        return 2;
    }
}
