	.file	"kernels.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O3 -std=c++17 -fno-omit-frame-pointer -fno-tree-vectorize -fno-tree-slp-vectorize -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
.Ltext0:
	.file 0 "/mnt/q/Documents/CodexFiles/2026-10-23/x20/outputs/performance-lab" "src/kernels.cpp"
	.p2align 4
	.type	blurred_edge, @function
blurred_edge:
.LVL0:
.LFB703:
	.file 1 "src/kernels.cpp"
	.loc 1 29 78 view -0
	.cfi_startproc
	.loc 1 30 5 view .LVU1
# src/kernels.cpp:29:                                   std::size_t x, std::size_t width) noexcept {
	.loc 1 29 78 is_stmt 0 view .LVU2
	mov	rax, rsi	# x, tmp146
# src/kernels.cpp:30:     const std::size_t left2 = x >= 2 ? x - 2 : 0;
	.loc 1 30 38 view .LVU3
	mov	esi, 2	# tmp152,
.LVL1:
# src/kernels.cpp:29:                                   std::size_t x, std::size_t width) noexcept {
	.loc 1 29 78 view .LVU4
	mov	rcx, rdi	# row, tmp145
	mov	r8, rdi	# _49, row
# src/kernels.cpp:30:     const std::size_t left2 = x >= 2 ? x - 2 : 0;
	.loc 1 30 38 view .LVU5
	cmp	rax, rsi	# x, tmp152
	cmovnb	rsi, rax	# x,, tmp116
# src/kernels.cpp:30:     const std::size_t left2 = x >= 2 ? x - 2 : 0;
	.loc 1 30 23 view .LVU6
	sub	rsi, 2	# left2,
.LVL2:
	.loc 1 31 5 is_stmt 1 view .LVU7
# src/kernels.cpp:31:     const std::size_t left1 = x >= 1 ? x - 1 : 0;
	.loc 1 31 38 is_stmt 0 view .LVU8
	test	rax, rax	# x
	je	.L2	#,
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 40 view .LVU9
	lea	r8, -4[rdi+rax*4]	# _49,
.L2:
	.loc 1 32 5 is_stmt 1 view .LVU10
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 47 is_stmt 0 view .LVU11
	mov	edi, DWORD PTR [rcx+rax*4]	# *_9, *_9
.LVL3:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU12
	mov	esi, DWORD PTR [rcx+rsi*4]	# *_6, *_6
.LVL4:
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 54 view .LVU13
	sub	rdx, 1	# _2,
.LVL5:
.LBB20:
.LBI20:
	.file 2 "/usr/include/c++/13/bits/stl_algobase.h"
	.loc 2 233 5 is_stmt 1 view .LVU14
	.loc 2 233 5 is_stmt 0 view .LVU15
.LBE20:
	.loc 1 33 5 is_stmt 1 view .LVU16
.LBB22:
.LBI22:
	.loc 2 233 5 view .LVU17
	.loc 2 233 5 is_stmt 0 view .LVU18
.LBE22:
	.loc 1 34 5 is_stmt 1 view .LVU19
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 47 is_stmt 0 view .LVU20
	lea	edi, [rdi+rdi*2]	# tmp123,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU21
	lea	edi, 8[rsi+rdi*2]	# tmp126,
# src/kernels.cpp:33:     const std::size_t right2 = std::min(x + 2, width - 1);
	.loc 1 33 43 view .LVU22
	lea	rsi, 2[rax]	# tmp129,
.LBB24:
.LBB23:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 view .LVU23
	cmp	rsi, rdx	# tmp129, _2
	cmova	rsi, rdx	# tmp129,, tmp128, _2
.LBE23:
.LBE24:
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 43 view .LVU24
	add	rax, 1	# tmp133,
.LVL6:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU25
	add	edi, DWORD PTR [rcx+rsi*4]	# tmp126, *_24
.LBB25:
.LBB21:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 view .LVU26
	cmp	rax, rdx	# tmp133, _2
	cmova	rax, rdx	# tmp133,, tmp132, _2
.LVL7:
	.loc 2 238 7 view .LVU27
.LBE21:
.LBE25:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU28
	mov	edx, DWORD PTR [r8]	# *prephitmp_50, *prephitmp_50
.LVL8:
	.loc 1 35 46 view .LVU29
	add	edx, DWORD PTR [rcx+rax*4]	# *prephitmp_50, *_19
	lea	eax, [rdi+rdx*4]	# tmp138,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 view .LVU30
	shr	eax, 4	# tmp119,
# src/kernels.cpp:36: }
	.loc 1 36 1 view .LVU31
	ret	
	.cfi_endproc
.LFE703:
	.size	blurred_edge, .-blurred_edge
	.p2align 4
	.globl	rgb_to_grayscale
	.type	rgb_to_grayscale, @function
rgb_to_grayscale:
.LVL9:
.LFB700:
	.loc 1 11 51 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 11 51 is_stmt 0 view .LVU33
	endbr64	
	.loc 1 12 5 is_stmt 1 view .LVU34
.LVL10:
.LBB26:
	.loc 1 12 31 discriminator 1 view .LVU35
.LBE26:
# src/kernels.cpp:11:                       std::size_t count) noexcept {
	.loc 1 11 51 is_stmt 0 view .LVU36
	mov	r9, rsi	# green, tmp109
	mov	r10, rdx	# blue, tmp110
.LBB27:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 31 discriminator 1 view .LVU37
	test	r8, r8	# count
	je	.L13	#,
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 22 view .LVU38
	xor	eax, eax	# i
.LVL11:
	.p2align 4,,10
	.p2align 3
.L8:
	.loc 1 14 9 is_stmt 1 view .LVU39
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 is_stmt 0 view .LVU40
	imul	esi, DWORD PTR [rdi+rax*4], 77	# tmp98, MEM[(const uint32_t *)red_20(D) + i_28 * 4],
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU41
	imul	edx, DWORD PTR [r9+rax*4], 150	# tmp100, MEM[(const uint32_t *)green_21(D) + i_28 * 4],
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU42
	lea	edx, 128[rsi+rdx]	# tmp103,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU43
	imul	esi, DWORD PTR [r10+rax*4], 29	# tmp104, MEM[(const uint32_t *)blue_22(D) + i_28 * 4],
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU44
	add	edx, esi	# tmp106, tmp104
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU45
	shr	edx, 8	# tmp107,
	mov	DWORD PTR [rcx+rax*4], edx	# MEM[(uint32_t *)gray_23(D) + i_28 * 4], tmp107
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU46
	add	rax, 1	# i,
.LVL12:
	.loc 1 12 31 discriminator 1 view .LVU47
	cmp	r8, rax	# count, i
	jne	.L8	#,
.LVL13:
.L13:
	.loc 1 12 31 is_stmt 0 discriminator 1 view .LVU48
.LBE27:
# src/kernels.cpp:16: }
	.loc 1 16 1 view .LVU49
	ret	
	.cfi_endproc
.LFE700:
	.size	rgb_to_grayscale, .-rgb_to_grayscale
	.p2align 4
	.globl	adjust_contrast
	.type	adjust_contrast, @function
adjust_contrast:
.LVL14:
.LFB701:
	.loc 1 20 50 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 20 50 is_stmt 0 view .LVU51
	endbr64	
	.loc 1 21 5 is_stmt 1 view .LVU52
.LVL15:
.LBB28:
	.loc 1 21 31 discriminator 1 view .LVU53
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 22 is_stmt 0 view .LVU54
	xor	ecx, ecx	# i
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 31 discriminator 1 view .LVU55
	test	rdx, rdx	# count
	je	.L23	#,
.LVL16:
	.p2align 4,,10
	.p2align 3
.L15:
.LBB29:
	.loc 1 23 9 is_stmt 1 view .LVU56
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU57
	mov	eax, DWORD PTR [rdi+rcx*4]	# MEM[(const uint32_t *)gray_16(D) + i_31 * 4], MEM[(const uint32_t *)gray_16(D) + i_31 * 4]
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU58
	lea	eax, 1[rax+rax*2]	# tmp97,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU59
	shr	eax	# tmp98
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU60
	sub	eax, 64	# _8,
	.loc 1 24 9 is_stmt 1 view .LVU61
.LVL17:
.LBB30:
.LBI30:
	.loc 2 257 5 view .LVU62
.LBB31:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 7 is_stmt 0 view .LVU63
	test	eax, eax	# _8
	jg	.L24	#,
	xor	eax, eax	# _8
.LVL18:
.L16:
	.loc 2 262 7 view .LVU64
.LBE31:
.LBE30:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU65
	mov	DWORD PTR [rsi+rcx*4], eax	# MEM[(uint32_t *)contrast_21(D) + i_31 * 4], _8
.LBE29:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU66
	add	rcx, 1	# i,
.LVL19:
	.loc 1 21 31 discriminator 1 view .LVU67
	cmp	rcx, rdx	# i, count
	jne	.L15	#,
	ret	
.LVL20:
	.p2align 4,,10
	.p2align 3
.L24:
.LBB34:
.LBB32:
.LBI32:
	.loc 2 233 5 view .LVU68
.LBB33:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 is_stmt 0 view .LVU69
	cmp	eax, 254	# _8,
	jle	.L16	#,
.LVL21:
	.loc 2 238 7 view .LVU70
.LBE33:
.LBE32:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU71
	mov	DWORD PTR [rsi+rcx*4], 255	# MEM[(uint32_t *)contrast_21(D) + i_31 * 4],
.LBE34:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU72
	add	rcx, 1	# i,
.LVL22:
	.loc 1 21 31 discriminator 1 view .LVU73
	cmp	rdx, rcx	# count, i
	jne	.L15	#,
.LVL23:
.L23:
	.loc 1 21 31 is_stmt 0 discriminator 1 view .LVU74
.LBE28:
# src/kernels.cpp:26: }
	.loc 1 26 1 view .LVU75
	ret	
	.cfi_endproc
.LFE701:
	.size	adjust_contrast, .-adjust_contrast
	.p2align 4
	.globl	horizontal_blur_5tap
	.type	horizontal_blur_5tap, @function
horizontal_blur_5tap:
.LVL24:
.LFB705:
	.loc 1 40 75 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 40 75 is_stmt 0 view .LVU77
	endbr64	
	.loc 1 41 5 is_stmt 1 view .LVU78
.LVL25:
.LBB53:
	.loc 1 41 31 discriminator 1 view .LVU79
	test	rcx, rcx	# height
	je	.L45	#,
.LBE53:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 is_stmt 0 view .LVU80
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	r9, rdi	# ivtmp.52, source
	mov	r10, rsi	# ivtmp.55, destination
.LBB85:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 22 view .LVU81
	xor	r11d, r11d	# y
.LBE85:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 view .LVU82
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	.cfi_offset 15, -24
.LBB86:
.LBB54:
.LBB55:
.LBB56:
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 54 view .LVU83
	lea	r15, -1[rdx]	# _102,
.LBE56:
.LBE55:
.LBE54:
.LBE86:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 view .LVU84
	push	r14	#
	.cfi_offset 14, -32
	mov	r14, rcx	# height, tmp168
	push	r13	#
	.cfi_offset 13, -40
.LBB87:
.LBB81:
.LBB62:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 discriminator 1 view .LVU85
	lea	r13, -2[rdx]	# _143,
.LBE62:
.LBE81:
.LBE87:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 view .LVU86
	push	r12	#
	.cfi_offset 12, -48
	mov	r12, rdx	# width, tmp167
	push	rbx	#
	.cfi_offset 3, -56
.LBB88:
.LBB82:
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 22 view .LVU87
	lea	rbx, 0[0+rdx*4]	# _37,
.LBE82:
.LBE88:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 view .LVU88
	sub	rsp, 24	#,
.LVL26:
	.p2align 4,,10
	.p2align 3
.L33:
.LBB89:
.LBB83:
	.loc 1 42 9 is_stmt 1 view .LVU89
	.loc 1 43 9 view .LVU90
	.loc 1 44 9 view .LVU91
.LBB63:
	cmp	r12, 4	# width,
	jbe	.L48	#,
.LBE63:
	.loc 1 50 9 view .LVU92
.LVL27:
.LBB65:
.LBI55:
	.loc 1 28 22 view .LVU93
.LBB57:
	.loc 1 30 5 view .LVU94
	.loc 1 31 5 view .LVU95
	.loc 1 32 5 view .LVU96
	.loc 1 33 5 view .LVU97
	.loc 1 34 5 view .LVU98
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 42 is_stmt 0 view .LVU99
	mov	ecx, DWORD PTR [r9]	# _17, MEM[(const uint32_t *)row_56]
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 44 view .LVU100
	mov	edx, DWORD PTR 8[r9]	# _24, MEM[(const uint32_t *)row_56 + 8B]
.LVL28:
	.loc 1 35 44 view .LVU101
.LBE57:
.LBE65:
.LBB66:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 26 view .LVU102
	mov	QWORD PTR -56[rbp], rbx	# %sfp, _37
.LBE66:
.LBB67:
.LBB58:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 30 view .LVU103
	mov	esi, DWORD PTR 4[r9]	# _128, MEM[(const uint32_t *)row_56 + 4B]
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU104
	lea	eax, 0[0+rcx*4]	# tmp131,
	lea	r8d, 8[rcx]	# _48,
	lea	edi, [rax+rcx]	# tmp132,
.LBE58:
.LBE67:
.LBB68:
.LBB69:
	add	eax, r8d	# tmp140, _48
	add	eax, DWORD PTR 12[r9]	# tmp141, MEM[(const uint32_t *)row_56 + 12B]
.LBE69:
.LBE68:
.LBB73:
.LBB59:
	lea	edi, [rdx+rdi*2]	# tmp134,
	add	edi, r8d	# tmp135, _48
	lea	edi, [rdi+rsi*4]	# tmp137,
.LBE59:
.LBE73:
.LBB74:
.LBB70:
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 47 view .LVU105
	lea	esi, [rsi+rsi*2]	# tmp145,
.LBE70:
.LBE74:
.LBB75:
.LBB60:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 view .LVU106
	shr	edi, 4	# tmp138,
.LBE60:
.LBE75:
.LBB76:
.LBB71:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU107
	lea	eax, [rax+rsi*2]	# tmp147,
	lea	eax, [rax+rdx*4]	# tmp149,
.LBE71:
.LBE76:
.LBB77:
.LBB61:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 view .LVU108
	mov	DWORD PTR [r10], edi	# MEM[(uint32_t *)out_58], tmp138
.LBE61:
.LBE77:
	.loc 1 51 9 is_stmt 1 view .LVU109
.LVL29:
.LBB78:
.LBI68:
	.loc 1 28 22 view .LVU110
.LBB72:
	.loc 1 30 5 view .LVU111
	.loc 1 31 5 view .LVU112
	.loc 1 32 5 view .LVU113
	.loc 1 33 5 view .LVU114
	.loc 1 34 5 view .LVU115
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 is_stmt 0 view .LVU116
	shr	eax, 4	# tmp150,
	mov	DWORD PTR 4[r10], eax	# MEM[(uint32_t *)out_58 + 4B], tmp150
.LBE72:
.LBE78:
	.loc 1 53 9 is_stmt 1 view .LVU117
.LVL30:
.LBB79:
	.loc 1 53 35 discriminator 1 view .LVU118
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 26 is_stmt 0 view .LVU119
	mov	eax, 2	# x,
.LVL31:
	.p2align 4,,10
	.p2align 3
.L32:
	.loc 1 54 13 is_stmt 1 view .LVU120
	mov	edi, ecx	# prephitmp_118, _17
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 50 is_stmt 0 view .LVU121
	mov	ecx, DWORD PTR -4[r9+rax*4]	# _17, MEM[(const uint32_t *)row_56 + -4B + x_73 * 4]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU122
	add	rax, 1	# x,
.LVL32:
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU123
	lea	esi, [rdx+rdx*2]	# tmp153,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU124
	mov	edx, DWORD PTR [r9+rax*4]	# _24, MEM[(const uint32_t *)row_56 + _21 * 4]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU125
	mov	r8d, DWORD PTR 4[r9+rax*4]	# MEM[(const uint32_t *)row_56 + 4B + _21 * 4], MEM[(const uint32_t *)row_56 + 4B + _21 * 4]
	lea	ebx, [rcx+rdx]	# tmp157,
	lea	r8d, 8[r8+rbx*4]	# tmp159,
	add	edi, r8d	# tmp160, tmp159
	lea	esi, [rdi+rsi*2]	# tmp161,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU126
	shr	esi, 4	# tmp162,
	mov	DWORD PTR -4[r10+rax*4], esi	# MEM[(uint32_t *)out_58 + -4B + _21 * 4], tmp162
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU127
.LVL33:
	.loc 1 53 35 discriminator 1 view .LVU128
	cmp	rax, r13	# x, _143
	jne	.L32	#,
.LBE79:
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 38 is_stmt 0 view .LVU129
	mov	rdx, r12	#, width
	mov	rsi, r13	#, _143
	mov	rdi, r9	#, ivtmp.52
	mov	rbx, QWORD PTR -56[rbp]	# _37, %sfp
	.loc 1 57 9 is_stmt 1 view .LVU130
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 38 is_stmt 0 view .LVU131
	call	blurred_edge	#
.LVL34:
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38 view .LVU132
	mov	rdx, r12	#, width
	mov	rsi, r15	#, _102
	mov	rdi, r9	#, ivtmp.52
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 24 discriminator 1 view .LVU133
	mov	DWORD PTR -8[r10+r12*4], eax	# MEM[(uint32_t *)out_58 + -8B + width_54(D) * 4], tmp173
	.loc 1 58 9 is_stmt 1 view .LVU134
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38 is_stmt 0 view .LVU135
	call	blurred_edge	#
.LVL35:
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 24 discriminator 1 view .LVU136
	mov	DWORD PTR -4[r10+r12*4], eax	# MEM[(uint32_t *)out_58 + -4B + width_54(D) * 4], tmp174
.LVL36:
.L29:
	.loc 1 58 24 discriminator 1 view .LVU137
.LBE83:
	.loc 1 41 5 is_stmt 1 discriminator 2 view .LVU138
	add	r11, 1	# y,
.LVL37:
	.loc 1 41 31 discriminator 1 view .LVU139
	add	r9, rbx	# ivtmp.52, _37
.LVL38:
	.loc 1 41 31 is_stmt 0 discriminator 1 view .LVU140
	add	r10, rbx	# ivtmp.55, _37
.LVL39:
	.loc 1 41 31 discriminator 1 view .LVU141
	cmp	r14, r11	# height, y
	jne	.L33	#,
.LBE89:
# src/kernels.cpp:60: }
	.loc 1 60 1 view .LVU142
	add	rsp, 24	#,
	pop	rbx	#
	pop	r12	#
.LVL40:
	.loc 1 60 1 view .LVU143
	pop	r13	#
.LVL41:
	.loc 1 60 1 view .LVU144
	pop	r14	#
.LVL42:
	.loc 1 60 1 view .LVU145
	pop	r15	#
.LVL43:
	.loc 1 60 1 view .LVU146
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.LVL44:
	.p2align 4,,10
	.p2align 3
.L48:
	.cfi_restore_state
.LBB90:
.LBB84:
.LBB80:
.LBB64:
	.loc 1 45 39 is_stmt 1 discriminator 1 view .LVU147
	test	r12, r12	# width
	je	.L29	#,
	.loc 1 46 17 view .LVU148
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU149
	mov	rdx, r12	#, width
	xor	esi, esi	#
	mov	rdi, r9	#, ivtmp.52
	call	blurred_edge	#
.LVL45:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU150
	mov	DWORD PTR [r10], eax	# MEM[(uint32_t *)out_58], tmp169
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU151
.LVL46:
	.loc 1 45 39 discriminator 1 view .LVU152
	cmp	r12, 1	# width,
	je	.L29	#,
	.loc 1 46 17 view .LVU153
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU154
	mov	rdx, r12	#, width
	mov	esi, 1	#,
	mov	rdi, r9	#, ivtmp.52
	call	blurred_edge	#
.LVL47:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU155
	mov	DWORD PTR 4[r10], eax	# MEM[(uint32_t *)out_58 + 4B], tmp170
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU156
.LVL48:
	.loc 1 45 39 discriminator 1 view .LVU157
	cmp	r12, 2	# width,
	je	.L29	#,
	.loc 1 46 17 view .LVU158
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU159
	mov	rdx, r12	#, width
	mov	esi, 2	#,
	mov	rdi, r9	#, ivtmp.52
	call	blurred_edge	#
.LVL49:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU160
	mov	DWORD PTR 8[r10], eax	# MEM[(uint32_t *)out_58 + 8B], tmp171
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU161
.LVL50:
	.loc 1 45 39 discriminator 1 view .LVU162
	cmp	r12, 4	# width,
	jne	.L29	#,
	.loc 1 46 17 view .LVU163
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU164
	mov	edx, 4	#,
	mov	esi, 3	#,
	mov	rdi, r9	#, ivtmp.52
	call	blurred_edge	#
.LVL51:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU165
	mov	DWORD PTR 12[r10], eax	# MEM[(uint32_t *)out_58 + 12B], tmp172
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU166
.LVL52:
	.loc 1 45 39 discriminator 1 view .LVU167
	jmp	.L29	#
.LVL53:
.L45:
	.cfi_def_cfa 7, 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	.loc 1 45 39 is_stmt 0 discriminator 1 view .LVU168
	ret	
.LBE64:
.LBE80:
.LBE84:
.LBE90:
	.cfi_endproc
.LFE705:
	.size	horizontal_blur_5tap, .-horizontal_blur_5tap
.Letext0:
	.file 3 "/usr/lib/gcc/x86_64-linux-gnu/13/include/stddef.h"
	.file 4 "/usr/include/c++/13/cstddef"
	.file 5 "/usr/include/c++/13/cstdint"
	.file 6 "/usr/include/x86_64-linux-gnu/c++/13/bits/c++config.h"
	.file 7 "/usr/include/c++/13/type_traits"
	.file 8 "/usr/include/c++/13/debug/debug.h"
	.file 9 "/usr/include/c++/13/cstdlib"
	.file 10 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 11 "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h"
	.file 12 "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h"
	.file 13 "/usr/include/x86_64-linux-gnu/bits/stdint-least.h"
	.file 14 "/usr/include/stdint.h"
	.file 15 "/usr/include/c++/13/bits/predefined_ops.h"
	.file 16 "/usr/include/stdlib.h"
	.file 17 "/usr/include/x86_64-linux-gnu/bits/stdlib-float.h"
	.file 18 "/usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h"
	.file 19 "/usr/include/x86_64-linux-gnu/bits/stdlib.h"
	.file 20 "/usr/include/c++/13/pstl/execution_defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xfb7
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x27
	.long	.LASF137
	.byte	0x21
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF2
	.uleb128 0x3
	.long	.LASF8
	.byte	0x3
	.byte	0xd6
	.byte	0x17
	.long	0x41
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0xb
	.long	0x41
	.uleb128 0x28
	.byte	0x20
	.byte	0x10
	.byte	0x3
	.value	0x1a9
	.byte	0x10
	.long	.LASF138
	.long	0x79
	.uleb128 0x1d
	.long	.LASF4
	.value	0x1aa
	.byte	0xd
	.long	0x79
	.byte	0x8
	.byte	0
	.uleb128 0x1d
	.long	.LASF5
	.value	0x1ab
	.byte	0xf
	.long	0x80
	.byte	0x10
	.byte	0x10
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x4
	.byte	0x10
	.byte	0x4
	.long	.LASF7
	.uleb128 0x29
	.long	.LASF139
	.byte	0x3
	.value	0x1b4
	.byte	0x3
	.long	0x4d
	.byte	0x10
	.uleb128 0x2a
	.string	"std"
	.byte	0x6
	.value	0x132
	.byte	0xb
	.long	0x329
	.uleb128 0x1
	.byte	0x4
	.byte	0x3a
	.byte	0xb
	.long	0x87
	.uleb128 0x1
	.byte	0x5
	.byte	0x33
	.byte	0xb
	.long	0x443
	.uleb128 0x1
	.byte	0x5
	.byte	0x34
	.byte	0xb
	.long	0x44f
	.uleb128 0x1
	.byte	0x5
	.byte	0x35
	.byte	0xb
	.long	0x45b
	.uleb128 0x1
	.byte	0x5
	.byte	0x36
	.byte	0xb
	.long	0x46c
	.uleb128 0x1
	.byte	0x5
	.byte	0x38
	.byte	0xb
	.long	0x50d
	.uleb128 0x1
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.long	0x519
	.uleb128 0x1
	.byte	0x5
	.byte	0x3a
	.byte	0xb
	.long	0x525
	.uleb128 0x1
	.byte	0x5
	.byte	0x3b
	.byte	0xb
	.long	0x531
	.uleb128 0x1
	.byte	0x5
	.byte	0x3d
	.byte	0xb
	.long	0x4ad
	.uleb128 0x1
	.byte	0x5
	.byte	0x3e
	.byte	0xb
	.long	0x4b9
	.uleb128 0x1
	.byte	0x5
	.byte	0x3f
	.byte	0xb
	.long	0x4c5
	.uleb128 0x1
	.byte	0x5
	.byte	0x40
	.byte	0xb
	.long	0x4d1
	.uleb128 0x1
	.byte	0x5
	.byte	0x42
	.byte	0xb
	.long	0x585
	.uleb128 0x1
	.byte	0x5
	.byte	0x43
	.byte	0xb
	.long	0x56d
	.uleb128 0x1
	.byte	0x5
	.byte	0x45
	.byte	0xb
	.long	0x478
	.uleb128 0x1
	.byte	0x5
	.byte	0x46
	.byte	0xb
	.long	0x484
	.uleb128 0x1
	.byte	0x5
	.byte	0x47
	.byte	0xb
	.long	0x490
	.uleb128 0x1
	.byte	0x5
	.byte	0x48
	.byte	0xb
	.long	0x4a1
	.uleb128 0x1
	.byte	0x5
	.byte	0x4a
	.byte	0xb
	.long	0x53d
	.uleb128 0x1
	.byte	0x5
	.byte	0x4b
	.byte	0xb
	.long	0x549
	.uleb128 0x1
	.byte	0x5
	.byte	0x4c
	.byte	0xb
	.long	0x555
	.uleb128 0x1
	.byte	0x5
	.byte	0x4d
	.byte	0xb
	.long	0x561
	.uleb128 0x1
	.byte	0x5
	.byte	0x4f
	.byte	0xb
	.long	0x4dd
	.uleb128 0x1
	.byte	0x5
	.byte	0x50
	.byte	0xb
	.long	0x4e9
	.uleb128 0x1
	.byte	0x5
	.byte	0x51
	.byte	0xb
	.long	0x4f5
	.uleb128 0x1
	.byte	0x5
	.byte	0x52
	.byte	0xb
	.long	0x501
	.uleb128 0x1
	.byte	0x5
	.byte	0x54
	.byte	0xb
	.long	0x591
	.uleb128 0x1
	.byte	0x5
	.byte	0x55
	.byte	0xb
	.long	0x579
	.uleb128 0x1e
	.long	.LASF8
	.byte	0x6
	.value	0x134
	.byte	0x1a
	.long	0x41
	.uleb128 0xb
	.long	0x18a
	.uleb128 0x1f
	.long	.LASF9
	.value	0xab0
	.uleb128 0x1f
	.long	.LASF10
	.value	0xb06
	.uleb128 0x20
	.long	.LASF11
	.byte	0x8
	.byte	0x32
	.byte	0xd
	.uleb128 0x1
	.byte	0x9
	.byte	0x83
	.byte	0xb
	.long	0x673
	.uleb128 0x1
	.byte	0x9
	.byte	0x84
	.byte	0xb
	.long	0x6a2
	.uleb128 0x1
	.byte	0x9
	.byte	0x8a
	.byte	0xb
	.long	0x70e
	.uleb128 0x1
	.byte	0x9
	.byte	0x8d
	.byte	0xb
	.long	0x72a
	.uleb128 0x1
	.byte	0x9
	.byte	0x90
	.byte	0xb
	.long	0x745
	.uleb128 0x1
	.byte	0x9
	.byte	0x91
	.byte	0xb
	.long	0x75b
	.uleb128 0x1
	.byte	0x9
	.byte	0x92
	.byte	0xb
	.long	0x771
	.uleb128 0x1
	.byte	0x9
	.byte	0x93
	.byte	0xb
	.long	0x787
	.uleb128 0x1
	.byte	0x9
	.byte	0x95
	.byte	0xb
	.long	0x7b1
	.uleb128 0x1
	.byte	0x9
	.byte	0x98
	.byte	0xb
	.long	0x7cd
	.uleb128 0x1
	.byte	0x9
	.byte	0x9a
	.byte	0xb
	.long	0x7e3
	.uleb128 0x1
	.byte	0x9
	.byte	0x9d
	.byte	0xb
	.long	0x7fe
	.uleb128 0x1
	.byte	0x9
	.byte	0x9e
	.byte	0xb
	.long	0x819
	.uleb128 0x1
	.byte	0x9
	.byte	0x9f
	.byte	0xb
	.long	0x83e
	.uleb128 0x1
	.byte	0x9
	.byte	0xa1
	.byte	0xb
	.long	0x85e
	.uleb128 0x1
	.byte	0x9
	.byte	0xa4
	.byte	0xb
	.long	0x87e
	.uleb128 0x1
	.byte	0x9
	.byte	0xa7
	.byte	0xb
	.long	0x891
	.uleb128 0x1
	.byte	0x9
	.byte	0xa9
	.byte	0xb
	.long	0x89e
	.uleb128 0x1
	.byte	0x9
	.byte	0xaa
	.byte	0xb
	.long	0x8af
	.uleb128 0x1
	.byte	0x9
	.byte	0xab
	.byte	0xb
	.long	0x8cf
	.uleb128 0x1
	.byte	0x9
	.byte	0xac
	.byte	0xb
	.long	0x8f3
	.uleb128 0x1
	.byte	0x9
	.byte	0xad
	.byte	0xb
	.long	0x917
	.uleb128 0x1
	.byte	0x9
	.byte	0xaf
	.byte	0xb
	.long	0x92d
	.uleb128 0x1
	.byte	0x9
	.byte	0xb0
	.byte	0xb
	.long	0x952
	.uleb128 0x1
	.byte	0x9
	.byte	0xf4
	.byte	0x16
	.long	0x6d1
	.uleb128 0x1
	.byte	0x9
	.byte	0xf9
	.byte	0x16
	.long	0x5f1
	.uleb128 0x1
	.byte	0x9
	.byte	0xfa
	.byte	0x16
	.long	0x96d
	.uleb128 0x1
	.byte	0x9
	.byte	0xfc
	.byte	0x16
	.long	0x988
	.uleb128 0x1
	.byte	0x9
	.byte	0xfd
	.byte	0x16
	.long	0x9e6
	.uleb128 0x1
	.byte	0x9
	.byte	0xfe
	.byte	0x16
	.long	0x99e
	.uleb128 0x1
	.byte	0x9
	.byte	0xff
	.byte	0x16
	.long	0x9c2
	.uleb128 0x2b
	.byte	0x9
	.value	0x100
	.byte	0x16
	.long	0xa01
	.uleb128 0xe
	.long	.LASF12
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF14
	.long	0xa38
	.long	0x2db
	.uleb128 0xf
	.string	"_Tp"
	.long	0x388
	.uleb128 0x2
	.long	0xa38
	.uleb128 0x2
	.long	0xa38
	.byte	0
	.uleb128 0xe
	.long	.LASF13
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF15
	.long	0xd59
	.long	0x303
	.uleb128 0xf
	.string	"_Tp"
	.long	0x41
	.uleb128 0x2
	.long	0xd59
	.uleb128 0x2
	.long	0xd59
	.byte	0
	.uleb128 0x2c
	.long	.LASF71
	.byte	0x2
	.value	0x101
	.byte	0x5
	.long	.LASF140
	.long	0xa38
	.uleb128 0xf
	.string	"_Tp"
	.long	0x388
	.uleb128 0x2
	.long	0xa38
	.uleb128 0x2
	.long	0xa38
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF16
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF17
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF18
	.uleb128 0x3
	.long	.LASF19
	.byte	0xa
	.byte	0x25
	.byte	0x15
	.long	0x34a
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF20
	.uleb128 0x3
	.long	.LASF21
	.byte	0xa
	.byte	0x26
	.byte	0x17
	.long	0x329
	.uleb128 0x3
	.long	.LASF22
	.byte	0xa
	.byte	0x27
	.byte	0x1a
	.long	0x369
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.long	.LASF23
	.uleb128 0x3
	.long	.LASF24
	.byte	0xa
	.byte	0x28
	.byte	0x1c
	.long	0x330
	.uleb128 0x3
	.long	.LASF25
	.byte	0xa
	.byte	0x29
	.byte	0x14
	.long	0x388
	.uleb128 0x2d
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xb
	.long	0x388
	.uleb128 0x3
	.long	.LASF26
	.byte	0xa
	.byte	0x2a
	.byte	0x16
	.long	0x337
	.uleb128 0x3
	.long	.LASF27
	.byte	0xa
	.byte	0x2c
	.byte	0x19
	.long	0x2e
	.uleb128 0x3
	.long	.LASF28
	.byte	0xa
	.byte	0x2d
	.byte	0x1b
	.long	0x41
	.uleb128 0x3
	.long	.LASF29
	.byte	0xa
	.byte	0x34
	.byte	0x12
	.long	0x33e
	.uleb128 0x3
	.long	.LASF30
	.byte	0xa
	.byte	0x35
	.byte	0x13
	.long	0x351
	.uleb128 0x3
	.long	.LASF31
	.byte	0xa
	.byte	0x36
	.byte	0x13
	.long	0x35d
	.uleb128 0x3
	.long	.LASF32
	.byte	0xa
	.byte	0x37
	.byte	0x14
	.long	0x370
	.uleb128 0x3
	.long	.LASF33
	.byte	0xa
	.byte	0x38
	.byte	0x13
	.long	0x37c
	.uleb128 0x3
	.long	.LASF34
	.byte	0xa
	.byte	0x39
	.byte	0x14
	.long	0x394
	.uleb128 0x3
	.long	.LASF35
	.byte	0xa
	.byte	0x3a
	.byte	0x13
	.long	0x3a0
	.uleb128 0x3
	.long	.LASF36
	.byte	0xa
	.byte	0x3b
	.byte	0x14
	.long	0x3ac
	.uleb128 0x3
	.long	.LASF37
	.byte	0xa
	.byte	0x48
	.byte	0x12
	.long	0x2e
	.uleb128 0x3
	.long	.LASF38
	.byte	0xa
	.byte	0x49
	.byte	0x1b
	.long	0x41
	.uleb128 0x2e
	.byte	0x8
	.uleb128 0x6
	.long	0x437
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF39
	.uleb128 0xb
	.long	0x437
	.uleb128 0x3
	.long	.LASF40
	.byte	0xb
	.byte	0x18
	.byte	0x12
	.long	0x33e
	.uleb128 0x3
	.long	.LASF41
	.byte	0xb
	.byte	0x19
	.byte	0x13
	.long	0x35d
	.uleb128 0x3
	.long	.LASF42
	.byte	0xb
	.byte	0x1a
	.byte	0x13
	.long	0x37c
	.uleb128 0xb
	.long	0x45b
	.uleb128 0x3
	.long	.LASF43
	.byte	0xb
	.byte	0x1b
	.byte	0x13
	.long	0x3a0
	.uleb128 0x3
	.long	.LASF44
	.byte	0xc
	.byte	0x18
	.byte	0x13
	.long	0x351
	.uleb128 0x3
	.long	.LASF45
	.byte	0xc
	.byte	0x19
	.byte	0x14
	.long	0x370
	.uleb128 0x3
	.long	.LASF46
	.byte	0xc
	.byte	0x1a
	.byte	0x14
	.long	0x394
	.uleb128 0xb
	.long	0x490
	.uleb128 0x3
	.long	.LASF47
	.byte	0xc
	.byte	0x1b
	.byte	0x14
	.long	0x3ac
	.uleb128 0x3
	.long	.LASF48
	.byte	0xd
	.byte	0x19
	.byte	0x18
	.long	0x3b8
	.uleb128 0x3
	.long	.LASF49
	.byte	0xd
	.byte	0x1a
	.byte	0x19
	.long	0x3d0
	.uleb128 0x3
	.long	.LASF50
	.byte	0xd
	.byte	0x1b
	.byte	0x19
	.long	0x3e8
	.uleb128 0x3
	.long	.LASF51
	.byte	0xd
	.byte	0x1c
	.byte	0x19
	.long	0x400
	.uleb128 0x3
	.long	.LASF52
	.byte	0xd
	.byte	0x1f
	.byte	0x19
	.long	0x3c4
	.uleb128 0x3
	.long	.LASF53
	.byte	0xd
	.byte	0x20
	.byte	0x1a
	.long	0x3dc
	.uleb128 0x3
	.long	.LASF54
	.byte	0xd
	.byte	0x21
	.byte	0x1a
	.long	0x3f4
	.uleb128 0x3
	.long	.LASF55
	.byte	0xd
	.byte	0x22
	.byte	0x1a
	.long	0x40c
	.uleb128 0x3
	.long	.LASF56
	.byte	0xe
	.byte	0x2f
	.byte	0x16
	.long	0x34a
	.uleb128 0x3
	.long	.LASF57
	.byte	0xe
	.byte	0x31
	.byte	0x13
	.long	0x2e
	.uleb128 0x3
	.long	.LASF58
	.byte	0xe
	.byte	0x32
	.byte	0x13
	.long	0x2e
	.uleb128 0x3
	.long	.LASF59
	.byte	0xe
	.byte	0x33
	.byte	0x13
	.long	0x2e
	.uleb128 0x3
	.long	.LASF60
	.byte	0xe
	.byte	0x3c
	.byte	0x18
	.long	0x329
	.uleb128 0x3
	.long	.LASF61
	.byte	0xe
	.byte	0x3e
	.byte	0x1b
	.long	0x41
	.uleb128 0x3
	.long	.LASF62
	.byte	0xe
	.byte	0x3f
	.byte	0x1b
	.long	0x41
	.uleb128 0x3
	.long	.LASF63
	.byte	0xe
	.byte	0x40
	.byte	0x1b
	.long	0x41
	.uleb128 0x3
	.long	.LASF64
	.byte	0xe
	.byte	0x4c
	.byte	0x13
	.long	0x2e
	.uleb128 0x3
	.long	.LASF65
	.byte	0xe
	.byte	0x4f
	.byte	0x1b
	.long	0x41
	.uleb128 0x3
	.long	.LASF66
	.byte	0xe
	.byte	0x5a
	.byte	0x15
	.long	0x418
	.uleb128 0x3
	.long	.LASF67
	.byte	0xe
	.byte	0x5b
	.byte	0x16
	.long	0x424
	.uleb128 0x4
	.byte	0x1
	.byte	0x2
	.long	.LASF68
	.uleb128 0x2f
	.long	.LASF69
	.byte	0x6
	.value	0x157
	.byte	0xb
	.long	0x60d
	.uleb128 0x20
	.long	.LASF70
	.byte	0xf
	.byte	0x25
	.byte	0xb
	.uleb128 0x1
	.byte	0x9
	.byte	0xcc
	.byte	0xb
	.long	0x6d1
	.uleb128 0x1
	.byte	0x9
	.byte	0xdc
	.byte	0xb
	.long	0x96d
	.uleb128 0x1
	.byte	0x9
	.byte	0xe7
	.byte	0xb
	.long	0x988
	.uleb128 0x1
	.byte	0x9
	.byte	0xe8
	.byte	0xb
	.long	0x99e
	.uleb128 0x1
	.byte	0x9
	.byte	0xe9
	.byte	0xb
	.long	0x9c2
	.uleb128 0x1
	.byte	0x9
	.byte	0xeb
	.byte	0xb
	.long	0x9e6
	.uleb128 0x1
	.byte	0x9
	.byte	0xec
	.byte	0xb
	.long	0xa01
	.uleb128 0x30
	.string	"div"
	.byte	0x9
	.byte	0xd9
	.byte	0x3
	.long	.LASF141
	.long	0x6d1
	.uleb128 0x2
	.long	0x79
	.uleb128 0x2
	.long	0x79
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF72
	.uleb128 0x4
	.byte	0x8
	.byte	0x4
	.long	.LASF73
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.long	.LASF74
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.long	.LASF75
	.uleb128 0xb
	.long	0x622
	.uleb128 0x4
	.byte	0x2
	.byte	0x10
	.long	.LASF76
	.uleb128 0x4
	.byte	0x4
	.byte	0x10
	.long	.LASF77
	.uleb128 0x21
	.long	.LASF78
	.byte	0x8
	.byte	0x38
	.long	0x650
	.uleb128 0x31
	.byte	0x8
	.byte	0x3a
	.byte	0x18
	.long	0x1aa
	.byte	0
	.uleb128 0x17
	.byte	0x8
	.byte	0x3c
	.long	.LASF81
	.long	0x673
	.uleb128 0x18
	.long	.LASF79
	.byte	0x3d
	.byte	0x9
	.long	0x388
	.uleb128 0x19
	.string	"rem"
	.byte	0x3e
	.byte	0x9
	.long	0x388
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.long	.LASF80
	.byte	0x10
	.byte	0x3f
	.byte	0x5
	.long	0x650
	.uleb128 0x17
	.byte	0x10
	.byte	0x44
	.long	.LASF82
	.long	0x6a2
	.uleb128 0x18
	.long	.LASF79
	.byte	0x45
	.byte	0xe
	.long	0x2e
	.uleb128 0x19
	.string	"rem"
	.byte	0x46
	.byte	0xe
	.long	0x2e
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF83
	.byte	0x10
	.byte	0x47
	.byte	0x5
	.long	0x67f
	.uleb128 0x17
	.byte	0x10
	.byte	0x4e
	.long	.LASF84
	.long	0x6d1
	.uleb128 0x18
	.long	.LASF79
	.byte	0x4f
	.byte	0x13
	.long	0x79
	.uleb128 0x19
	.string	"rem"
	.byte	0x50
	.byte	0x13
	.long	0x79
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF85
	.byte	0x10
	.byte	0x51
	.byte	0x5
	.long	0x6ae
	.uleb128 0x6
	.long	0x43e
	.uleb128 0x1e
	.long	.LASF86
	.byte	0x10
	.value	0x3b4
	.byte	0xf
	.long	0x6ef
	.uleb128 0x6
	.long	0x6f4
	.uleb128 0x32
	.long	0x388
	.long	0x708
	.uleb128 0x2
	.long	0x708
	.uleb128 0x2
	.long	0x708
	.byte	0
	.uleb128 0x6
	.long	0x70d
	.uleb128 0x33
	.uleb128 0x7
	.long	.LASF87
	.value	0x2de
	.byte	0xc
	.long	0x388
	.long	0x724
	.uleb128 0x2
	.long	0x724
	.byte	0
	.uleb128 0x6
	.long	0x729
	.uleb128 0x34
	.uleb128 0x35
	.long	.LASF88
	.byte	0x10
	.value	0x2e3
	.byte	0x12
	.long	.LASF88
	.long	0x388
	.long	0x745
	.uleb128 0x2
	.long	0x724
	.byte	0
	.uleb128 0x9
	.long	.LASF89
	.byte	0x11
	.byte	0x19
	.byte	0x1
	.long	0x614
	.long	0x75b
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0x7
	.long	.LASF90
	.value	0x1e1
	.byte	0x1
	.long	0x388
	.long	0x771
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0x7
	.long	.LASF91
	.value	0x1e6
	.byte	0x1
	.long	0x2e
	.long	0x787
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0x9
	.long	.LASF92
	.byte	0x12
	.byte	0x14
	.byte	0x1
	.long	0x430
	.long	0x7b1
	.uleb128 0x2
	.long	0x708
	.uleb128 0x2
	.long	0x708
	.uleb128 0x2
	.long	0x35
	.uleb128 0x2
	.long	0x35
	.uleb128 0x2
	.long	0x6e2
	.byte	0
	.uleb128 0x36
	.string	"div"
	.byte	0x10
	.value	0x3e0
	.byte	0xe
	.long	0x673
	.long	0x7cd
	.uleb128 0x2
	.long	0x388
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0x7
	.long	.LASF93
	.value	0x305
	.byte	0xe
	.long	0x432
	.long	0x7e3
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0x7
	.long	.LASF94
	.value	0x3e2
	.byte	0xf
	.long	0x6a2
	.long	0x7fe
	.uleb128 0x2
	.long	0x2e
	.uleb128 0x2
	.long	0x2e
	.byte	0
	.uleb128 0x7
	.long	.LASF95
	.value	0x426
	.byte	0xc
	.long	0x388
	.long	0x819
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x35
	.byte	0
	.uleb128 0x9
	.long	.LASF96
	.byte	0x13
	.byte	0x75
	.byte	0x1
	.long	0x35
	.long	0x839
	.uleb128 0x2
	.long	0x839
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x35
	.byte	0
	.uleb128 0x6
	.long	0x622
	.uleb128 0x7
	.long	.LASF97
	.value	0x429
	.byte	0xc
	.long	0x388
	.long	0x85e
	.uleb128 0x2
	.long	0x839
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x35
	.byte	0
	.uleb128 0x22
	.long	.LASF99
	.value	0x3ca
	.long	0x87e
	.uleb128 0x2
	.long	0x430
	.uleb128 0x2
	.long	0x35
	.uleb128 0x2
	.long	0x35
	.uleb128 0x2
	.long	0x6e2
	.byte	0
	.uleb128 0x37
	.long	.LASF98
	.byte	0x10
	.value	0x2fa
	.byte	0xd
	.long	0x891
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0x38
	.long	.LASF142
	.byte	0x10
	.value	0x23d
	.byte	0xc
	.long	0x388
	.uleb128 0x22
	.long	.LASF100
	.value	0x23f
	.long	0x8af
	.uleb128 0x2
	.long	0x337
	.byte	0
	.uleb128 0x9
	.long	.LASF101
	.byte	0x10
	.byte	0x76
	.byte	0xf
	.long	0x614
	.long	0x8ca
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.byte	0
	.uleb128 0x6
	.long	0x432
	.uleb128 0xe
	.long	.LASF102
	.byte	0x10
	.byte	0xd7
	.byte	0x11
	.long	.LASF103
	.long	0x2e
	.long	0x8f3
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0xe
	.long	.LASF104
	.byte	0x10
	.byte	0xdb
	.byte	0x1a
	.long	.LASF105
	.long	0x41
	.long	0x917
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0x7
	.long	.LASF106
	.value	0x39b
	.byte	0xc
	.long	0x388
	.long	0x92d
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0x9
	.long	.LASF107
	.byte	0x13
	.byte	0x8f
	.byte	0x1
	.long	0x35
	.long	0x94d
	.uleb128 0x2
	.long	0x432
	.uleb128 0x2
	.long	0x94d
	.uleb128 0x2
	.long	0x35
	.byte	0
	.uleb128 0x6
	.long	0x629
	.uleb128 0x9
	.long	.LASF108
	.byte	0x13
	.byte	0x4f
	.byte	0x1
	.long	0x388
	.long	0x96d
	.uleb128 0x2
	.long	0x432
	.uleb128 0x2
	.long	0x622
	.byte	0
	.uleb128 0x7
	.long	.LASF109
	.value	0x3e6
	.byte	0x1e
	.long	0x6d1
	.long	0x988
	.uleb128 0x2
	.long	0x79
	.uleb128 0x2
	.long	0x79
	.byte	0
	.uleb128 0x7
	.long	.LASF110
	.value	0x1ed
	.byte	0x1
	.long	0x79
	.long	0x99e
	.uleb128 0x2
	.long	0x6dd
	.byte	0
	.uleb128 0xe
	.long	.LASF111
	.byte	0x10
	.byte	0xee
	.byte	0x16
	.long	.LASF112
	.long	0x79
	.long	0x9c2
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0xe
	.long	.LASF113
	.byte	0x10
	.byte	0xf3
	.byte	0x1f
	.long	.LASF114
	.long	0x60d
	.long	0x9e6
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0x9
	.long	.LASF115
	.byte	0x10
	.byte	0x7c
	.byte	0xe
	.long	0x61b
	.long	0xa01
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.byte	0
	.uleb128 0x9
	.long	.LASF116
	.byte	0x10
	.byte	0x7f
	.byte	0x14
	.long	0x80
	.long	0xa1c
	.uleb128 0x2
	.long	0x6dd
	.uleb128 0x2
	.long	0x8ca
	.byte	0
	.uleb128 0x21
	.long	.LASF117
	.byte	0x14
	.byte	0xf
	.long	0xa38
	.uleb128 0x39
	.long	.LASF143
	.byte	0x14
	.byte	0x11
	.byte	0xb
	.uleb128 0x3a
	.string	"v1"
	.byte	0x14
	.byte	0x13
	.byte	0x12
	.byte	0
	.byte	0
	.uleb128 0x23
	.long	0x38f
	.uleb128 0x1a
	.long	0x2b3
	.long	0xa68
	.uleb128 0xf
	.string	"_Tp"
	.long	0x388
	.uleb128 0x10
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xa38
	.uleb128 0x10
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xa38
	.byte	0
	.uleb128 0x1b
	.long	.LASF126
	.byte	0x26
	.quad	.LFB705
	.quad	.LFE705-.LFB705
	.uleb128 0x1
	.byte	0x9c
	.long	0xce5
	.uleb128 0x11
	.long	.LASF118
	.byte	0x26
	.byte	0x41
	.long	0xcea
	.long	.LLST15
	.long	.LVUS15
	.uleb128 0x11
	.long	.LASF119
	.byte	0x27
	.byte	0x3b
	.long	0xcf4
	.long	.LLST16
	.long	.LVUS16
	.uleb128 0x11
	.long	.LASF120
	.byte	0x28
	.byte	0x27
	.long	0x18a
	.long	.LLST17
	.long	.LVUS17
	.uleb128 0x11
	.long	.LASF121
	.byte	0x28
	.byte	0x3a
	.long	0x18a
	.long	.LLST18
	.long	.LVUS18
	.uleb128 0x12
	.long	.LLRL19
	.uleb128 0xc
	.string	"y"
	.byte	0x29
	.byte	0x16
	.long	0x18a
	.long	.LLST20
	.long	.LVUS20
	.uleb128 0x12
	.long	.LLRL21
	.uleb128 0xc
	.string	"row"
	.byte	0x2a
	.byte	0x1e
	.long	0xce5
	.long	.LLST22
	.long	.LVUS22
	.uleb128 0xc
	.string	"out"
	.byte	0x2b
	.byte	0x18
	.long	0xcef
	.long	.LLST23
	.long	.LVUS23
	.uleb128 0x3b
	.quad	.LBB64
	.quad	.LBE64-.LBB64
	.long	0xbbf
	.uleb128 0xc
	.string	"x"
	.byte	0x2d
	.byte	0x1e
	.long	0x18a
	.long	.LLST31
	.long	.LVUS31
	.uleb128 0x16
	.quad	.LVL45
	.long	0xcf9
	.long	0xb5a
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL47
	.long	0xcf9
	.long	0xb7d
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x16
	.quad	.LVL49
	.long	0xcf9
	.long	0xba0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x32
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x24
	.quad	.LVL51
	.long	0xcf9
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x34
	.byte	0
	.byte	0
	.uleb128 0x3c
	.long	.LLRL29
	.long	0xbda
	.uleb128 0xc
	.string	"x"
	.byte	0x35
	.byte	0x1a
	.long	0x18a
	.long	.LLST30
	.long	.LVUS30
	.byte	0
	.uleb128 0x1c
	.long	0xcf9
	.quad	.LBI55
	.byte	.LVU93
	.long	.LLRL24
	.byte	0x32
	.byte	0x1e
	.long	0xc3c
	.uleb128 0xa
	.long	0xd16
	.long	.LLST25
	.long	.LVUS25
	.uleb128 0x8
	.long	0xd20
	.uleb128 0xa
	.long	0xd0a
	.long	.LLST26
	.long	.LVUS26
	.uleb128 0x12
	.long	.LLRL24
	.uleb128 0x13
	.long	0xd2c
	.long	.LLST27
	.long	.LVUS27
	.uleb128 0x13
	.long	0xd37
	.long	.LLST28
	.long	.LVUS28
	.uleb128 0xd
	.long	0xd42
	.uleb128 0xd
	.long	0xd4d
	.byte	0
	.byte	0
	.uleb128 0x1c
	.long	0xcf9
	.quad	.LBI68
	.byte	.LVU110
	.long	.LLRL32
	.byte	0x33
	.byte	0x1e
	.long	0xc9e
	.uleb128 0xa
	.long	0xd16
	.long	.LLST33
	.long	.LVUS33
	.uleb128 0x8
	.long	0xd20
	.uleb128 0xa
	.long	0xd0a
	.long	.LLST34
	.long	.LVUS34
	.uleb128 0x12
	.long	.LLRL32
	.uleb128 0x13
	.long	0xd2c
	.long	.LLST35
	.long	.LVUS35
	.uleb128 0x13
	.long	0xd37
	.long	.LLST36
	.long	.LVUS36
	.uleb128 0xd
	.long	0xd42
	.uleb128 0xd
	.long	0xd4d
	.byte	0
	.byte	0
	.uleb128 0x16
	.quad	.LVL34
	.long	0xcf9
	.long	0xcc2
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7d
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x24
	.quad	.LVL35
	.long	0xcf9
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x2
	.byte	0x7f
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x6
	.long	0x49c
	.uleb128 0x25
	.long	0xce5
	.uleb128 0x6
	.long	0x490
	.uleb128 0x25
	.long	0xcef
	.uleb128 0x3d
	.long	.LASF144
	.byte	0x1
	.byte	0x1c
	.byte	0x16
	.long	0x490
	.byte	0x1
	.long	0xd59
	.uleb128 0x10
	.string	"row"
	.byte	0x1
	.byte	0x1c
	.byte	0x38
	.long	0xce5
	.uleb128 0x10
	.string	"x"
	.byte	0x1
	.byte	0x1d
	.byte	0x2f
	.long	0x18a
	.uleb128 0x3e
	.long	.LASF120
	.byte	0x1
	.byte	0x1d
	.byte	0x3e
	.long	0x18a
	.uleb128 0x14
	.long	.LASF122
	.byte	0x1e
	.byte	0x17
	.long	0x197
	.uleb128 0x14
	.long	.LASF123
	.byte	0x1f
	.byte	0x17
	.long	0x197
	.uleb128 0x14
	.long	.LASF124
	.byte	0x20
	.byte	0x17
	.long	0x197
	.uleb128 0x14
	.long	.LASF125
	.byte	0x21
	.byte	0x17
	.long	0x197
	.byte	0
	.uleb128 0x23
	.long	0x48
	.uleb128 0x1a
	.long	0x2db
	.long	0xd89
	.uleb128 0xf
	.string	"_Tp"
	.long	0x41
	.uleb128 0x10
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xd59
	.uleb128 0x10
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xd59
	.byte	0
	.uleb128 0x1b
	.long	.LASF127
	.byte	0x12
	.quad	.LFB701
	.quad	.LFE701-.LFB701
	.uleb128 0x1
	.byte	0x9c
	.long	0xe65
	.uleb128 0x15
	.long	.LASF128
	.byte	0x12
	.byte	0x3c
	.long	0xcea
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x15
	.long	.LASF129
	.byte	0x13
	.byte	0x36
	.long	0xcf4
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x15
	.long	.LASF130
	.byte	0x14
	.byte	0x22
	.long	0x18a
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3f
	.quad	.LBB28
	.quad	.LBE28-.LBB28
	.uleb128 0xc
	.string	"i"
	.byte	0x15
	.byte	0x16
	.long	0x18a
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x12
	.long	.LLRL11
	.uleb128 0x14
	.long	.LASF131
	.byte	0x17
	.byte	0x1c
	.long	0x467
	.uleb128 0x40
	.long	0xe65
	.quad	.LBI30
	.byte	.LVU62
	.quad	.LBB30
	.quad	.LBE30-.LBB30
	.byte	0x1
	.byte	0x18
	.byte	0x3a
	.long	0xe36
	.uleb128 0xa
	.long	0xe81
	.long	.LLST12
	.long	.LVUS12
	.uleb128 0x8
	.long	0xe77
	.byte	0
	.uleb128 0x41
	.long	0xa3d
	.quad	.LBI32
	.byte	.LVU68
	.quad	.LBB32
	.quad	.LBE32-.LBB32
	.byte	0x1
	.byte	0x18
	.byte	0x3a
	.uleb128 0x8
	.long	0xa5b
	.uleb128 0x8
	.long	0xa4f
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x303
	.long	0xe8c
	.uleb128 0xf
	.string	"_Tp"
	.long	0x388
	.uleb128 0x26
	.string	"__a"
	.byte	0x14
	.long	0xa38
	.uleb128 0x26
	.string	"__b"
	.byte	0x24
	.long	0xa38
	.byte	0
	.uleb128 0x1b
	.long	.LASF132
	.byte	0x7
	.quad	.LFB700
	.quad	.LFE700-.LFB700
	.uleb128 0x1
	.byte	0x9c
	.long	0xf0e
	.uleb128 0x42
	.string	"red"
	.byte	0x1
	.byte	0x7
	.byte	0x3d
	.long	0xcea
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x11
	.long	.LASF133
	.byte	0x8
	.byte	0x3d
	.long	0xcea
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x11
	.long	.LASF134
	.byte	0x9
	.byte	0x3d
	.long	0xcea
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x15
	.long	.LASF128
	.byte	0xa
	.byte	0x37
	.long	0xcf4
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x15
	.long	.LASF130
	.byte	0xb
	.byte	0x23
	.long	0x18a
	.uleb128 0x1
	.byte	0x58
	.uleb128 0x12
	.long	.LLRL8
	.uleb128 0xc
	.string	"i"
	.byte	0xc
	.byte	0x16
	.long	0x18a
	.long	.LLST9
	.long	.LVUS9
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x10
	.byte	0x5
	.long	.LASF135
	.uleb128 0x4
	.byte	0x10
	.byte	0x7
	.long	.LASF136
	.uleb128 0x43
	.long	0xcf9
	.quad	.LFB703
	.quad	.LFE703-.LFB703
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xa
	.long	0xd0a
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0xa
	.long	0xd16
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0xa
	.long	0xd20
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x13
	.long	0xd2c
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0xd
	.long	0xd37
	.uleb128 0xd
	.long	0xd42
	.uleb128 0xd
	.long	0xd4d
	.uleb128 0x1c
	.long	0xd5e
	.quad	.LBI20
	.byte	.LVU14
	.long	.LLRL4
	.byte	0x20
	.byte	0x28
	.long	0xf99
	.uleb128 0x8
	.long	0xd7c
	.uleb128 0x8
	.long	0xd70
	.byte	0
	.uleb128 0x44
	.long	0xd5e
	.quad	.LBI22
	.byte	.LVU17
	.long	.LLRL5
	.byte	0x1
	.byte	0x21
	.byte	0x28
	.uleb128 0x8
	.long	0xd7c
	.uleb128 0x8
	.long	0xd70
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 16
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x2f
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 16
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 16
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0x21
	.sleb128 0
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 16
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x47
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 3
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x88
	.uleb128 0xb
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 16
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 257
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x13
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x88
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x88
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x2e
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2f
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x30
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x31
	.uleb128 0x3a
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x32
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x33
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x34
	.uleb128 0x15
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x37
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x38
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x39
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x3a
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x89
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3e
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x40
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x41
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x42
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x43
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x44
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS15:
	.uleb128 0
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 0
.LLST15:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0
.LVUS16:
	.uleb128 0
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 0
.LLST16:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0
.LVUS17:
	.uleb128 0
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU143
	.uleb128 .LVU143
	.uleb128 .LVU144
	.uleb128 .LVU144
	.uleb128 .LVU146
	.uleb128 .LVU146
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 0
.LLST17:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL40-.Ltext0
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL40-.Ltext0
	.uleb128 .LVL41-.Ltext0
	.uleb128 0x3
	.byte	0x7d
	.sleb128 2
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL41-.Ltext0
	.uleb128 .LVL43-.Ltext0
	.uleb128 0x3
	.byte	0x7f
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL43-.Ltext0
	.uleb128 .LVL44-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x5c
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0
.LVUS18:
	.uleb128 0
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU145
	.uleb128 .LVU145
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 0
.LLST18:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL42-.Ltext0
	.uleb128 0x1
	.byte	0x5e
	.byte	0x4
	.uleb128 .LVL42-.Ltext0
	.uleb128 .LVL44-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x52
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x5e
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS20:
	.uleb128 .LVU79
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU168
	.uleb128 .LVU168
	.uleb128 0
.LLST20:
	.byte	0x4
	.uleb128 .LVL25-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS22:
	.uleb128 .LVU90
	.uleb128 .LVU140
	.uleb128 .LVU147
	.uleb128 .LVU168
.LLST22:
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL38-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS23:
	.uleb128 .LVU91
	.uleb128 .LVU141
	.uleb128 .LVU147
	.uleb128 .LVU168
.LLST23:
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL39-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0
.LVUS31:
	.uleb128 .LVU147
	.uleb128 .LVU152
	.uleb128 .LVU152
	.uleb128 .LVU157
	.uleb128 .LVU157
	.uleb128 .LVU162
	.uleb128 .LVU162
	.uleb128 .LVU167
	.uleb128 .LVU167
	.uleb128 .LVU168
.LLST31:
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LVL46-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL46-.Ltext0
	.uleb128 .LVL48-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL48-.Ltext0
	.uleb128 .LVL50-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL52-.Ltext0
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL52-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x2
	.byte	0x34
	.byte	0x9f
	.byte	0
.LVUS30:
	.uleb128 .LVU118
	.uleb128 .LVU120
	.uleb128 .LVU120
	.uleb128 .LVU123
	.uleb128 .LVU123
	.uleb128 .LVU128
	.uleb128 .LVU128
	.uleb128 .LVU132
.LLST30:
	.byte	0x4
	.uleb128 .LVL30-.Ltext0
	.uleb128 .LVL31-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL31-.Ltext0
	.uleb128 .LVL32-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL32-.Ltext0
	.uleb128 .LVL33-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 -1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL33-.Ltext0
	.uleb128 .LVL34-1-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS25:
	.uleb128 .LVU94
	.uleb128 .LVU101
.LLST25:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS26:
	.uleb128 .LVU93
	.uleb128 .LVU101
.LLST26:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS27:
	.uleb128 .LVU95
	.uleb128 .LVU101
.LLST27:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS28:
	.uleb128 .LVU96
	.uleb128 .LVU137
.LLST28:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL36-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS33:
	.uleb128 .LVU111
	.uleb128 .LVU116
.LLST33:
	.byte	0x4
	.uleb128 .LVL29-.Ltext0
	.uleb128 .LVL29-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LVUS34:
	.uleb128 .LVU110
	.uleb128 .LVU116
.LLST34:
	.byte	0x4
	.uleb128 .LVL29-.Ltext0
	.uleb128 .LVL29-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS35:
	.uleb128 .LVU112
	.uleb128 .LVU116
.LLST35:
	.byte	0x4
	.uleb128 .LVL29-.Ltext0
	.uleb128 .LVL29-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS36:
	.uleb128 .LVU113
	.uleb128 .LVU137
.LLST36:
	.byte	0x4
	.uleb128 .LVL29-.Ltext0
	.uleb128 .LVL36-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS10:
	.uleb128 .LVU53
	.uleb128 .LVU56
	.uleb128 .LVU56
	.uleb128 .LVU74
.LLST10:
	.byte	0x4
	.uleb128 .LVL15-.Ltext0
	.uleb128 .LVL16-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL16-.Ltext0
	.uleb128 .LVL23-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS12:
	.uleb128 .LVU62
	.uleb128 .LVU64
.LLST12:
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x6
	.byte	0xa0
	.long	.Ldebug_info0+3571
	.sleb128 0
	.byte	0
.LVUS6:
	.uleb128 0
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 0
.LLST6:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS7:
	.uleb128 0
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 0
.LLST7:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0
.LVUS9:
	.uleb128 .LVU35
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU48
.LLST9:
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU12
	.uleb128 .LVU12
	.uleb128 0
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL3-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LFE703-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU4
	.uleb128 .LVU4
	.uleb128 .LVU25
	.uleb128 .LVU25
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 0
.LLST1:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 -1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LFE703-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 0
	.uleb128 .LVU14
	.uleb128 .LVU14
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 0
.LLST2:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL8-.Ltext0
	.uleb128 0x3
	.byte	0x71
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.Ltext0
	.uleb128 .LFE703-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 .LVU7
	.uleb128 .LVU13
	.uleb128 .LVU13
	.uleb128 .LVU25
	.uleb128 .LVU25
	.uleb128 .LVU27
	.uleb128 .LVU27
	.uleb128 0
.LLST3:
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x24
	.byte	0x70
	.sleb128 0
	.byte	0x32
	.byte	0x70
	.sleb128 0
	.byte	0x23
	.uleb128 0x8000000000000000
	.byte	0x11
	.sleb128 -9223372036854775806
	.byte	0x2a
	.byte	0x28
	.value	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x32
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-.Ltext0
	.uleb128 0x24
	.byte	0x70
	.sleb128 -1
	.byte	0x32
	.byte	0x70
	.sleb128 -1
	.byte	0x23
	.uleb128 0x8000000000000000
	.byte	0x11
	.sleb128 -9223372036854775806
	.byte	0x2a
	.byte	0x28
	.value	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x32
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LFE703-.Ltext0
	.uleb128 0x26
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x32
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x23
	.uleb128 0x8000000000000000
	.byte	0x11
	.sleb128 -9223372036854775806
	.byte	0x2a
	.byte	0x28
	.value	0x1
	.byte	0x16
	.byte	0x13
	.byte	0x32
	.byte	0x1c
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL4:
	.byte	0x4
	.uleb128 .LBB20-.Ltext0
	.uleb128 .LBE20-.Ltext0
	.byte	0x4
	.uleb128 .LBB25-.Ltext0
	.uleb128 .LBE25-.Ltext0
	.byte	0
.LLRL5:
	.byte	0x4
	.uleb128 .LBB22-.Ltext0
	.uleb128 .LBE22-.Ltext0
	.byte	0x4
	.uleb128 .LBB24-.Ltext0
	.uleb128 .LBE24-.Ltext0
	.byte	0
.LLRL8:
	.byte	0x4
	.uleb128 .LBB26-.Ltext0
	.uleb128 .LBE26-.Ltext0
	.byte	0x4
	.uleb128 .LBB27-.Ltext0
	.uleb128 .LBE27-.Ltext0
	.byte	0
.LLRL11:
	.byte	0x4
	.uleb128 .LBB29-.Ltext0
	.uleb128 .LBE29-.Ltext0
	.byte	0x4
	.uleb128 .LBB34-.Ltext0
	.uleb128 .LBE34-.Ltext0
	.byte	0
.LLRL19:
	.byte	0x4
	.uleb128 .LBB53-.Ltext0
	.uleb128 .LBE53-.Ltext0
	.byte	0x4
	.uleb128 .LBB85-.Ltext0
	.uleb128 .LBE85-.Ltext0
	.byte	0x4
	.uleb128 .LBB86-.Ltext0
	.uleb128 .LBE86-.Ltext0
	.byte	0x4
	.uleb128 .LBB87-.Ltext0
	.uleb128 .LBE87-.Ltext0
	.byte	0x4
	.uleb128 .LBB88-.Ltext0
	.uleb128 .LBE88-.Ltext0
	.byte	0x4
	.uleb128 .LBB89-.Ltext0
	.uleb128 .LBE89-.Ltext0
	.byte	0x4
	.uleb128 .LBB90-.Ltext0
	.uleb128 .LBE90-.Ltext0
	.byte	0
.LLRL21:
	.byte	0x4
	.uleb128 .LBB54-.Ltext0
	.uleb128 .LBE54-.Ltext0
	.byte	0x4
	.uleb128 .LBB81-.Ltext0
	.uleb128 .LBE81-.Ltext0
	.byte	0x4
	.uleb128 .LBB82-.Ltext0
	.uleb128 .LBE82-.Ltext0
	.byte	0x4
	.uleb128 .LBB83-.Ltext0
	.uleb128 .LBE83-.Ltext0
	.byte	0x4
	.uleb128 .LBB84-.Ltext0
	.uleb128 .LBE84-.Ltext0
	.byte	0
.LLRL24:
	.byte	0x4
	.uleb128 .LBB55-.Ltext0
	.uleb128 .LBE55-.Ltext0
	.byte	0x4
	.uleb128 .LBB65-.Ltext0
	.uleb128 .LBE65-.Ltext0
	.byte	0x4
	.uleb128 .LBB67-.Ltext0
	.uleb128 .LBE67-.Ltext0
	.byte	0x4
	.uleb128 .LBB73-.Ltext0
	.uleb128 .LBE73-.Ltext0
	.byte	0x4
	.uleb128 .LBB75-.Ltext0
	.uleb128 .LBE75-.Ltext0
	.byte	0x4
	.uleb128 .LBB77-.Ltext0
	.uleb128 .LBE77-.Ltext0
	.byte	0
.LLRL29:
	.byte	0x4
	.uleb128 .LBB62-.Ltext0
	.uleb128 .LBE62-.Ltext0
	.byte	0x4
	.uleb128 .LBB66-.Ltext0
	.uleb128 .LBE66-.Ltext0
	.byte	0x4
	.uleb128 .LBB79-.Ltext0
	.uleb128 .LBE79-.Ltext0
	.byte	0
.LLRL32:
	.byte	0x4
	.uleb128 .LBB68-.Ltext0
	.uleb128 .LBE68-.Ltext0
	.byte	0x4
	.uleb128 .LBB74-.Ltext0
	.uleb128 .LBE74-.Ltext0
	.byte	0x4
	.uleb128 .LBB76-.Ltext0
	.uleb128 .LBE76-.Ltext0
	.byte	0x4
	.uleb128 .LBB78-.Ltext0
	.uleb128 .LBE78-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF93:
	.string	"getenv"
.LASF61:
	.string	"uint_fast16_t"
.LASF11:
	.string	"__debug"
.LASF77:
	.string	"char32_t"
.LASF142:
	.string	"rand"
.LASF143:
	.string	"execution"
.LASF106:
	.string	"system"
.LASF105:
	.string	"__isoc23_strtoul"
.LASF95:
	.string	"mblen"
.LASF18:
	.string	"unsigned int"
.LASF69:
	.string	"__gnu_cxx"
.LASF125:
	.string	"right2"
.LASF66:
	.string	"intmax_t"
.LASF63:
	.string	"uint_fast64_t"
.LASF57:
	.string	"int_fast16_t"
.LASF25:
	.string	"__int32_t"
.LASF75:
	.string	"wchar_t"
.LASF134:
	.string	"blue"
.LASF38:
	.string	"__uintmax_t"
.LASF9:
	.string	"__swappable_details"
.LASF141:
	.string	"_ZN9__gnu_cxx3divExx"
.LASF33:
	.string	"__int_least32_t"
.LASF113:
	.string	"strtoull"
.LASF70:
	.string	"__ops"
.LASF139:
	.string	"max_align_t"
.LASF15:
	.string	"_ZSt3minImERKT_S2_S2_"
.LASF59:
	.string	"int_fast64_t"
.LASF78:
	.string	"__gnu_debug"
.LASF111:
	.string	"strtoll"
.LASF53:
	.string	"uint_least16_t"
.LASF46:
	.string	"uint32_t"
.LASF40:
	.string	"int8_t"
.LASF136:
	.string	"__int128 unsigned"
.LASF97:
	.string	"mbtowc"
.LASF12:
	.string	"min<int>"
.LASF5:
	.string	"__max_align_ld"
.LASF144:
	.string	"blurred_edge"
.LASF124:
	.string	"right1"
.LASF4:
	.string	"__max_align_ll"
.LASF130:
	.string	"count"
.LASF10:
	.string	"__swappable_with_details"
.LASF138:
	.string	"11max_align_t"
.LASF41:
	.string	"int16_t"
.LASF49:
	.string	"int_least16_t"
.LASF67:
	.string	"uintmax_t"
.LASF72:
	.string	"long long unsigned int"
.LASF24:
	.string	"__uint16_t"
.LASF55:
	.string	"uint_least64_t"
.LASF109:
	.string	"lldiv"
.LASF110:
	.string	"atoll"
.LASF131:
	.string	"value"
.LASF126:
	.string	"horizontal_blur_5tap"
.LASF8:
	.string	"size_t"
.LASF48:
	.string	"int_least8_t"
.LASF120:
	.string	"width"
.LASF43:
	.string	"int64_t"
.LASF51:
	.string	"int_least64_t"
.LASF52:
	.string	"uint_least8_t"
.LASF129:
	.string	"contrast"
.LASF34:
	.string	"__uint_least32_t"
.LASF92:
	.string	"bsearch"
.LASF28:
	.string	"__uint64_t"
.LASF103:
	.string	"__isoc23_strtol"
.LASF132:
	.string	"rgb_to_grayscale"
.LASF39:
	.string	"char"
.LASF81:
	.string	"5div_t"
.LASF76:
	.string	"char16_t"
.LASF44:
	.string	"uint8_t"
.LASF79:
	.string	"quot"
.LASF96:
	.string	"mbstowcs"
.LASF112:
	.string	"__isoc23_strtoll"
.LASF6:
	.string	"long long int"
.LASF68:
	.string	"bool"
.LASF22:
	.string	"__int16_t"
.LASF56:
	.string	"int_fast8_t"
.LASF94:
	.string	"ldiv"
.LASF86:
	.string	"__compar_fn_t"
.LASF31:
	.string	"__int_least16_t"
.LASF100:
	.string	"srand"
.LASF62:
	.string	"uint_fast32_t"
.LASF121:
	.string	"height"
.LASF19:
	.string	"__int8_t"
.LASF127:
	.string	"adjust_contrast"
.LASF137:
	.string	"GNU C++17 13.3.0 -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O3 -std=c++17 -fno-omit-frame-pointer -fno-tree-vectorize -fno-tree-slp-vectorize -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF27:
	.string	"__int64_t"
.LASF37:
	.string	"__intmax_t"
.LASF7:
	.string	"long double"
.LASF64:
	.string	"intptr_t"
.LASF45:
	.string	"uint16_t"
.LASF35:
	.string	"__int_least64_t"
.LASF16:
	.string	"unsigned char"
.LASF30:
	.string	"__uint_least8_t"
.LASF58:
	.string	"int_fast32_t"
.LASF23:
	.string	"short int"
.LASF2:
	.string	"long int"
.LASF128:
	.string	"gray"
.LASF123:
	.string	"left1"
.LASF122:
	.string	"left2"
.LASF87:
	.string	"atexit"
.LASF47:
	.string	"uint64_t"
.LASF133:
	.string	"green"
.LASF14:
	.string	"_ZSt3minIiERKT_S2_S2_"
.LASF83:
	.string	"ldiv_t"
.LASF21:
	.string	"__uint8_t"
.LASF118:
	.string	"source"
.LASF54:
	.string	"uint_least32_t"
.LASF71:
	.string	"max<int>"
.LASF88:
	.string	"at_quick_exit"
.LASF98:
	.string	"quick_exit"
.LASF29:
	.string	"__int_least8_t"
.LASF65:
	.string	"uintptr_t"
.LASF32:
	.string	"__uint_least16_t"
.LASF104:
	.string	"strtoul"
.LASF3:
	.string	"long unsigned int"
.LASF74:
	.string	"float"
.LASF42:
	.string	"int32_t"
.LASF50:
	.string	"int_least32_t"
.LASF135:
	.string	"__int128"
.LASF117:
	.string	"__pstl"
.LASF80:
	.string	"div_t"
.LASF13:
	.string	"min<long unsigned int>"
.LASF26:
	.string	"__uint32_t"
.LASF101:
	.string	"strtod"
.LASF115:
	.string	"strtof"
.LASF60:
	.string	"uint_fast8_t"
.LASF107:
	.string	"wcstombs"
.LASF102:
	.string	"strtol"
.LASF36:
	.string	"__uint_least64_t"
.LASF82:
	.string	"6ldiv_t"
.LASF116:
	.string	"strtold"
.LASF114:
	.string	"__isoc23_strtoull"
.LASF84:
	.string	"7lldiv_t"
.LASF119:
	.string	"destination"
.LASF20:
	.string	"signed char"
.LASF17:
	.string	"short unsigned int"
.LASF85:
	.string	"lldiv_t"
.LASF89:
	.string	"atof"
.LASF90:
	.string	"atoi"
.LASF91:
	.string	"atol"
.LASF108:
	.string	"wctomb"
.LASF73:
	.string	"double"
.LASF140:
	.string	"_ZSt3maxIiERKT_S2_S2_"
.LASF99:
	.string	"qsort"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"src/kernels.cpp"
.LASF1:
	.string	"/mnt/q/Documents/CodexFiles/2026-10-23/x20/outputs/performance-lab"
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
