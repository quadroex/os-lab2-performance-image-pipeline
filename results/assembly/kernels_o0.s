	.file	"kernels.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O0 -std=c++17 -fno-omit-frame-pointer -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
.Ltext0:
	.file 0 "/mnt/q/Documents/CodexFiles/2026-10-23/x20/outputs/performance-lab" "src/kernels.cpp"
	.globl	rgb_to_grayscale
	.type	rgb_to_grayscale, @function
rgb_to_grayscale:
.LFB690:
	.file 1 "src/kernels.cpp"
	.loc 1 11 51
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	mov	QWORD PTR -24[rbp], rdi	# red, red
	mov	QWORD PTR -32[rbp], rsi	# green, green
	mov	QWORD PTR -40[rbp], rdx	# blue, blue
	mov	QWORD PTR -48[rbp], rcx	# gray, gray
	mov	QWORD PTR -56[rbp], r8	# count, count
.LBB2:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 22
	mov	QWORD PTR -8[rbp], 0	# i,
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 5
	jmp	.L2	#
.L3:
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 31
	mov	rax, QWORD PTR -8[rbp]	# tmp100, i
	lea	rdx, 0[0+rax*4]	# _1,
	mov	rax, QWORD PTR -24[rbp]	# tmp101, red
	add	rax, rdx	# _2, _1
	mov	eax, DWORD PTR [rax]	# _3, *_2
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24
	imul	edx, eax, 77	# _4, _3,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 49
	mov	rax, QWORD PTR -8[rbp]	# tmp102, i
	lea	rcx, 0[0+rax*4]	# _5,
	mov	rax, QWORD PTR -32[rbp]	# tmp103, green
	add	rax, rcx	# _6, _5
	mov	eax, DWORD PTR [rax]	# _7, *_6
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40
	imul	eax, eax, 150	# _8, _7,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 33
	add	edx, eax	# _9, _8
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 65
	mov	rax, QWORD PTR -8[rbp]	# tmp104, i
	lea	rcx, 0[0+rax*4]	# _10,
	mov	rax, QWORD PTR -40[rbp]	# tmp105, blue
	add	rax, rcx	# _11, _10
	mov	eax, DWORD PTR [rax]	# _12, *_11
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57
	imul	eax, eax, 29	# _13, _12,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 51
	add	eax, edx	# _14, _9
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67
	lea	edx, 128[rax]	# _15,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 15
	mov	rax, QWORD PTR -8[rbp]	# tmp106, i
	lea	rcx, 0[0+rax*4]	# _16,
	mov	rax, QWORD PTR -48[rbp]	# tmp107, gray
	add	rax, rcx	# _17, _16
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75
	shr	edx, 8	# _18,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 17
	mov	DWORD PTR [rax], edx	# *_17, _18
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 5 discriminator 3
	add	QWORD PTR -8[rbp], 1	# i,
.L2:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 31 discriminator 1
	mov	rax, QWORD PTR -8[rbp]	# tmp108, i
	cmp	rax, QWORD PTR -56[rbp]	# tmp108, count
	jb	.L3	#,
.LBE2:
# src/kernels.cpp:16: }
	.loc 1 16 1
	nop	
	nop	
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE690:
	.size	rgb_to_grayscale, .-rgb_to_grayscale
	.globl	adjust_contrast
	.type	adjust_contrast, @function
adjust_contrast:
.LFB691:
	.loc 1 20 50
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	sub	rsp, 64	#,
	mov	QWORD PTR -40[rbp], rdi	# gray, gray
	mov	QWORD PTR -48[rbp], rsi	# contrast, contrast
	mov	QWORD PTR -56[rbp], rdx	# count, count
# src/kernels.cpp:20:                      std::size_t count) noexcept {
	.loc 1 20 50
	mov	rax, QWORD PTR fs:40	# tmp105, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -8[rbp], rax	# D.19496, tmp105
	xor	eax, eax	# tmp105
.LBB3:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 22
	mov	QWORD PTR -16[rbp], 0	# i,
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 5
	jmp	.L5	#
.L6:
.LBB4:
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 74
	mov	rax, QWORD PTR -16[rbp]	# tmp96, i
	lea	rdx, 0[0+rax*4]	# _1,
	mov	rax, QWORD PTR -40[rbp]	# tmp97, gray
	add	rax, rdx	# _2, _1
	mov	edx, DWORD PTR [rax]	# _3, *_2
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66
	mov	eax, edx	# tmp98, _3
	add	eax, eax	# tmp98
	add	eax, edx	# _4, _3
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76
	add	eax, 1	# _5,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82
	shr	eax	# _6
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88
	sub	eax, 64	# _8,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 28
	mov	DWORD PTR -28[rbp], eax	# value, _8
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 73
	mov	DWORD PTR -24[rbp], 0	# D.19398,
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 58
	lea	rdx, -28[rbp]	# tmp99,
	lea	rax, -24[rbp]	# tmp100,
	mov	rsi, rdx	#, tmp99
	mov	rdi, rax	#, tmp100
	call	_ZSt3maxIiERKT_S2_S2_	#
	mov	rdx, rax	# _9,
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 59 discriminator 1
	mov	DWORD PTR -20[rbp], 255	# D.19402,
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 58 discriminator 1
	lea	rax, -20[rbp]	# tmp101,
	mov	rsi, rdx	#, _9
	mov	rdi, rax	#, tmp101
	call	_ZSt3minIiERKT_S2_S2_	#
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 58 is_stmt 0 discriminator 2
	mov	ecx, DWORD PTR [rax]	# _11, *_10
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 19 is_stmt 1 discriminator 2
	mov	rax, QWORD PTR -16[rbp]	# tmp102, i
	lea	rdx, 0[0+rax*4]	# _12,
	mov	rax, QWORD PTR -48[rbp]	# tmp103, contrast
	add	rax, rdx	# _13, _12
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 discriminator 2
	mov	edx, ecx	# _14, _11
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2
	mov	DWORD PTR [rax], edx	# *_13, _14
.LBE4:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 5 discriminator 3
	add	QWORD PTR -16[rbp], 1	# i,
.L5:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 31 discriminator 1
	mov	rax, QWORD PTR -16[rbp]	# tmp104, i
	cmp	rax, QWORD PTR -56[rbp]	# tmp104, count
	jb	.L6	#,
.LBE3:
# src/kernels.cpp:26: }
	.loc 1 26 1
	nop	
	mov	rax, QWORD PTR -8[rbp]	# tmp106, D.19496
	sub	rax, QWORD PTR fs:40	# tmp106, MEM[(<address-space-1> long unsigned int *)40B]
	je	.L7	#,
	call	__stack_chk_fail@PLT	#
.L7:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE691:
	.size	adjust_contrast, .-adjust_contrast
	.section	.text._ZSt3minImERKT_S2_S2_,"axG",@progbits,_ZSt3minImERKT_S2_S2_,comdat
	.weak	_ZSt3minImERKT_S2_S2_
	.type	_ZSt3minImERKT_S2_S2_, @function
_ZSt3minImERKT_S2_S2_:
.LFB693:
	.file 2 "/usr/include/c++/13/bits/stl_algobase.h"
	.loc 2 233 5
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	mov	QWORD PTR -8[rbp], rdi	# __a, __a
	mov	QWORD PTR -16[rbp], rsi	# __b, __b
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 15
	mov	rax, QWORD PTR -16[rbp]	# tmp86, __b
	mov	rdx, QWORD PTR [rax]	# _1, *__b_5(D)
	mov	rax, QWORD PTR -8[rbp]	# tmp87, __a
	mov	rax, QWORD PTR [rax]	# _2, *__a_6(D)
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7
	cmp	rdx, rax	# _1, _2
	jnb	.L9	#,
# /usr/include/c++/13/bits/stl_algobase.h:239: 	return __b;
	.loc 2 239 9
	mov	rax, QWORD PTR -16[rbp]	# _3, __b
	jmp	.L10	#
.L9:
# /usr/include/c++/13/bits/stl_algobase.h:240:       return __a;
	.loc 2 240 14
	mov	rax, QWORD PTR -8[rbp]	# _3, __a
.L10:
# /usr/include/c++/13/bits/stl_algobase.h:241:     }
	.loc 2 241 5
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE693:
	.size	_ZSt3minImERKT_S2_S2_, .-_ZSt3minImERKT_S2_S2_
	.text
	.type	blurred_edge, @function
blurred_edge:
.LFB692:
	.loc 1 29 78
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	sub	rsp, 96	#,
	mov	QWORD PTR -72[rbp], rdi	# row, row
	mov	QWORD PTR -80[rbp], rsi	# x, x
	mov	QWORD PTR -88[rbp], rdx	# width, width
# src/kernels.cpp:29:                                   std::size_t x, std::size_t width) noexcept {
	.loc 1 29 78
	mov	rax, QWORD PTR fs:40	# tmp142, MEM[(<address-space-1> long unsigned int *)40B]
	mov	QWORD PTR -8[rbp], rax	# D.19499, tmp142
	xor	eax, eax	# tmp142
# src/kernels.cpp:30:     const std::size_t left2 = x >= 2 ? x - 2 : 0;
	.loc 1 30 38
	mov	rax, QWORD PTR -80[rbp]	# tmp115, x
	mov	edx, 2	# tmp141,
	cmp	rax, rdx	# tmp115, tmp141
	cmovb	rax, rdx	# tmp115,, _1, tmp141
# src/kernels.cpp:30:     const std::size_t left2 = x >= 2 ? x - 2 : 0;
	.loc 1 30 23
	sub	rax, 2	# tmp116,
	mov	QWORD PTR -40[rbp], rax	# left2, tmp116
# src/kernels.cpp:31:     const std::size_t left1 = x >= 1 ? x - 1 : 0;
	.loc 1 31 38
	cmp	QWORD PTR -80[rbp], 0	# x,
	je	.L12	#,
# src/kernels.cpp:31:     const std::size_t left1 = x >= 1 ? x - 1 : 0;
	.loc 1 31 38 is_stmt 0 discriminator 1
	mov	rax, QWORD PTR -80[rbp]	# tmp117, x
	sub	rax, 1	# iftmp.0_31,
	jmp	.L13	#
.L12:
# src/kernels.cpp:31:     const std::size_t left1 = x >= 1 ? x - 1 : 0;
	.loc 1 31 38 discriminator 2
	mov	eax, 0	# iftmp.0_31,
.L13:
# src/kernels.cpp:31:     const std::size_t left1 = x >= 1 ? x - 1 : 0;
	.loc 1 31 23 is_stmt 1 discriminator 4
	mov	QWORD PTR -32[rbp], rax	# left1, iftmp.0_31
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 54
	mov	rax, QWORD PTR -88[rbp]	# tmp118, width
	sub	rax, 1	# _2,
	mov	QWORD PTR -48[rbp], rax	# MEM[(long unsigned int *)_55], _2
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 43
	mov	rax, QWORD PTR -80[rbp]	# tmp119, x
	add	rax, 1	# _3,
	mov	QWORD PTR -56[rbp], rax	# MEM[(long unsigned int *)_54], _3
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 40
	lea	rdx, -48[rbp]	# tmp120,
	lea	rax, -56[rbp]	# tmp121,
	mov	rsi, rdx	#, tmp120
	mov	rdi, rax	#, tmp121
	call	_ZSt3minImERKT_S2_S2_	#
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 57 discriminator 1
	mov	rax, QWORD PTR [rax]	# tmp122, *_4
	mov	QWORD PTR -24[rbp], rax	# right1, tmp122
# src/kernels.cpp:33:     const std::size_t right2 = std::min(x + 2, width - 1);
	.loc 1 33 54
	mov	rax, QWORD PTR -88[rbp]	# tmp123, width
	sub	rax, 1	# _5,
	mov	QWORD PTR -48[rbp], rax	# MEM[(long unsigned int *)_55], _5
# src/kernels.cpp:33:     const std::size_t right2 = std::min(x + 2, width - 1);
	.loc 1 33 43
	mov	rax, QWORD PTR -80[rbp]	# tmp124, x
	add	rax, 2	# _6,
	mov	QWORD PTR -56[rbp], rax	# MEM[(long unsigned int *)_54], _6
# src/kernels.cpp:33:     const std::size_t right2 = std::min(x + 2, width - 1);
	.loc 1 33 40
	lea	rdx, -48[rbp]	# tmp125,
	lea	rax, -56[rbp]	# tmp126,
	mov	rsi, rdx	#, tmp125
	mov	rdi, rax	#, tmp126
	call	_ZSt3minImERKT_S2_S2_	#
# src/kernels.cpp:33:     const std::size_t right2 = std::min(x + 2, width - 1);
	.loc 1 33 57 discriminator 1
	mov	rax, QWORD PTR [rax]	# tmp127, *_7
	mov	QWORD PTR -16[rbp], rax	# right2, tmp127
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 22
	mov	rax, QWORD PTR -40[rbp]	# tmp128, left2
	lea	rdx, 0[0+rax*4]	# _8,
	mov	rax, QWORD PTR -72[rbp]	# tmp129, row
	add	rax, rdx	# _9, _8
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 42
	mov	ecx, DWORD PTR [rax]	# _10, *_9
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 54
	mov	rax, QWORD PTR -80[rbp]	# tmp130, x
	lea	rdx, 0[0+rax*4]	# _11,
	mov	rax, QWORD PTR -72[rbp]	# tmp131, row
	add	rax, rdx	# _12, _11
	mov	edx, DWORD PTR [rax]	# _13, *_12
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 47
	mov	eax, edx	# tmp132, _13
	add	eax, eax	# tmp132
	add	eax, edx	# tmp132, _13
	add	eax, eax	# tmp133
	mov	esi, eax	# _14, tmp132
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 40
	mov	rax, QWORD PTR -32[rbp]	# tmp134, left1
	lea	rdx, 0[0+rax*4]	# _15,
	mov	rax, QWORD PTR -72[rbp]	# tmp135, row
	add	rax, rdx	# _16, _15
	mov	eax, DWORD PTR [rax]	# _17, *_16
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 29
	sal	eax, 2	# _18,
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 42
	add	eax, esi	# _19, _14
	lea	edx, [rcx+rax]	# _20,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 30
	mov	rax, QWORD PTR -24[rbp]	# tmp136, right1
	lea	rcx, 0[0+rax*4]	# _21,
	mov	rax, QWORD PTR -72[rbp]	# tmp137, row
	add	rax, rcx	# _22, _21
	mov	eax, DWORD PTR [rax]	# _23, *_22
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 18
	sal	eax, 2	# _24,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 13
	add	edx, eax	# _25, _24
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 44
	mov	rax, QWORD PTR -16[rbp]	# tmp138, right2
	lea	rcx, 0[0+rax*4]	# _26,
	mov	rax, QWORD PTR -72[rbp]	# tmp139, row
	add	rax, rcx	# _27, _26
	mov	eax, DWORD PTR [rax]	# _28, *_27
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 32
	add	eax, edx	# _29, _25
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46
	add	eax, 8	# _30,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55
	shr	eax, 4	# _52,
# src/kernels.cpp:36: }
	.loc 1 36 1
	mov	rdx, QWORD PTR -8[rbp]	# tmp143, D.19499
	sub	rdx, QWORD PTR fs:40	# tmp143, MEM[(<address-space-1> long unsigned int *)40B]
	je	.L15	#,
	call	__stack_chk_fail@PLT	#
.L15:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE692:
	.size	blurred_edge, .-blurred_edge
	.globl	horizontal_blur_5tap
	.type	horizontal_blur_5tap, @function
horizontal_blur_5tap:
.LFB694:
	.loc 1 40 75
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	rbx	#
	sub	rsp, 88	#,
	.cfi_offset 3, -24
	mov	QWORD PTR -72[rbp], rdi	# source, source
	mov	QWORD PTR -80[rbp], rsi	# destination, destination
	mov	QWORD PTR -88[rbp], rdx	# width, width
	mov	QWORD PTR -96[rbp], rcx	# height, height
.LBB5:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 22
	mov	QWORD PTR -56[rbp], 0	# y,
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 5
	jmp	.L17	#
.L24:
.LBB6:
# src/kernels.cpp:42:         const std::uint32_t* row = source + y * width;
	.loc 1 42 47
	mov	rax, QWORD PTR -56[rbp]	# tmp133, y
	imul	rax, QWORD PTR -88[rbp]	# _1, width
# src/kernels.cpp:42:         const std::uint32_t* row = source + y * width;
	.loc 1 42 43
	lea	rdx, 0[0+rax*4]	# _2,
# src/kernels.cpp:42:         const std::uint32_t* row = source + y * width;
	.loc 1 42 30
	mov	rax, QWORD PTR -72[rbp]	# tmp137, source
	add	rax, rdx	# tmp136, _2
	mov	QWORD PTR -32[rbp], rax	# row, tmp136
# src/kernels.cpp:43:         std::uint32_t* out = destination + y * width;
	.loc 1 43 46
	mov	rax, QWORD PTR -56[rbp]	# tmp138, y
	imul	rax, QWORD PTR -88[rbp]	# _3, width
# src/kernels.cpp:43:         std::uint32_t* out = destination + y * width;
	.loc 1 43 42
	lea	rdx, 0[0+rax*4]	# _4,
# src/kernels.cpp:43:         std::uint32_t* out = destination + y * width;
	.loc 1 43 24
	mov	rax, QWORD PTR -80[rbp]	# tmp142, destination
	add	rax, rdx	# tmp141, _4
	mov	QWORD PTR -24[rbp], rax	# out, tmp141
.LBB7:
# src/kernels.cpp:44:         if (width < 5) {
	.loc 1 44 9
	cmp	QWORD PTR -88[rbp], 4	# width,
	ja	.L18	#,
.LBB8:
.LBB9:
# src/kernels.cpp:45:             for (std::size_t x = 0; x < width; ++x) {
	.loc 1 45 30
	mov	QWORD PTR -48[rbp], 0	# x,
# src/kernels.cpp:45:             for (std::size_t x = 0; x < width; ++x) {
	.loc 1 45 13
	jmp	.L19	#
.L20:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 22
	mov	rax, QWORD PTR -48[rbp]	# tmp143, x
	lea	rdx, 0[0+rax*4]	# _5,
	mov	rax, QWORD PTR -24[rbp]	# tmp144, out
	lea	rbx, [rdx+rax]	# _6,
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38
	mov	rdx, QWORD PTR -88[rbp]	# tmp145, width
	mov	rcx, QWORD PTR -48[rbp]	# tmp146, x
	mov	rax, QWORD PTR -32[rbp]	# tmp147, row
	mov	rsi, rcx	#, tmp146
	mov	rdi, rax	#, tmp147
	call	blurred_edge	#
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1
	mov	DWORD PTR [rbx], eax	# *_6, _7
# src/kernels.cpp:45:             for (std::size_t x = 0; x < width; ++x) {
	.loc 1 45 13 discriminator 3
	add	QWORD PTR -48[rbp], 1	# x,
.L19:
# src/kernels.cpp:45:             for (std::size_t x = 0; x < width; ++x) {
	.loc 1 45 39 discriminator 1
	mov	rax, QWORD PTR -48[rbp]	# tmp148, x
	cmp	rax, QWORD PTR -88[rbp]	# tmp148, width
	jb	.L20	#,
.LBE9:
# src/kernels.cpp:48:             continue;
	.loc 1 48 13
	jmp	.L21	#
.L18:
.LBE8:
.LBE7:
# src/kernels.cpp:50:         out[0] = blurred_edge(row, 0, width);
	.loc 1 50 30
	mov	rdx, QWORD PTR -88[rbp]	# tmp149, width
	mov	rax, QWORD PTR -32[rbp]	# tmp150, row
	mov	esi, 0	#,
	mov	rdi, rax	#, tmp150
	call	blurred_edge	#
# src/kernels.cpp:50:         out[0] = blurred_edge(row, 0, width);
	.loc 1 50 16 discriminator 1
	mov	rdx, QWORD PTR -24[rbp]	# tmp151, out
	mov	DWORD PTR [rdx], eax	# *out_66, _8
# src/kernels.cpp:51:         out[1] = blurred_edge(row, 1, width);
	.loc 1 51 14
	mov	rax, QWORD PTR -24[rbp]	# tmp152, out
	lea	rbx, 4[rax]	# _9,
# src/kernels.cpp:51:         out[1] = blurred_edge(row, 1, width);
	.loc 1 51 30
	mov	rdx, QWORD PTR -88[rbp]	# tmp153, width
	mov	rax, QWORD PTR -32[rbp]	# tmp154, row
	mov	esi, 1	#,
	mov	rdi, rax	#, tmp154
	call	blurred_edge	#
# src/kernels.cpp:51:         out[1] = blurred_edge(row, 1, width);
	.loc 1 51 16 discriminator 1
	mov	DWORD PTR [rbx], eax	# *_9, _10
.LBB10:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 26
	mov	QWORD PTR -40[rbp], 2	# x,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 9
	jmp	.L22	#
.L23:
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 32
	mov	rax, QWORD PTR -40[rbp]	# tmp155, x
	sal	rax, 2	# _11,
	lea	rdx, -8[rax]	# _12,
	mov	rax, QWORD PTR -32[rbp]	# tmp156, row
	add	rax, rdx	# _13, _12
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 52
	mov	ecx, DWORD PTR [rax]	# _14, *_13
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 64
	mov	rax, QWORD PTR -40[rbp]	# tmp157, x
	lea	rdx, 0[0+rax*4]	# _15,
	mov	rax, QWORD PTR -32[rbp]	# tmp158, row
	add	rax, rdx	# _16, _15
	mov	edx, DWORD PTR [rax]	# _17, *_16
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57
	mov	eax, edx	# tmp159, _17
	add	eax, eax	# tmp159
	add	eax, edx	# tmp159, _17
	add	eax, eax	# tmp160
	mov	esi, eax	# _18, tmp159
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 50
	mov	rax, QWORD PTR -40[rbp]	# tmp161, x
	sal	rax, 2	# _19,
	lea	rdx, -4[rax]	# _20,
	mov	rax, QWORD PTR -32[rbp]	# tmp162, row
	add	rax, rdx	# _21, _20
	mov	eax, DWORD PTR [rax]	# _22, *_21
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 39
	sal	eax, 2	# _23,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 52
	add	eax, esi	# _24, _18
	lea	edx, [rcx+rax]	# _25,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39
	mov	rax, QWORD PTR -40[rbp]	# tmp163, x
	add	rax, 1	# _26,
	lea	rcx, 0[0+rax*4]	# _27,
	mov	rax, QWORD PTR -32[rbp]	# tmp164, row
	add	rax, rcx	# _28, _27
	mov	eax, DWORD PTR [rax]	# _29, *_28
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 28
	sal	eax, 2	# _30,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 23
	add	edx, eax	# _31, _30
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52
	mov	rax, QWORD PTR -40[rbp]	# tmp165, x
	add	rax, 2	# _32,
	lea	rcx, 0[0+rax*4]	# _33,
	mov	rax, QWORD PTR -32[rbp]	# tmp166, row
	add	rax, rcx	# _34, _33
	mov	eax, DWORD PTR [rax]	# _35, *_34
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 41
	add	eax, edx	# _36, _31
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54
	lea	edx, 8[rax]	# _37,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 18
	mov	rax, QWORD PTR -40[rbp]	# tmp167, x
	lea	rcx, 0[0+rax*4]	# _38,
	mov	rax, QWORD PTR -24[rbp]	# tmp168, out
	add	rax, rcx	# _39, _38
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60
	shr	edx, 4	# _40,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20
	mov	DWORD PTR [rax], edx	# *_39, _40
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 9 discriminator 3
	add	QWORD PTR -40[rbp], 1	# x,
.L22:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 discriminator 1
	mov	rax, QWORD PTR -88[rbp]	# tmp169, width
	sub	rax, 2	# _41,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 35 discriminator 1
	cmp	QWORD PTR -40[rbp], rax	# x, _41
	jb	.L23	#,
.LBE10:
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 38
	mov	rax, QWORD PTR -88[rbp]	# tmp170, width
	lea	rcx, -2[rax]	# _42,
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 22
	mov	rax, QWORD PTR -88[rbp]	# tmp171, width
	sal	rax, 2	# _43,
	lea	rdx, -8[rax]	# _44,
	mov	rax, QWORD PTR -24[rbp]	# tmp172, out
	lea	rbx, [rdx+rax]	# _45,
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 38
	mov	rdx, QWORD PTR -88[rbp]	# tmp173, width
	mov	rax, QWORD PTR -32[rbp]	# tmp174, row
	mov	rsi, rcx	#, _42
	mov	rdi, rax	#, tmp174
	call	blurred_edge	#
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 24 discriminator 1
	mov	DWORD PTR [rbx], eax	# *_45, _46
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38
	mov	rax, QWORD PTR -88[rbp]	# tmp175, width
	lea	rcx, -1[rax]	# _47,
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 22
	mov	rax, QWORD PTR -88[rbp]	# tmp176, width
	sal	rax, 2	# _48,
	lea	rdx, -4[rax]	# _49,
	mov	rax, QWORD PTR -24[rbp]	# tmp177, out
	lea	rbx, [rdx+rax]	# _50,
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38
	mov	rdx, QWORD PTR -88[rbp]	# tmp178, width
	mov	rax, QWORD PTR -32[rbp]	# tmp179, row
	mov	rsi, rcx	#, _47
	mov	rdi, rax	#, tmp179
	call	blurred_edge	#
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 24 discriminator 1
	mov	DWORD PTR [rbx], eax	# *_50, _51
.L21:
.LBE6:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 5 discriminator 2
	add	QWORD PTR -56[rbp], 1	# y,
.L17:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 31 discriminator 1
	mov	rax, QWORD PTR -56[rbp]	# tmp180, y
	cmp	rax, QWORD PTR -96[rbp]	# tmp180, height
	jb	.L24	#,
.LBE5:
# src/kernels.cpp:60: }
	.loc 1 60 1
	nop	
	nop	
	mov	rbx, QWORD PTR -8[rbp]	#,
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE694:
	.size	horizontal_blur_5tap, .-horizontal_blur_5tap
	.section	.text._ZSt3maxIiERKT_S2_S2_,"axG",@progbits,_ZSt3maxIiERKT_S2_S2_,comdat
	.weak	_ZSt3maxIiERKT_S2_S2_
	.type	_ZSt3maxIiERKT_S2_S2_, @function
_ZSt3maxIiERKT_S2_S2_:
.LFB695:
	.loc 2 257 5
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	mov	QWORD PTR -8[rbp], rdi	# __a, __a
	mov	QWORD PTR -16[rbp], rsi	# __b, __b
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 15
	mov	rax, QWORD PTR -8[rbp]	# tmp86, __a
	mov	edx, DWORD PTR [rax]	# _1, *__a_5(D)
	mov	rax, QWORD PTR -16[rbp]	# tmp87, __b
	mov	eax, DWORD PTR [rax]	# _2, *__b_6(D)
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 7
	cmp	edx, eax	# _1, _2
	jge	.L26	#,
# /usr/include/c++/13/bits/stl_algobase.h:263: 	return __b;
	.loc 2 263 9
	mov	rax, QWORD PTR -16[rbp]	# _3, __b
	jmp	.L27	#
.L26:
# /usr/include/c++/13/bits/stl_algobase.h:264:       return __a;
	.loc 2 264 14
	mov	rax, QWORD PTR -8[rbp]	# _3, __a
.L27:
# /usr/include/c++/13/bits/stl_algobase.h:265:     }
	.loc 2 265 5
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE695:
	.size	_ZSt3maxIiERKT_S2_S2_, .-_ZSt3maxIiERKT_S2_S2_
	.section	.text._ZSt3minIiERKT_S2_S2_,"axG",@progbits,_ZSt3minIiERKT_S2_S2_,comdat
	.weak	_ZSt3minIiERKT_S2_S2_
	.type	_ZSt3minIiERKT_S2_S2_, @function
_ZSt3minIiERKT_S2_S2_:
.LFB696:
	.loc 2 233 5
	.cfi_startproc
	endbr64	
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	mov	QWORD PTR -8[rbp], rdi	# __a, __a
	mov	QWORD PTR -16[rbp], rsi	# __b, __b
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 15
	mov	rax, QWORD PTR -16[rbp]	# tmp86, __b
	mov	edx, DWORD PTR [rax]	# _1, *__b_5(D)
	mov	rax, QWORD PTR -8[rbp]	# tmp87, __a
	mov	eax, DWORD PTR [rax]	# _2, *__a_6(D)
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7
	cmp	edx, eax	# _1, _2
	jge	.L29	#,
# /usr/include/c++/13/bits/stl_algobase.h:239: 	return __b;
	.loc 2 239 9
	mov	rax, QWORD PTR -16[rbp]	# _3, __b
	jmp	.L30	#
.L29:
# /usr/include/c++/13/bits/stl_algobase.h:240:       return __a;
	.loc 2 240 14
	mov	rax, QWORD PTR -8[rbp]	# _3, __a
.L30:
# /usr/include/c++/13/bits/stl_algobase.h:241:     }
	.loc 2 241 5
	pop	rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE696:
	.size	_ZSt3minIiERKT_S2_S2_, .-_ZSt3minIiERKT_S2_S2_
	.text
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
	.file 17 "/usr/include/c++/13/pstl/execution_defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xd94
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x1f
	.long	.LASF137
	.byte	0x21
	.long	.LASF0
	.long	.LASF1
	.long	.LLRL0
	.quad	0
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
	.long	0x3d
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF3
	.uleb128 0x8
	.long	0x3d
	.uleb128 0x20
	.byte	0x20
	.byte	0x10
	.byte	0x3
	.value	0x1a9
	.byte	0x10
	.long	.LASF138
	.long	0x75
	.uleb128 0x14
	.long	.LASF4
	.value	0x1aa
	.byte	0xd
	.long	0x75
	.byte	0x8
	.byte	0
	.uleb128 0x14
	.long	.LASF5
	.value	0x1ab
	.byte	0xf
	.long	0x7c
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
	.uleb128 0x21
	.long	.LASF139
	.byte	0x3
	.value	0x1b4
	.byte	0x3
	.long	0x49
	.byte	0x10
	.uleb128 0x22
	.string	"std"
	.byte	0x6
	.value	0x132
	.byte	0xb
	.long	0x325
	.uleb128 0x1
	.byte	0x4
	.byte	0x3a
	.byte	0xb
	.long	0x83
	.uleb128 0x1
	.byte	0x5
	.byte	0x33
	.byte	0xb
	.long	0x43f
	.uleb128 0x1
	.byte	0x5
	.byte	0x34
	.byte	0xb
	.long	0x44b
	.uleb128 0x1
	.byte	0x5
	.byte	0x35
	.byte	0xb
	.long	0x457
	.uleb128 0x1
	.byte	0x5
	.byte	0x36
	.byte	0xb
	.long	0x468
	.uleb128 0x1
	.byte	0x5
	.byte	0x38
	.byte	0xb
	.long	0x509
	.uleb128 0x1
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.long	0x515
	.uleb128 0x1
	.byte	0x5
	.byte	0x3a
	.byte	0xb
	.long	0x521
	.uleb128 0x1
	.byte	0x5
	.byte	0x3b
	.byte	0xb
	.long	0x52d
	.uleb128 0x1
	.byte	0x5
	.byte	0x3d
	.byte	0xb
	.long	0x4a9
	.uleb128 0x1
	.byte	0x5
	.byte	0x3e
	.byte	0xb
	.long	0x4b5
	.uleb128 0x1
	.byte	0x5
	.byte	0x3f
	.byte	0xb
	.long	0x4c1
	.uleb128 0x1
	.byte	0x5
	.byte	0x40
	.byte	0xb
	.long	0x4cd
	.uleb128 0x1
	.byte	0x5
	.byte	0x42
	.byte	0xb
	.long	0x581
	.uleb128 0x1
	.byte	0x5
	.byte	0x43
	.byte	0xb
	.long	0x569
	.uleb128 0x1
	.byte	0x5
	.byte	0x45
	.byte	0xb
	.long	0x474
	.uleb128 0x1
	.byte	0x5
	.byte	0x46
	.byte	0xb
	.long	0x480
	.uleb128 0x1
	.byte	0x5
	.byte	0x47
	.byte	0xb
	.long	0x48c
	.uleb128 0x1
	.byte	0x5
	.byte	0x48
	.byte	0xb
	.long	0x49d
	.uleb128 0x1
	.byte	0x5
	.byte	0x4a
	.byte	0xb
	.long	0x539
	.uleb128 0x1
	.byte	0x5
	.byte	0x4b
	.byte	0xb
	.long	0x545
	.uleb128 0x1
	.byte	0x5
	.byte	0x4c
	.byte	0xb
	.long	0x551
	.uleb128 0x1
	.byte	0x5
	.byte	0x4d
	.byte	0xb
	.long	0x55d
	.uleb128 0x1
	.byte	0x5
	.byte	0x4f
	.byte	0xb
	.long	0x4d9
	.uleb128 0x1
	.byte	0x5
	.byte	0x50
	.byte	0xb
	.long	0x4e5
	.uleb128 0x1
	.byte	0x5
	.byte	0x51
	.byte	0xb
	.long	0x4f1
	.uleb128 0x1
	.byte	0x5
	.byte	0x52
	.byte	0xb
	.long	0x4fd
	.uleb128 0x1
	.byte	0x5
	.byte	0x54
	.byte	0xb
	.long	0x58d
	.uleb128 0x1
	.byte	0x5
	.byte	0x55
	.byte	0xb
	.long	0x575
	.uleb128 0x15
	.long	.LASF8
	.byte	0x6
	.value	0x134
	.byte	0x1a
	.long	0x3d
	.uleb128 0x8
	.long	0x186
	.uleb128 0x16
	.long	.LASF9
	.value	0xab0
	.uleb128 0x16
	.long	.LASF10
	.value	0xb06
	.uleb128 0x17
	.long	.LASF11
	.byte	0x8
	.byte	0x32
	.byte	0xd
	.uleb128 0x1
	.byte	0x9
	.byte	0x83
	.byte	0xb
	.long	0x66f
	.uleb128 0x1
	.byte	0x9
	.byte	0x84
	.byte	0xb
	.long	0x69e
	.uleb128 0x1
	.byte	0x9
	.byte	0x8a
	.byte	0xb
	.long	0x70a
	.uleb128 0x1
	.byte	0x9
	.byte	0x8d
	.byte	0xb
	.long	0x726
	.uleb128 0x1
	.byte	0x9
	.byte	0x90
	.byte	0xb
	.long	0x741
	.uleb128 0x1
	.byte	0x9
	.byte	0x91
	.byte	0xb
	.long	0x756
	.uleb128 0x1
	.byte	0x9
	.byte	0x92
	.byte	0xb
	.long	0x76b
	.uleb128 0x1
	.byte	0x9
	.byte	0x93
	.byte	0xb
	.long	0x780
	.uleb128 0x1
	.byte	0x9
	.byte	0x95
	.byte	0xb
	.long	0x7aa
	.uleb128 0x1
	.byte	0x9
	.byte	0x98
	.byte	0xb
	.long	0x7c6
	.uleb128 0x1
	.byte	0x9
	.byte	0x9a
	.byte	0xb
	.long	0x7dc
	.uleb128 0x1
	.byte	0x9
	.byte	0x9d
	.byte	0xb
	.long	0x7f7
	.uleb128 0x1
	.byte	0x9
	.byte	0x9e
	.byte	0xb
	.long	0x812
	.uleb128 0x1
	.byte	0x9
	.byte	0x9f
	.byte	0xb
	.long	0x837
	.uleb128 0x1
	.byte	0x9
	.byte	0xa1
	.byte	0xb
	.long	0x857
	.uleb128 0x1
	.byte	0x9
	.byte	0xa4
	.byte	0xb
	.long	0x877
	.uleb128 0x1
	.byte	0x9
	.byte	0xa7
	.byte	0xb
	.long	0x88a
	.uleb128 0x1
	.byte	0x9
	.byte	0xa9
	.byte	0xb
	.long	0x897
	.uleb128 0x1
	.byte	0x9
	.byte	0xaa
	.byte	0xb
	.long	0x8a8
	.uleb128 0x1
	.byte	0x9
	.byte	0xab
	.byte	0xb
	.long	0x8c7
	.uleb128 0x1
	.byte	0x9
	.byte	0xac
	.byte	0xb
	.long	0x8eb
	.uleb128 0x1
	.byte	0x9
	.byte	0xad
	.byte	0xb
	.long	0x90f
	.uleb128 0x1
	.byte	0x9
	.byte	0xaf
	.byte	0xb
	.long	0x925
	.uleb128 0x1
	.byte	0x9
	.byte	0xb0
	.byte	0xb
	.long	0x94a
	.uleb128 0x1
	.byte	0x9
	.byte	0xf4
	.byte	0x16
	.long	0x6cd
	.uleb128 0x1
	.byte	0x9
	.byte	0xf9
	.byte	0x16
	.long	0x5ed
	.uleb128 0x1
	.byte	0x9
	.byte	0xfa
	.byte	0x16
	.long	0x965
	.uleb128 0x1
	.byte	0x9
	.byte	0xfc
	.byte	0x16
	.long	0x980
	.uleb128 0x1
	.byte	0x9
	.byte	0xfd
	.byte	0x16
	.long	0x9dd
	.uleb128 0x1
	.byte	0x9
	.byte	0xfe
	.byte	0x16
	.long	0x995
	.uleb128 0x1
	.byte	0x9
	.byte	0xff
	.byte	0x16
	.long	0x9b9
	.uleb128 0x23
	.byte	0x9
	.value	0x100
	.byte	0x16
	.long	0x9f7
	.uleb128 0xe
	.long	.LASF12
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF102
	.long	0xa2d
	.long	0x2d7
	.uleb128 0xc
	.string	"_Tp"
	.long	0x384
	.uleb128 0x2
	.long	0xa2d
	.uleb128 0x2
	.long	0xa2d
	.byte	0
	.uleb128 0x18
	.long	.LASF13
	.byte	0x2
	.value	0x101
	.byte	0x5
	.long	.LASF87
	.long	0xa2d
	.long	0x300
	.uleb128 0xc
	.string	"_Tp"
	.long	0x384
	.uleb128 0x2
	.long	0xa2d
	.uleb128 0x2
	.long	0xa2d
	.byte	0
	.uleb128 0x24
	.long	.LASF69
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF140
	.long	0xc36
	.uleb128 0xc
	.string	"_Tp"
	.long	0x3d
	.uleb128 0x2
	.long	0xc36
	.uleb128 0x2
	.long	0xc36
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x1
	.byte	0x8
	.long	.LASF14
	.uleb128 0x4
	.byte	0x2
	.byte	0x7
	.long	.LASF15
	.uleb128 0x4
	.byte	0x4
	.byte	0x7
	.long	.LASF16
	.uleb128 0x3
	.long	.LASF17
	.byte	0xa
	.byte	0x25
	.byte	0x15
	.long	0x346
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF18
	.uleb128 0x3
	.long	.LASF19
	.byte	0xa
	.byte	0x26
	.byte	0x17
	.long	0x325
	.uleb128 0x3
	.long	.LASF20
	.byte	0xa
	.byte	0x27
	.byte	0x1a
	.long	0x365
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.long	.LASF21
	.uleb128 0x3
	.long	.LASF22
	.byte	0xa
	.byte	0x28
	.byte	0x1c
	.long	0x32c
	.uleb128 0x3
	.long	.LASF23
	.byte	0xa
	.byte	0x29
	.byte	0x14
	.long	0x384
	.uleb128 0x25
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x8
	.long	0x384
	.uleb128 0x3
	.long	.LASF24
	.byte	0xa
	.byte	0x2a
	.byte	0x16
	.long	0x333
	.uleb128 0x3
	.long	.LASF25
	.byte	0xa
	.byte	0x2c
	.byte	0x19
	.long	0x2a
	.uleb128 0x3
	.long	.LASF26
	.byte	0xa
	.byte	0x2d
	.byte	0x1b
	.long	0x3d
	.uleb128 0x3
	.long	.LASF27
	.byte	0xa
	.byte	0x34
	.byte	0x12
	.long	0x33a
	.uleb128 0x3
	.long	.LASF28
	.byte	0xa
	.byte	0x35
	.byte	0x13
	.long	0x34d
	.uleb128 0x3
	.long	.LASF29
	.byte	0xa
	.byte	0x36
	.byte	0x13
	.long	0x359
	.uleb128 0x3
	.long	.LASF30
	.byte	0xa
	.byte	0x37
	.byte	0x14
	.long	0x36c
	.uleb128 0x3
	.long	.LASF31
	.byte	0xa
	.byte	0x38
	.byte	0x13
	.long	0x378
	.uleb128 0x3
	.long	.LASF32
	.byte	0xa
	.byte	0x39
	.byte	0x14
	.long	0x390
	.uleb128 0x3
	.long	.LASF33
	.byte	0xa
	.byte	0x3a
	.byte	0x13
	.long	0x39c
	.uleb128 0x3
	.long	.LASF34
	.byte	0xa
	.byte	0x3b
	.byte	0x14
	.long	0x3a8
	.uleb128 0x3
	.long	.LASF35
	.byte	0xa
	.byte	0x48
	.byte	0x12
	.long	0x2a
	.uleb128 0x3
	.long	.LASF36
	.byte	0xa
	.byte	0x49
	.byte	0x1b
	.long	0x3d
	.uleb128 0x26
	.byte	0x8
	.uleb128 0x7
	.long	0x433
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF37
	.uleb128 0x8
	.long	0x433
	.uleb128 0x3
	.long	.LASF38
	.byte	0xb
	.byte	0x18
	.byte	0x12
	.long	0x33a
	.uleb128 0x3
	.long	.LASF39
	.byte	0xb
	.byte	0x19
	.byte	0x13
	.long	0x359
	.uleb128 0x3
	.long	.LASF40
	.byte	0xb
	.byte	0x1a
	.byte	0x13
	.long	0x378
	.uleb128 0x8
	.long	0x457
	.uleb128 0x3
	.long	.LASF41
	.byte	0xb
	.byte	0x1b
	.byte	0x13
	.long	0x39c
	.uleb128 0x3
	.long	.LASF42
	.byte	0xc
	.byte	0x18
	.byte	0x13
	.long	0x34d
	.uleb128 0x3
	.long	.LASF43
	.byte	0xc
	.byte	0x19
	.byte	0x14
	.long	0x36c
	.uleb128 0x3
	.long	.LASF44
	.byte	0xc
	.byte	0x1a
	.byte	0x14
	.long	0x390
	.uleb128 0x8
	.long	0x48c
	.uleb128 0x3
	.long	.LASF45
	.byte	0xc
	.byte	0x1b
	.byte	0x14
	.long	0x3a8
	.uleb128 0x3
	.long	.LASF46
	.byte	0xd
	.byte	0x19
	.byte	0x18
	.long	0x3b4
	.uleb128 0x3
	.long	.LASF47
	.byte	0xd
	.byte	0x1a
	.byte	0x19
	.long	0x3cc
	.uleb128 0x3
	.long	.LASF48
	.byte	0xd
	.byte	0x1b
	.byte	0x19
	.long	0x3e4
	.uleb128 0x3
	.long	.LASF49
	.byte	0xd
	.byte	0x1c
	.byte	0x19
	.long	0x3fc
	.uleb128 0x3
	.long	.LASF50
	.byte	0xd
	.byte	0x1f
	.byte	0x19
	.long	0x3c0
	.uleb128 0x3
	.long	.LASF51
	.byte	0xd
	.byte	0x20
	.byte	0x1a
	.long	0x3d8
	.uleb128 0x3
	.long	.LASF52
	.byte	0xd
	.byte	0x21
	.byte	0x1a
	.long	0x3f0
	.uleb128 0x3
	.long	.LASF53
	.byte	0xd
	.byte	0x22
	.byte	0x1a
	.long	0x408
	.uleb128 0x3
	.long	.LASF54
	.byte	0xe
	.byte	0x2f
	.byte	0x16
	.long	0x346
	.uleb128 0x3
	.long	.LASF55
	.byte	0xe
	.byte	0x31
	.byte	0x13
	.long	0x2a
	.uleb128 0x3
	.long	.LASF56
	.byte	0xe
	.byte	0x32
	.byte	0x13
	.long	0x2a
	.uleb128 0x3
	.long	.LASF57
	.byte	0xe
	.byte	0x33
	.byte	0x13
	.long	0x2a
	.uleb128 0x3
	.long	.LASF58
	.byte	0xe
	.byte	0x3c
	.byte	0x18
	.long	0x325
	.uleb128 0x3
	.long	.LASF59
	.byte	0xe
	.byte	0x3e
	.byte	0x1b
	.long	0x3d
	.uleb128 0x3
	.long	.LASF60
	.byte	0xe
	.byte	0x3f
	.byte	0x1b
	.long	0x3d
	.uleb128 0x3
	.long	.LASF61
	.byte	0xe
	.byte	0x40
	.byte	0x1b
	.long	0x3d
	.uleb128 0x3
	.long	.LASF62
	.byte	0xe
	.byte	0x4c
	.byte	0x13
	.long	0x2a
	.uleb128 0x3
	.long	.LASF63
	.byte	0xe
	.byte	0x4f
	.byte	0x1b
	.long	0x3d
	.uleb128 0x3
	.long	.LASF64
	.byte	0xe
	.byte	0x5a
	.byte	0x15
	.long	0x414
	.uleb128 0x3
	.long	.LASF65
	.byte	0xe
	.byte	0x5b
	.byte	0x16
	.long	0x420
	.uleb128 0x4
	.byte	0x1
	.byte	0x2
	.long	.LASF66
	.uleb128 0x27
	.long	.LASF67
	.byte	0x6
	.value	0x157
	.byte	0xb
	.long	0x609
	.uleb128 0x17
	.long	.LASF68
	.byte	0xf
	.byte	0x25
	.byte	0xb
	.uleb128 0x1
	.byte	0x9
	.byte	0xcc
	.byte	0xb
	.long	0x6cd
	.uleb128 0x1
	.byte	0x9
	.byte	0xdc
	.byte	0xb
	.long	0x965
	.uleb128 0x1
	.byte	0x9
	.byte	0xe7
	.byte	0xb
	.long	0x980
	.uleb128 0x1
	.byte	0x9
	.byte	0xe8
	.byte	0xb
	.long	0x995
	.uleb128 0x1
	.byte	0x9
	.byte	0xe9
	.byte	0xb
	.long	0x9b9
	.uleb128 0x1
	.byte	0x9
	.byte	0xeb
	.byte	0xb
	.long	0x9dd
	.uleb128 0x1
	.byte	0x9
	.byte	0xec
	.byte	0xb
	.long	0x9f7
	.uleb128 0x28
	.string	"div"
	.byte	0x9
	.byte	0xd9
	.byte	0x3
	.long	.LASF141
	.long	0x6cd
	.uleb128 0x2
	.long	0x75
	.uleb128 0x2
	.long	0x75
	.byte	0
	.byte	0
	.uleb128 0x4
	.byte	0x8
	.byte	0x7
	.long	.LASF70
	.uleb128 0x4
	.byte	0x8
	.byte	0x4
	.long	.LASF71
	.uleb128 0x4
	.byte	0x4
	.byte	0x4
	.long	.LASF72
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.long	.LASF73
	.uleb128 0x8
	.long	0x61e
	.uleb128 0x4
	.byte	0x2
	.byte	0x10
	.long	.LASF74
	.uleb128 0x4
	.byte	0x4
	.byte	0x10
	.long	.LASF75
	.uleb128 0x19
	.long	.LASF76
	.byte	0x8
	.byte	0x38
	.long	0x64c
	.uleb128 0x29
	.byte	0x8
	.byte	0x3a
	.byte	0x18
	.long	0x1a6
	.byte	0
	.uleb128 0x10
	.byte	0x8
	.byte	0x3c
	.long	.LASF79
	.long	0x66f
	.uleb128 0x11
	.long	.LASF77
	.byte	0x3d
	.byte	0x9
	.long	0x384
	.uleb128 0x12
	.string	"rem"
	.byte	0x3e
	.byte	0x9
	.long	0x384
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.long	.LASF78
	.byte	0x10
	.byte	0x3f
	.byte	0x5
	.long	0x64c
	.uleb128 0x10
	.byte	0x10
	.byte	0x44
	.long	.LASF80
	.long	0x69e
	.uleb128 0x11
	.long	.LASF77
	.byte	0x45
	.byte	0xe
	.long	0x2a
	.uleb128 0x12
	.string	"rem"
	.byte	0x46
	.byte	0xe
	.long	0x2a
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF81
	.byte	0x10
	.byte	0x47
	.byte	0x5
	.long	0x67b
	.uleb128 0x10
	.byte	0x10
	.byte	0x4e
	.long	.LASF82
	.long	0x6cd
	.uleb128 0x11
	.long	.LASF77
	.byte	0x4f
	.byte	0x13
	.long	0x75
	.uleb128 0x12
	.string	"rem"
	.byte	0x50
	.byte	0x13
	.long	0x75
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	.LASF83
	.byte	0x10
	.byte	0x51
	.byte	0x5
	.long	0x6aa
	.uleb128 0x7
	.long	0x43a
	.uleb128 0x15
	.long	.LASF84
	.byte	0x10
	.value	0x3b4
	.byte	0xf
	.long	0x6eb
	.uleb128 0x7
	.long	0x6f0
	.uleb128 0x2a
	.long	0x384
	.long	0x704
	.uleb128 0x2
	.long	0x704
	.uleb128 0x2
	.long	0x704
	.byte	0
	.uleb128 0x7
	.long	0x709
	.uleb128 0x2b
	.uleb128 0x6
	.long	.LASF85
	.value	0x2de
	.byte	0xc
	.long	0x384
	.long	0x720
	.uleb128 0x2
	.long	0x720
	.byte	0
	.uleb128 0x7
	.long	0x725
	.uleb128 0x2c
	.uleb128 0x18
	.long	.LASF86
	.byte	0x10
	.value	0x2e3
	.byte	0x12
	.long	.LASF86
	.long	0x384
	.long	0x741
	.uleb128 0x2
	.long	0x720
	.byte	0
	.uleb128 0x9
	.long	.LASF88
	.byte	0x66
	.byte	0xf
	.long	0x610
	.long	0x756
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0x9
	.long	.LASF89
	.byte	0x69
	.byte	0xc
	.long	0x384
	.long	0x76b
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0x9
	.long	.LASF90
	.byte	0x6c
	.byte	0x11
	.long	0x2a
	.long	0x780
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0x6
	.long	.LASF91
	.value	0x3c0
	.byte	0xe
	.long	0x42c
	.long	0x7aa
	.uleb128 0x2
	.long	0x704
	.uleb128 0x2
	.long	0x704
	.uleb128 0x2
	.long	0x31
	.uleb128 0x2
	.long	0x31
	.uleb128 0x2
	.long	0x6de
	.byte	0
	.uleb128 0x2d
	.string	"div"
	.byte	0x10
	.value	0x3e0
	.byte	0xe
	.long	0x66f
	.long	0x7c6
	.uleb128 0x2
	.long	0x384
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0x6
	.long	.LASF92
	.value	0x305
	.byte	0xe
	.long	0x42e
	.long	0x7dc
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0x6
	.long	.LASF93
	.value	0x3e2
	.byte	0xf
	.long	0x69e
	.long	0x7f7
	.uleb128 0x2
	.long	0x2a
	.uleb128 0x2
	.long	0x2a
	.byte	0
	.uleb128 0x6
	.long	.LASF94
	.value	0x426
	.byte	0xc
	.long	0x384
	.long	0x812
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x31
	.byte	0
	.uleb128 0x6
	.long	.LASF95
	.value	0x431
	.byte	0xf
	.long	0x31
	.long	0x832
	.uleb128 0x2
	.long	0x832
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x31
	.byte	0
	.uleb128 0x7
	.long	0x61e
	.uleb128 0x6
	.long	.LASF96
	.value	0x429
	.byte	0xc
	.long	0x384
	.long	0x857
	.uleb128 0x2
	.long	0x832
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x31
	.byte	0
	.uleb128 0x1a
	.long	.LASF98
	.value	0x3ca
	.long	0x877
	.uleb128 0x2
	.long	0x42c
	.uleb128 0x2
	.long	0x31
	.uleb128 0x2
	.long	0x31
	.uleb128 0x2
	.long	0x6de
	.byte	0
	.uleb128 0x2e
	.long	.LASF97
	.byte	0x10
	.value	0x2fa
	.byte	0xd
	.long	0x88a
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0x2f
	.long	.LASF142
	.byte	0x10
	.value	0x23d
	.byte	0xc
	.long	0x384
	.uleb128 0x1a
	.long	.LASF99
	.value	0x23f
	.long	0x8a8
	.uleb128 0x2
	.long	0x333
	.byte	0
	.uleb128 0x9
	.long	.LASF100
	.byte	0x76
	.byte	0xf
	.long	0x610
	.long	0x8c2
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.byte	0
	.uleb128 0x7
	.long	0x42e
	.uleb128 0xe
	.long	.LASF101
	.byte	0x10
	.byte	0xd7
	.byte	0x11
	.long	.LASF103
	.long	0x2a
	.long	0x8eb
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0xe
	.long	.LASF104
	.byte	0x10
	.byte	0xdb
	.byte	0x1a
	.long	.LASF105
	.long	0x3d
	.long	0x90f
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0x6
	.long	.LASF106
	.value	0x39b
	.byte	0xc
	.long	0x384
	.long	0x925
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0x6
	.long	.LASF107
	.value	0x435
	.byte	0xf
	.long	0x31
	.long	0x945
	.uleb128 0x2
	.long	0x42e
	.uleb128 0x2
	.long	0x945
	.uleb128 0x2
	.long	0x31
	.byte	0
	.uleb128 0x7
	.long	0x625
	.uleb128 0x6
	.long	.LASF108
	.value	0x42d
	.byte	0xc
	.long	0x384
	.long	0x965
	.uleb128 0x2
	.long	0x42e
	.uleb128 0x2
	.long	0x61e
	.byte	0
	.uleb128 0x6
	.long	.LASF109
	.value	0x3e6
	.byte	0x1e
	.long	0x6cd
	.long	0x980
	.uleb128 0x2
	.long	0x75
	.uleb128 0x2
	.long	0x75
	.byte	0
	.uleb128 0x9
	.long	.LASF110
	.byte	0x71
	.byte	0x24
	.long	0x75
	.long	0x995
	.uleb128 0x2
	.long	0x6d9
	.byte	0
	.uleb128 0xe
	.long	.LASF111
	.byte	0x10
	.byte	0xee
	.byte	0x16
	.long	.LASF112
	.long	0x75
	.long	0x9b9
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0xe
	.long	.LASF113
	.byte	0x10
	.byte	0xf3
	.byte	0x1f
	.long	.LASF114
	.long	0x609
	.long	0x9dd
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.uleb128 0x2
	.long	0x384
	.byte	0
	.uleb128 0x9
	.long	.LASF115
	.byte	0x7c
	.byte	0xe
	.long	0x617
	.long	0x9f7
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.byte	0
	.uleb128 0x9
	.long	.LASF116
	.byte	0x7f
	.byte	0x14
	.long	0x7c
	.long	0xa11
	.uleb128 0x2
	.long	0x6d9
	.uleb128 0x2
	.long	0x8c2
	.byte	0
	.uleb128 0x19
	.long	.LASF117
	.byte	0x11
	.byte	0xf
	.long	0xa2d
	.uleb128 0x30
	.long	.LASF143
	.byte	0x11
	.byte	0x11
	.byte	0xb
	.uleb128 0x31
	.string	"v1"
	.byte	0x11
	.byte	0x13
	.byte	0x12
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	0x38b
	.uleb128 0x13
	.long	0x2af
	.quad	.LFB696
	.quad	.LFE696-.LFB696
	.uleb128 0x1
	.byte	0x9c
	.long	0xa75
	.uleb128 0xc
	.string	"_Tp"
	.long	0x384
	.uleb128 0xa
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xa2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0xa
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xa2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x13
	.long	0x2d7
	.quad	.LFB695
	.quad	.LFE695-.LFB695
	.uleb128 0x1
	.byte	0x9c
	.long	0xab4
	.uleb128 0xc
	.string	"_Tp"
	.long	0x384
	.uleb128 0x1c
	.string	"__a"
	.byte	0x14
	.long	0xa2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1c
	.string	"__b"
	.byte	0x24
	.long	0xa2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1d
	.long	.LASF126
	.byte	0x26
	.quad	.LFB694
	.quad	.LFE694-.LFB694
	.uleb128 0x1
	.byte	0x9c
	.long	0xb9a
	.uleb128 0x5
	.long	.LASF118
	.byte	0x26
	.byte	0x41
	.long	0xb9f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x5
	.long	.LASF119
	.byte	0x27
	.byte	0x3b
	.long	0xba9
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x5
	.long	.LASF120
	.byte	0x28
	.byte	0x27
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x5
	.long	.LASF121
	.byte	0x28
	.byte	0x3a
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0xd
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.uleb128 0xb
	.string	"y"
	.byte	0x29
	.byte	0x16
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0xd
	.quad	.LBB6
	.quad	.LBE6-.LBB6
	.uleb128 0xb
	.string	"row"
	.byte	0x2a
	.byte	0x1e
	.long	0xb9a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0xb
	.string	"out"
	.byte	0x2b
	.byte	0x18
	.long	0xba4
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x32
	.quad	.LBB9
	.quad	.LBE9-.LBB9
	.long	0xb79
	.uleb128 0xb
	.string	"x"
	.byte	0x2d
	.byte	0x1e
	.long	0x186
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.byte	0
	.uleb128 0xd
	.quad	.LBB10
	.quad	.LBE10-.LBB10
	.uleb128 0xb
	.string	"x"
	.byte	0x35
	.byte	0x1a
	.long	0x186
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x7
	.long	0x498
	.uleb128 0x1e
	.long	0xb9a
	.uleb128 0x7
	.long	0x48c
	.uleb128 0x1e
	.long	0xba4
	.uleb128 0x33
	.long	.LASF144
	.byte	0x1
	.byte	0x1c
	.byte	0x16
	.long	0x48c
	.quad	.LFB692
	.quad	.LFE692-.LFB692
	.uleb128 0x1
	.byte	0x9c
	.long	0xc36
	.uleb128 0xa
	.string	"row"
	.byte	0x1
	.byte	0x1c
	.byte	0x38
	.long	0xb9a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0xa
	.string	"x"
	.byte	0x1
	.byte	0x1d
	.byte	0x2f
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x5
	.long	.LASF120
	.byte	0x1d
	.byte	0x3e
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0xf
	.long	.LASF122
	.byte	0x1e
	.byte	0x17
	.long	0x193
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0xf
	.long	.LASF123
	.byte	0x1f
	.byte	0x17
	.long	0x193
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0xf
	.long	.LASF124
	.byte	0x20
	.byte	0x17
	.long	0x193
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0xf
	.long	.LASF125
	.byte	0x21
	.byte	0x17
	.long	0x193
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1b
	.long	0x44
	.uleb128 0x13
	.long	0x300
	.quad	.LFB693
	.quad	.LFE693-.LFB693
	.uleb128 0x1
	.byte	0x9c
	.long	0xc7e
	.uleb128 0xc
	.string	"_Tp"
	.long	0x3d
	.uleb128 0xa
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xc36
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0xa
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xc36
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1d
	.long	.LASF127
	.byte	0x12
	.quad	.LFB691
	.quad	.LFE691-.LFB691
	.uleb128 0x1
	.byte	0x9c
	.long	0xd04
	.uleb128 0x5
	.long	.LASF128
	.byte	0x12
	.byte	0x3c
	.long	0xb9f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x5
	.long	.LASF129
	.byte	0x13
	.byte	0x36
	.long	0xba9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x5
	.long	.LASF130
	.byte	0x14
	.byte	0x22
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0xd
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.uleb128 0xb
	.string	"i"
	.byte	0x15
	.byte	0x16
	.long	0x186
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0xd
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.uleb128 0xf
	.long	.LASF131
	.byte	0x17
	.byte	0x1c
	.long	0x463
	.uleb128 0x2
	.byte	0x91
	.sleb128 -44
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x34
	.long	.LASF132
	.byte	0x1
	.byte	0x7
	.byte	0x6
	.quad	.LFB690
	.quad	.LFE690-.LFB690
	.uleb128 0x1
	.byte	0x9c
	.long	0xd89
	.uleb128 0xa
	.string	"red"
	.byte	0x1
	.byte	0x7
	.byte	0x3d
	.long	0xb9f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x5
	.long	.LASF133
	.byte	0x8
	.byte	0x3d
	.long	0xb9f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x5
	.long	.LASF134
	.byte	0x9
	.byte	0x3d
	.long	0xb9f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x5
	.long	.LASF128
	.byte	0xa
	.byte	0x37
	.long	0xba9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x5
	.long	.LASF130
	.byte	0xb
	.byte	0x23
	.long	0x186
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0xd
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0xb
	.string	"i"
	.byte	0xc
	.byte	0x16
	.long	0x186
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
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
	.uleb128 0x6
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
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
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
	.uleb128 0x21
	.sleb128 16
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
	.uleb128 0xb
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
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x2f
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x10
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
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x47
	.uleb128 0x13
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
	.uleb128 0x14
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
	.uleb128 0x15
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
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
	.uleb128 0x10
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
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
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
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
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x20
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
	.uleb128 0x21
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
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x24
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
	.byte	0
	.byte	0
	.uleb128 0x25
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
	.uleb128 0x26
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x27
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
	.uleb128 0x28
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
	.uleb128 0x29
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
	.uleb128 0x2a
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x15
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x2d
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
	.uleb128 0x2e
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
	.uleb128 0x2f
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
	.uleb128 0x30
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
	.uleb128 0x31
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
	.uleb128 0x32
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
	.uleb128 0x33
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
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x34
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
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x5c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB693
	.quad	.LFE693-.LFB693
	.quad	.LFB695
	.quad	.LFE695-.LFB695
	.quad	.LFB696
	.quad	.LFE696-.LFB696
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
.LLRL0:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.LFB693
	.uleb128 .LFE693-.LFB693
	.byte	0x7
	.quad	.LFB695
	.uleb128 .LFE695-.LFB695
	.byte	0x7
	.quad	.LFB696
	.uleb128 .LFE696-.LFB696
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF92:
	.string	"getenv"
.LASF59:
	.string	"uint_fast16_t"
.LASF11:
	.string	"__debug"
.LASF75:
	.string	"char32_t"
.LASF142:
	.string	"rand"
.LASF143:
	.string	"execution"
.LASF106:
	.string	"system"
.LASF105:
	.string	"__isoc23_strtoul"
.LASF94:
	.string	"mblen"
.LASF16:
	.string	"unsigned int"
.LASF67:
	.string	"__gnu_cxx"
.LASF125:
	.string	"right2"
.LASF64:
	.string	"intmax_t"
.LASF61:
	.string	"uint_fast64_t"
.LASF55:
	.string	"int_fast16_t"
.LASF23:
	.string	"__int32_t"
.LASF73:
	.string	"wchar_t"
.LASF134:
	.string	"blue"
.LASF36:
	.string	"__uintmax_t"
.LASF9:
	.string	"__swappable_details"
.LASF141:
	.string	"_ZN9__gnu_cxx3divExx"
.LASF31:
	.string	"__int_least32_t"
.LASF113:
	.string	"strtoull"
.LASF68:
	.string	"__ops"
.LASF139:
	.string	"max_align_t"
.LASF140:
	.string	"_ZSt3minImERKT_S2_S2_"
.LASF5:
	.string	"__max_align_ld"
.LASF57:
	.string	"int_fast64_t"
.LASF76:
	.string	"__gnu_debug"
.LASF111:
	.string	"strtoll"
.LASF51:
	.string	"uint_least16_t"
.LASF44:
	.string	"uint32_t"
.LASF38:
	.string	"int8_t"
.LASF136:
	.string	"__int128 unsigned"
.LASF96:
	.string	"mbtowc"
.LASF12:
	.string	"min<int>"
.LASF137:
	.string	"GNU C++17 13.3.0 -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O0 -std=c++17 -fno-omit-frame-pointer -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
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
.LASF39:
	.string	"int16_t"
.LASF47:
	.string	"int_least16_t"
.LASF65:
	.string	"uintmax_t"
.LASF70:
	.string	"long long unsigned int"
.LASF22:
	.string	"__uint16_t"
.LASF53:
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
.LASF46:
	.string	"int_least8_t"
.LASF120:
	.string	"width"
.LASF41:
	.string	"int64_t"
.LASF49:
	.string	"int_least64_t"
.LASF50:
	.string	"uint_least8_t"
.LASF129:
	.string	"contrast"
.LASF32:
	.string	"__uint_least32_t"
.LASF91:
	.string	"bsearch"
.LASF26:
	.string	"__uint64_t"
.LASF103:
	.string	"__isoc23_strtol"
.LASF132:
	.string	"rgb_to_grayscale"
.LASF37:
	.string	"char"
.LASF79:
	.string	"5div_t"
.LASF74:
	.string	"char16_t"
.LASF42:
	.string	"uint8_t"
.LASF77:
	.string	"quot"
.LASF95:
	.string	"mbstowcs"
.LASF112:
	.string	"__isoc23_strtoll"
.LASF6:
	.string	"long long int"
.LASF66:
	.string	"bool"
.LASF20:
	.string	"__int16_t"
.LASF54:
	.string	"int_fast8_t"
.LASF93:
	.string	"ldiv"
.LASF84:
	.string	"__compar_fn_t"
.LASF29:
	.string	"__int_least16_t"
.LASF99:
	.string	"srand"
.LASF60:
	.string	"uint_fast32_t"
.LASF121:
	.string	"height"
.LASF17:
	.string	"__int8_t"
.LASF127:
	.string	"adjust_contrast"
.LASF25:
	.string	"__int64_t"
.LASF35:
	.string	"__intmax_t"
.LASF7:
	.string	"long double"
.LASF62:
	.string	"intptr_t"
.LASF43:
	.string	"uint16_t"
.LASF33:
	.string	"__int_least64_t"
.LASF14:
	.string	"unsigned char"
.LASF28:
	.string	"__uint_least8_t"
.LASF56:
	.string	"int_fast32_t"
.LASF21:
	.string	"short int"
.LASF2:
	.string	"long int"
.LASF128:
	.string	"gray"
.LASF123:
	.string	"left1"
.LASF122:
	.string	"left2"
.LASF85:
	.string	"atexit"
.LASF45:
	.string	"uint64_t"
.LASF133:
	.string	"green"
.LASF102:
	.string	"_ZSt3minIiERKT_S2_S2_"
.LASF81:
	.string	"ldiv_t"
.LASF19:
	.string	"__uint8_t"
.LASF118:
	.string	"source"
.LASF52:
	.string	"uint_least32_t"
.LASF13:
	.string	"max<int>"
.LASF86:
	.string	"at_quick_exit"
.LASF97:
	.string	"quick_exit"
.LASF27:
	.string	"__int_least8_t"
.LASF63:
	.string	"uintptr_t"
.LASF30:
	.string	"__uint_least16_t"
.LASF104:
	.string	"strtoul"
.LASF3:
	.string	"long unsigned int"
.LASF72:
	.string	"float"
.LASF40:
	.string	"int32_t"
.LASF48:
	.string	"int_least32_t"
.LASF135:
	.string	"__int128"
.LASF117:
	.string	"__pstl"
.LASF78:
	.string	"div_t"
.LASF69:
	.string	"min<long unsigned int>"
.LASF24:
	.string	"__uint32_t"
.LASF100:
	.string	"strtod"
.LASF115:
	.string	"strtof"
.LASF58:
	.string	"uint_fast8_t"
.LASF107:
	.string	"wcstombs"
.LASF101:
	.string	"strtol"
.LASF34:
	.string	"__uint_least64_t"
.LASF80:
	.string	"6ldiv_t"
.LASF116:
	.string	"strtold"
.LASF114:
	.string	"__isoc23_strtoull"
.LASF82:
	.string	"7lldiv_t"
.LASF119:
	.string	"destination"
.LASF18:
	.string	"signed char"
.LASF15:
	.string	"short unsigned int"
.LASF83:
	.string	"lldiv_t"
.LASF88:
	.string	"atof"
.LASF89:
	.string	"atoi"
.LASF90:
	.string	"atol"
.LASF108:
	.string	"wctomb"
.LASF71:
	.string	"double"
.LASF87:
	.string	"_ZSt3maxIiERKT_S2_S2_"
.LASF98:
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
