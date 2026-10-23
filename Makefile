CXX ?= g++
BUILD_DIR ?= build
ARCH_FLAGS ?=
COMMON_FLAGS := -std=c++17 -Wall -Wextra -Wpedantic -g -fno-omit-frame-pointer $(ARCH_FLAGS)
SOURCES := src/main.cpp src/kernels.cpp
HEADERS := src/kernels.hpp
# Override for Clang: make SCALAR_FLAGS='-fno-vectorize -fno-slp-vectorize'
SCALAR_FLAGS ?= -fno-tree-vectorize -fno-tree-slp-vectorize

.PHONY: all test assembly clean
all: $(BUILD_DIR)/image_o0 $(BUILD_DIR)/image_o3 $(BUILD_DIR)/image_scalar

$(BUILD_DIR):
	mkdir -p "$@"

$(BUILD_DIR)/image_o0: $(SOURCES) $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O0 -DPERFLAB_VARIANT='"O0"' $(SOURCES) -o "$@"

$(BUILD_DIR)/image_o3: $(SOURCES) $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O3 -DPERFLAB_VARIANT='"O3"' $(SOURCES) -o "$@"

$(BUILD_DIR)/image_scalar: $(SOURCES) $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O3 $(SCALAR_FLAGS) -DPERFLAB_VARIANT='"O3-scalar"' $(SOURCES) -o "$@"

test: all
	"$(BUILD_DIR)/image_o0" --self-test
	"$(BUILD_DIR)/image_o3" --self-test
	"$(BUILD_DIR)/image_scalar" --self-test

# GCC assembly is reproducible from the same flags used for the executables.
# It shows only the three kernels, so the optimization differences are readable.
assembly: $(BUILD_DIR)/kernels_o0.s $(BUILD_DIR)/kernels_o3.s $(BUILD_DIR)/kernels_scalar.s

$(BUILD_DIR)/kernels_o0.s: src/kernels.cpp $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O0 -S -masm=intel -fverbose-asm src/kernels.cpp -o "$@"

$(BUILD_DIR)/kernels_o3.s: src/kernels.cpp $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O3 -S -masm=intel -fverbose-asm -fopt-info-vec-all=$(BUILD_DIR)/vectorization_o3.txt src/kernels.cpp -o "$@"

$(BUILD_DIR)/kernels_scalar.s: src/kernels.cpp $(HEADERS) | $(BUILD_DIR)
	$(CXX) $(COMMON_FLAGS) -O3 $(SCALAR_FLAGS) -S -masm=intel -fverbose-asm src/kernels.cpp -o "$@"

clean:
	rm -f "$(BUILD_DIR)/image_o0" "$(BUILD_DIR)/image_o3" "$(BUILD_DIR)/image_scalar"
	rm -f "$(BUILD_DIR)/kernels_o0.s" "$(BUILD_DIR)/kernels_o3.s" "$(BUILD_DIR)/kernels_scalar.s" "$(BUILD_DIR)/vectorization_o3.txt"
