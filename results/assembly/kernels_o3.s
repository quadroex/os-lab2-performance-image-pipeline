	.file	"kernels.cpp"
	.intel_syntax noprefix
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O3 -std=c++17 -fno-omit-frame-pointer -fopt-info-vec-all=build/vectorization_o3.txt -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
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
	mov	r9, rdi	# red, tmp257
	mov	rdi, rsi	# green, tmp258
.LVL11:
	.loc 1 11 51 view .LVU37
	mov	rsi, rdx	# blue, tmp259
.LVL12:
	.loc 1 11 51 view .LVU38
	mov	rdx, rcx	# gray, tmp260
.LVL13:
.LBB27:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 31 discriminator 1 view .LVU39
	test	r8, r8	# count
	je	.L25	#,
	lea	rax, -1[r8]	# tmp169,
	cmp	rax, 6	# tmp169,
	jbe	.L13	#,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU40
	mov	r10d, 77	# tmp175,
	mov	rcx, r8	# bnd.15, count
.LVL14:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 31 discriminator 1 view .LVU41
	xor	eax, eax	# ivtmp.64
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU42
	vmovd	xmm4, r10d	# tmp174, tmp175
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU43
	mov	r10d, 128	# tmp193,
	shr	rcx, 3	# bnd.15,
	vmovd	xmm3, r10d	# tmp192, tmp193
	sal	rcx, 5	# _155,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU44
	vpbroadcastd	ymm4, xmm4	# tmp174, tmp174
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU45
	vpbroadcastd	ymm3, xmm3	# tmp192, tmp192
.LVL15:
	.p2align 4,,10
	.p2align 3
.L9:
	.loc 1 14 9 is_stmt 1 view .LVU46
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 is_stmt 0 view .LVU47
	vmovdqu	ymm5, YMMWORD PTR [rdi+rax]	# tmp264, MEM <const vector(8) unsigned int> [(const uint32_t *)green_21(D) + ivtmp.64_157 * 1]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU48
	vpmulld	ymm0, ymm4, YMMWORD PTR [r9+rax]	# vect__4.21, tmp174, MEM <const vector(8) unsigned int> [(const uint32_t *)red_20(D) + ivtmp.64_157 * 1]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU49
	vpslld	ymm2, ymm5, 2	# tmp178, tmp264,
	vpaddd	ymm2, ymm2, ymm5	# tmp179, tmp178,
	vpslld	ymm1, ymm2, 4	# tmp180, tmp179,
	vpsubd	ymm1, ymm1, ymm2	# vect__7.25, tmp180, tmp179
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 65 view .LVU50
	vmovdqu	ymm2, YMMWORD PTR [rsi+rax]	# vect__10.29, MEM <const vector(8) unsigned int> [(const uint32_t *)blue_22(D) + ivtmp.64_157 * 1]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU51
	vpslld	ymm1, ymm1, 1	# tmp182, vect__7.25,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU52
	vpaddd	ymm1, ymm0, ymm1	# tmp183, vect__4.21, tmp182
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU53
	vpslld	ymm0, ymm2, 3	# tmp186, vect__10.29,
	vpsubd	ymm0, ymm0, ymm2	# tmp187, tmp186, vect__10.29
	vpslld	ymm0, ymm0, 2	# tmp188, tmp187,
	vpaddd	ymm0, ymm0, ymm2	# vect__11.30, tmp188, vect__10.29
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU54
	vpaddd	ymm0, ymm0, ymm3	# tmp190, vect__11.30, tmp192
	vpaddd	ymm0, ymm1, ymm0	# vect__13.32, tmp183, tmp190
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU55
	vpsrld	ymm0, ymm0, 8	# vect__15.33, vect__13.32,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 17 view .LVU56
	vmovdqu	YMMWORD PTR [rdx+rax], ymm0	# MEM <vector(8) unsigned int> [(uint32_t *)gray_23(D) + ivtmp.64_157 * 1], vect__15.33
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU57
	.loc 1 12 31 discriminator 1 view .LVU58
	add	rax, 32	# ivtmp.64,
	cmp	rcx, rax	# _155, ivtmp.64
	jne	.L9	#,
	mov	rax, r8	# tmp.39, count
	and	rax, -8	# tmp.39,
	test	r8b, 7	# count,
	je	.L26	#,
	vzeroupper
.LVL16:
.L8:
	.loc 1 12 31 is_stmt 0 discriminator 1 view .LVU59
	mov	rcx, r8	# niters.36, count
	sub	rcx, rax	# niters.36, tmp.39
	lea	r10, -1[rcx]	# tmp197,
	cmp	r10, 2	# tmp197,
	jbe	.L11	#,
	.loc 1 14 9 is_stmt 1 view .LVU60
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 is_stmt 0 view .LVU61
	vmovdqu	xmm6, XMMWORD PTR [rdi+rax*4]	# tmp268, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp_green.45_118]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU62
	mov	r11d, 77	# tmp202,
	mov	r10, rcx	# niters_vector_mult_vf.38, niters.36
	vmovd	xmm0, r11d	# tmp202, tmp202
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU63
	mov	r11d, 128	# tmp220,
	and	r10, -4	# niters_vector_mult_vf.38,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU64
	vpslld	xmm2, xmm6, 2	# tmp205, tmp268,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU65
	vpshufd	xmm0, xmm0, 0	# tmp201, tmp202
	vpmulld	xmm0, xmm0, XMMWORD PTR [r9+rax*4]	# vect__57.43, tmp201, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp_red.41_111]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU66
	vpaddd	xmm2, xmm2, xmm6	# tmp206, tmp205,
	vpslld	xmm1, xmm2, 4	# tmp207, tmp206,
	vpsubd	xmm1, xmm1, xmm2	# vect__54.47, tmp207, tmp206
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 65 view .LVU67
	vmovdqu	xmm2, XMMWORD PTR [rsi+rax*4]	# vect__51.51, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp_blue.50_126]
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU68
	vpslld	xmm1, xmm1, 1	# tmp209, vect__54.47,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU69
	vpaddd	xmm0, xmm0, xmm1	# tmp210, vect__57.43, tmp209
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU70
	vpslld	xmm1, xmm2, 3	# tmp213, vect__51.51,
	vpsubd	xmm1, xmm1, xmm2	# tmp214, tmp213, vect__51.51
	vpslld	xmm1, xmm1, 2	# tmp215, tmp214,
	vpaddd	xmm1, xmm1, xmm2	# vect__50.52, tmp215, vect__51.51
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU71
	vmovd	xmm2, r11d	# tmp220, tmp220
	vpshufd	xmm2, xmm2, 0	# tmp219, tmp220
	vpaddd	xmm1, xmm1, xmm2	# tmp217, vect__50.52, tmp219
	vpaddd	xmm0, xmm0, xmm1	# vect__48.54, tmp210, tmp217
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU72
	vpsrld	xmm0, xmm0, 8	# vect__46.55, vect__48.54,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 17 view .LVU73
	vmovdqu	XMMWORD PTR [rdx+rax*4], xmm0	# MEM <vector(4) unsigned int> [(uint32_t *)vectp_gray.57_137], vect__46.55
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU74
	.loc 1 12 31 discriminator 1 view .LVU75
	add	rax, r10	# tmp.39, niters_vector_mult_vf.38
	and	ecx, 3	# niters.36,
	je	.L25	#,
.L11:
.LVL17:
	.loc 1 14 9 view .LVU76
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 is_stmt 0 view .LVU77
	imul	r11d, DWORD PTR [r9+rax*4], 77	# tmp225, *_3,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 31 view .LVU78
	lea	rcx, 0[0+rax*4]	# _2,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU79
	imul	r10d, DWORD PTR [rdi+rax*4], 150	# tmp227, *_6,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU80
	lea	r10d, 128[r11+r10]	# tmp230,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU81
	imul	r11d, DWORD PTR [rsi+rax*4], 29	# tmp231, *_10,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU82
	add	r10d, r11d	# tmp233, tmp231
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU83
	shr	r10d, 8	# tmp234,
	mov	DWORD PTR [rdx+rax*4], r10d	# *_15, tmp234
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU84
	.loc 1 12 31 discriminator 1 view .LVU85
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 5 is_stmt 0 discriminator 3 view .LVU86
	lea	r10, 1[rax]	# i,
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 31 discriminator 1 view .LVU87
	cmp	r10, r8	# i, count
	jnb	.L25	#,
	.loc 1 14 9 is_stmt 1 view .LVU88
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 is_stmt 0 view .LVU89
	imul	r11d, DWORD PTR 4[rdi+rcx], 150	# tmp236, *_53,
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 5 discriminator 3 view .LVU90
	add	rax, 2	# i,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 view .LVU91
	imul	r10d, DWORD PTR 4[r9+rcx], 77	# tmp238, *_56,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU92
	lea	r10d, 128[r11+r10]	# tmp241,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU93
	imul	r11d, DWORD PTR 4[rsi+rcx], 29	# tmp242, *_49,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU94
	add	r10d, r11d	# tmp244, tmp242
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU95
	shr	r10d, 8	# tmp245,
	mov	DWORD PTR 4[rdx+rcx], r10d	# *_81, tmp245
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU96
	.loc 1 12 31 discriminator 1 view .LVU97
	cmp	rax, r8	# i, count
	jnb	.L25	#,
	.loc 1 14 9 view .LVU98
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 24 is_stmt 0 view .LVU99
	imul	r8d, DWORD PTR 8[r9+rcx], 77	# tmp247, *_86,
.LVL18:
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 40 view .LVU100
	imul	eax, DWORD PTR 8[rdi+rcx], 150	# tmp249, *_89,
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 57 view .LVU101
	imul	esi, DWORD PTR 8[rsi+rcx], 29	# tmp253, *_93,
.LVL19:
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 67 view .LVU102
	lea	eax, 128[r8+rax]	# tmp252,
	add	eax, esi	# tmp255, tmp253
# src/kernels.cpp:14:         gray[i] = (77u * red[i] + 150u * green[i] + 29u * blue[i] + 128u) >> 8;
	.loc 1 14 75 view .LVU103
	shr	eax, 8	# tmp256,
	mov	DWORD PTR 8[rdx+rcx], eax	# *_98, tmp256
	.loc 1 12 5 is_stmt 1 discriminator 3 view .LVU104
	.loc 1 12 31 discriminator 1 view .LVU105
.LVL20:
.L25:
	.loc 1 12 31 is_stmt 0 discriminator 1 view .LVU106
.LBE27:
# src/kernels.cpp:16: }
	.loc 1 16 1 view .LVU107
	ret	
.LVL21:
	.p2align 4,,10
	.p2align 3
.L26:
	.loc 1 16 1 view .LVU108
	vzeroupper
.LVL22:
	ret	
.LVL23:
.L13:
.LBB28:
# src/kernels.cpp:12:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 12 22 view .LVU109
	xor	eax, eax	# tmp.39
	jmp	.L8	#
.LBE28:
	.cfi_endproc
.LFE700:
	.size	rgb_to_grayscale, .-rgb_to_grayscale
	.p2align 4
	.globl	adjust_contrast
	.type	adjust_contrast, @function
adjust_contrast:
.LVL24:
.LFB701:
	.loc 1 20 50 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 20 50 is_stmt 0 view .LVU111
	endbr64	
	.loc 1 21 5 is_stmt 1 view .LVU112
.LVL25:
.LBB29:
	.loc 1 21 31 discriminator 1 view .LVU113
.LBE29:
# src/kernels.cpp:20:                      std::size_t count) noexcept {
	.loc 1 20 50 is_stmt 0 view .LVU114
	mov	rcx, rsi	# contrast, tmp219
.LBB53:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 31 discriminator 1 view .LVU115
	test	rdx, rdx	# count
	je	.L57	#,
	lea	rax, -1[rdx]	# tmp148,
	cmp	rax, 6	# tmp148,
	jbe	.L43	#,
.LBB30:
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU116
	mov	esi, 1	# tmp157,
.LVL26:
	.loc 1 23 76 view .LVU117
	mov	r8, rdx	# bnd.80, count
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 discriminator 2 view .LVU118
	vpxor	xmm6, xmm6, xmm6	# tmp166
.LBE30:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 31 discriminator 1 view .LVU119
	xor	eax, eax	# ivtmp.123
.LBB45:
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU120
	vmovd	xmm5, esi	# tmp156, tmp157
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU121
	mov	esi, -64	# tmp161,
	shr	r8, 3	# bnd.80,
	vmovd	xmm4, esi	# tmp160, tmp161
	mov	esi, 254	# tmp164,
	sal	r8, 5	# _116,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU122
	vpbroadcastd	ymm5, xmm5	# tmp156, tmp156
	vmovd	xmm3, esi	# tmp163, tmp164
	mov	esi, 255	# tmp169,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU123
	vpbroadcastd	ymm4, xmm4	# tmp160, tmp160
	vmovd	xmm2, esi	# tmp168, tmp169
	vpbroadcastd	ymm3, xmm3	# tmp163, tmp163
	vpbroadcastd	ymm2, xmm2	# tmp168, tmp168
.LVL27:
	.p2align 4,,10
	.p2align 3
.L30:
	.loc 1 23 9 is_stmt 1 view .LVU124
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU125
	vmovdqu	ymm7, YMMWORD PTR [rdi+rax]	# tmp223, MEM <const vector(8) unsigned int> [(const uint32_t *)gray_16(D) + ivtmp.123_73 * 1]
	vpslld	ymm0, ymm7, 1	# tmp152, tmp223,
	vpaddd	ymm0, ymm0, ymm7	# vect__4.86, tmp152,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU126
	vpaddd	ymm0, ymm0, ymm5	# vect__5.87, vect__4.86, tmp156
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU127
	vpsrld	ymm0, ymm0, 1	# vect__6.88, vect__5.87,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU128
	vpaddd	ymm0, ymm0, ymm4	# vect__8.90, vect__6.88, tmp160
	.loc 1 24 9 is_stmt 1 view .LVU129
.LBB31:
.LBI31:
	.loc 2 257 5 view .LVU130
.LBE31:
.LBB35:
.LBI35:
	.loc 2 233 5 view .LVU131
.LBE35:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 is_stmt 0 discriminator 2 view .LVU132
	vpmaxsd	ymm1, ymm0, ymm6	# vect__47.91, vect__8.90, tmp166
	vpcmpgtd	ymm0, ymm0, ymm3	# tmp170, vect__8.90, tmp163
	vpblendvb	ymm0, ymm1, ymm2, ymm0	# tmp171, vect__47.91, tmp168, tmp170
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU133
	vmovdqu	YMMWORD PTR [rcx+rax], ymm0	# MEM <vector(8) unsigned int> [(uint32_t *)contrast_21(D) + ivtmp.123_73 * 1], tmp171
.LBE45:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU134
	.loc 1 21 31 discriminator 1 view .LVU135
	add	rax, 32	# ivtmp.123,
	cmp	rax, r8	# ivtmp.123, _116
	jne	.L30	#,
	mov	rax, rdx	# tmp.101, count
	and	rax, -8	# tmp.101,
	test	dl, 7	# count,
	je	.L59	#,
	vzeroupper
.LVL28:
.L29:
	.loc 1 21 31 is_stmt 0 discriminator 1 view .LVU136
	mov	rsi, rdx	# niters.98, count
	sub	rsi, rax	# niters.98, tmp.101
	lea	r8, -1[rsi]	# tmp173,
	cmp	r8, 2	# tmp173,
	jbe	.L34	#,
.LBB46:
	.loc 1 23 9 is_stmt 1 view .LVU137
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU138
	vmovdqu	xmm3, XMMWORD PTR [rdi+rax*4]	# tmp226, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp_gray.103_125]
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU139
	mov	r10d, 1	# tmp181,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU140
	mov	r11d, -64	# tmp185,
	mov	r8, rsi	# niters_vector_mult_vf.100, niters.98
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU141
	vmovd	xmm1, r10d	# tmp181, tmp181
	mov	r9d, 254	# tmp188,
	mov	r10d, 255	# tmp193,
	and	r8, -4	# niters_vector_mult_vf.100,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 view .LVU142
	vpslld	xmm0, xmm3, 1	# tmp176, tmp226,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU143
	vpshufd	xmm1, xmm1, 0	# tmp180, tmp181
	vmovd	xmm2, r9d	# tmp188, tmp188
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 view .LVU144
	vpaddd	xmm0, xmm0, xmm3	# vect__52.105, tmp176,
	vpshufd	xmm2, xmm2, 0	# tmp187, tmp188
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU145
	vpaddd	xmm0, xmm0, xmm1	# vect__53.106, vect__52.105, tmp180
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU146
	vmovd	xmm1, r11d	# tmp185, tmp185
	vpshufd	xmm1, xmm1, 0	# tmp184, tmp185
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU147
	vpsrld	xmm0, xmm0, 1	# vect__54.107, vect__53.106,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU148
	vpaddd	xmm0, xmm0, xmm1	# vect__56.109, vect__54.107, tmp184
	.loc 1 24 9 is_stmt 1 view .LVU149
.LBB39:
	.loc 2 257 5 view .LVU150
.LBE39:
.LBB40:
	.loc 2 233 5 view .LVU151
.LBE40:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 is_stmt 0 discriminator 2 view .LVU152
	vpxor	xmm1, xmm1, xmm1	# tmp190
	vpmaxsd	xmm1, xmm0, xmm1	# vect__57.110, vect__56.109, tmp190
	vpcmpgtd	xmm0, xmm0, xmm2	# tmp194, vect__56.109, tmp187
	vmovd	xmm2, r10d	# tmp193, tmp193
	vpshufd	xmm2, xmm2, 0	# tmp192, tmp193
	vpblendvb	xmm0, xmm1, xmm2, xmm0	# tmp195, vect__57.110, tmp192, tmp194
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU153
	vmovdqu	XMMWORD PTR [rcx+rax*4], xmm0	# MEM <vector(4) unsigned int> [(uint32_t *)vectp_contrast.116_146], tmp195
.LBE46:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU154
	.loc 1 21 31 discriminator 1 view .LVU155
	add	rax, r8	# tmp.101, niters_vector_mult_vf.100
	and	esi, 3	# niters.98,
	je	.L57	#,
.L34:
.LVL29:
.LBB47:
	.loc 1 23 9 view .LVU156
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU157
	mov	esi, DWORD PTR [rdi+rax*4]	# *_2, *_2
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 74 view .LVU158
	lea	r8, 0[0+rax*4]	# _1,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU159
	lea	esi, 1[rsi+rsi*2]	# tmp202,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU160
	shr	esi	# tmp203
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU161
	sub	esi, 64	# _8,
	.loc 1 24 9 is_stmt 1 view .LVU162
.LVL30:
.LBB41:
	.loc 2 257 5 view .LVU163
.LBB32:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 7 is_stmt 0 view .LVU164
	test	esi, esi	# _8
	jg	.L60	#,
	xor	esi, esi	# _8
.LVL31:
.L36:
	.loc 2 262 7 view .LVU165
.LBE32:
.LBE41:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 discriminator 2 view .LVU166
	mov	r9d, esi	# _44, _8
.L37:
.LBE47:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 5 discriminator 3 view .LVU167
	lea	rsi, 1[rax]	# i,
.LBB48:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU168
	mov	DWORD PTR [rcx+r8], r9d	# *_45, _44
.LBE48:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU169
	.loc 1 21 31 discriminator 1 view .LVU170
	cmp	rsi, rdx	# i, count
	jnb	.L57	#,
.LBB49:
	.loc 1 23 9 view .LVU171
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU172
	mov	esi, DWORD PTR 4[rdi+r8]	# *_51, *_51
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU173
	lea	esi, 1[rsi+rsi*2]	# tmp209,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU174
	shr	esi	# tmp210
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU175
	sub	esi, 64	# _57,
	.loc 1 24 9 is_stmt 1 view .LVU176
.LVL32:
.LBB42:
	.loc 2 257 5 view .LVU177
.LBB33:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 7 is_stmt 0 view .LVU178
	test	esi, esi	# _57
	jg	.L61	#,
	xor	esi, esi	# _57
.LVL33:
.L38:
	.loc 2 262 7 view .LVU179
.LBE33:
.LBE42:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 discriminator 2 view .LVU180
	mov	r9d, esi	# _59, _57
.L39:
.LBE49:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 5 discriminator 3 view .LVU181
	add	rax, 2	# i,
.LBB50:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU182
	mov	DWORD PTR 4[rcx+r8], r9d	# *_62, _59
.LBE50:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU183
	.loc 1 21 31 discriminator 1 view .LVU184
	cmp	rax, rdx	# i, count
	jnb	.L57	#,
.LBB51:
	.loc 1 23 9 view .LVU185
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 66 is_stmt 0 view .LVU186
	mov	eax, DWORD PTR 8[rdi+r8]	# *_103, *_103
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 76 view .LVU187
	lea	eax, 1[rax+rax*2]	# tmp216,
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 82 view .LVU188
	shr	eax	# tmp217
# src/kernels.cpp:23:         const std::int32_t value = static_cast<std::int32_t>((3u * gray[i] + 1u) >> 1) - 64;
	.loc 1 23 88 view .LVU189
	sub	eax, 64	# prephitmp_96,
	.loc 1 24 9 is_stmt 1 view .LVU190
.LVL34:
.LBB43:
	.loc 2 257 5 view .LVU191
.LBB34:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	.loc 2 262 7 is_stmt 0 view .LVU192
	test	eax, eax	# prephitmp_96
	jg	.L40	#,
	xor	eax, eax	# prephitmp_96
.LVL35:
.L41:
	.loc 2 262 7 view .LVU193
.LBE34:
.LBE43:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 23 discriminator 2 view .LVU194
	mov	edx, eax	# prephitmp_110, prephitmp_96
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU195
	mov	DWORD PTR 8[rcx+r8], edx	# *_111, prephitmp_110
.LBE51:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU196
	.loc 1 21 31 discriminator 1 view .LVU197
	ret	
.LVL36:
	.p2align 4,,10
	.p2align 3
.L57:
	.loc 1 21 31 is_stmt 0 discriminator 1 view .LVU198
.LBE53:
# src/kernels.cpp:26: }
	.loc 1 26 1 view .LVU199
	ret	
.LVL37:
	.p2align 4,,10
	.p2align 3
.L60:
.LBB54:
.LBB52:
.LBB44:
	.loc 2 233 5 is_stmt 1 view .LVU200
.LBB36:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 is_stmt 0 view .LVU201
	mov	r9d, 255	# _44,
	cmp	esi, 254	# _8,
	jg	.L37	#,
	jmp	.L36	#
.LVL38:
	.p2align 4,,10
	.p2align 3
.L61:
	.loc 2 238 7 view .LVU202
.LBE36:
	.loc 2 233 5 is_stmt 1 view .LVU203
.LBB37:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 is_stmt 0 view .LVU204
	mov	r9d, 255	# _59,
	cmp	esi, 254	# _57,
	jg	.L39	#,
	jmp	.L38	#
.LVL39:
	.p2align 4,,10
	.p2align 3
.L40:
	.loc 2 238 7 view .LVU205
.LBE37:
	.loc 2 233 5 is_stmt 1 view .LVU206
.LBB38:
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	.loc 2 238 7 is_stmt 0 view .LVU207
	mov	edx, 255	# prephitmp_110,
.LVL40:
	.loc 2 238 7 view .LVU208
	cmp	eax, 254	# prephitmp_96,
	jle	.L41	#,
.LVL41:
	.loc 2 238 7 view .LVU209
.LBE38:
.LBE44:
# src/kernels.cpp:24:         contrast[i] = static_cast<std::uint32_t>(std::min(255, std::max(0, value)));
	.loc 1 24 21 discriminator 2 view .LVU210
	mov	DWORD PTR 8[rcx+r8], edx	# *_111, prephitmp_110
.LBE52:
	.loc 1 21 5 is_stmt 1 discriminator 3 view .LVU211
	.loc 1 21 31 discriminator 1 view .LVU212
	ret	
.LVL42:
	.p2align 4,,10
	.p2align 3
.L59:
	.loc 1 21 31 is_stmt 0 discriminator 1 view .LVU213
	vzeroupper
.LVL43:
	ret	
.LVL44:
.L43:
# src/kernels.cpp:21:     for (std::size_t i = 0; i < count; ++i) {
	.loc 1 21 22 view .LVU214
	xor	eax, eax	# tmp.101
	jmp	.L29	#
.LBE54:
	.cfi_endproc
.LFE701:
	.size	adjust_contrast, .-adjust_contrast
	.p2align 4
	.globl	horizontal_blur_5tap
	.type	horizontal_blur_5tap, @function
horizontal_blur_5tap:
.LVL45:
.LFB705:
	.loc 1 40 75 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 40 75 is_stmt 0 view .LVU216
	endbr64	
	.loc 1 41 5 is_stmt 1 view .LVU217
.LVL46:
.LBB73:
	.loc 1 41 31 discriminator 1 view .LVU218
.LBE73:
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 is_stmt 0 view .LVU219
	push	rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp	#,
	.cfi_def_cfa_register 6
	push	r15	#
	push	r14	#
	push	r13	#
	push	r12	#
	push	rbx	#
	and	rsp, -32	#,
	add	rsp, -128	#,
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# src/kernels.cpp:40:                           std::size_t width, std::size_t height) noexcept {
	.loc 1 40 75 view .LVU220
	mov	QWORD PTR 104[rsp], rsi	# %sfp, destination
	mov	QWORD PTR 96[rsp], rcx	# %sfp, height
.LBB96:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 31 discriminator 1 view .LVU221
	test	rcx, rcx	# height
	je	.L99	#,
	mov	rbx, rdi	# source, tmp587
	mov	r9, rdi	# ivtmp.243, source
	lea	rdi, -4[rdx]	# niters.134,
.LVL47:
	.loc 1 41 31 discriminator 1 view .LVU222
	mov	r10, rsi	# ivtmp.251, destination
	mov	rcx, rdi	# niters_vector_mult_vf.136, niters.134
.LVL48:
	.loc 1 41 31 discriminator 1 view .LVU223
	mov	QWORD PTR 80[rsp], rdi	# %sfp, niters.134
	mov	r11, rdx	# width, tmp589
.LBB74:
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 22 view .LVU224
	xor	r15d, r15d	# ivtmp.252
	lea	rax, 0[0+rdx*4]	# _37,
	and	rcx, -8	# niters_vector_mult_vf.136,
.LBE74:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 22 view .LVU225
	mov	QWORD PTR 120[rsp], 0	# %sfp,
.LBB94:
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 22 view .LVU226
	mov	QWORD PTR 88[rsp], rax	# %sfp, _37
	lea	rax, -5[rdx]	# _149,
	lea	rsi, 2[rcx]	# tmp.137,
.LVL49:
	.loc 1 57 22 view .LVU227
	mov	QWORD PTR 72[rsp], rax	# %sfp, _149
	mov	rax, rdi	# bnd.135, niters.134
	shr	rax, 3	# bnd.135,
	mov	QWORD PTR 32[rsp], rcx	# %sfp, niters_vector_mult_vf.136
.LBB75:
.LBB76:
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 54 view .LVU228
	lea	rcx, -1[rdx]	# _102,
	sal	rax, 5	# bnd.135,
	mov	QWORD PTR 40[rsp], rsi	# %sfp, tmp.137
.LBE76:
.LBE75:
.LBB80:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 discriminator 1 view .LVU229
	lea	rsi, -2[rdx]	# _143,
	mov	r14, rax	# _208, bnd.135
	mov	rax, rdi	# tmp585, niters.134
.LBE80:
.LBB81:
.LBB77:
# src/kernels.cpp:32:     const std::size_t right1 = std::min(x + 1, width - 1);
	.loc 1 32 54 view .LVU230
	mov	QWORD PTR 64[rsp], rcx	# %sfp, _102
.LBE77:
.LBE81:
.LBB82:
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU231
	mov	ecx, 8	# tmp582,
	and	eax, 7	# tmp585,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 discriminator 1 view .LVU232
	mov	QWORD PTR 112[rsp], rsi	# %sfp, _143
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU233
	vmovd	xmm2, ecx	# tmp582, tmp582
	mov	QWORD PTR 56[rsp], rax	# %sfp, tmp585
	vpshufd	xmm3, xmm2, 0	# tmp583, tmp582
	vpbroadcastd	ymm2, xmm2	# tmp584, tmp582
	mov	QWORD PTR 48[rsp], r14	# %sfp, _208
.LVL50:
	.p2align 4,,10
	.p2align 3
.L75:
	.loc 1 55 54 view .LVU234
.LBE82:
	.loc 1 42 9 is_stmt 1 view .LVU235
	.loc 1 43 9 view .LVU236
	.loc 1 44 9 view .LVU237
.LBB83:
	cmp	r11, 4	# width,
	jbe	.L101	#,
.LBE83:
	.loc 1 50 9 view .LVU238
.LVL51:
.LBB85:
.LBI75:
	.loc 1 28 22 view .LVU239
.LBB78:
	.loc 1 30 5 view .LVU240
	.loc 1 31 5 view .LVU241
	.loc 1 32 5 view .LVU242
	.loc 1 33 5 view .LVU243
	.loc 1 34 5 view .LVU244
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 42 is_stmt 0 view .LVU245
	mov	edx, DWORD PTR [r9]	# _114, MEM[(const uint32_t *)row_56]
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 44 view .LVU246
	mov	esi, DWORD PTR 8[r9]	# _133, MEM[(const uint32_t *)row_56 + 8B]
.LVL52:
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 30 view .LVU247
	mov	ecx, DWORD PTR 4[r9]	# _128, MEM[(const uint32_t *)row_56 + 4B]
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU248
	lea	eax, 0[0+rdx*4]	# tmp377,
	lea	edi, 8[rdx]	# _48,
	add	edx, eax	# tmp378, tmp377
.LBE78:
.LBE85:
.LBB86:
.LBB87:
	add	eax, edi	# tmp386, _48
	add	eax, DWORD PTR 12[r9]	# tmp387, MEM[(const uint32_t *)row_56 + 12B]
.LBE87:
.LBE86:
.LBB89:
.LBB79:
	lea	edx, [rsi+rdx*2]	# tmp380,
	add	edx, edi	# tmp381, _48
	lea	edx, [rdx+rcx*4]	# tmp383,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 view .LVU249
	shr	edx, 4	# tmp384,
	mov	DWORD PTR [r10], edx	# MEM[(uint32_t *)out_58], tmp384
.LBE79:
.LBE89:
	.loc 1 51 9 is_stmt 1 view .LVU250
.LVL53:
.LBB90:
.LBI86:
	.loc 1 28 22 view .LVU251
.LBB88:
	.loc 1 30 5 view .LVU252
	.loc 1 31 5 view .LVU253
	.loc 1 32 5 view .LVU254
	.loc 1 33 5 view .LVU255
	.loc 1 34 5 view .LVU256
# src/kernels.cpp:34:     return (row[left2] + 4u * row[left1] + 6u * row[x]
	.loc 1 34 47 is_stmt 0 view .LVU257
	lea	edx, [rcx+rcx*2]	# tmp391,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 46 view .LVU258
	lea	eax, [rax+rdx*2]	# tmp393,
	lea	eax, [rax+rsi*4]	# tmp395,
# src/kernels.cpp:35:             + 4u * row[right1] + row[right2] + 8u) >> 4;
	.loc 1 35 55 view .LVU259
	shr	eax, 4	# tmp396,
	cmp	QWORD PTR 72[rsp], 6	# %sfp,
	mov	DWORD PTR 4[r10], eax	# MEM[(uint32_t *)out_58 + 4B], tmp396
.LBE88:
.LBE90:
	.loc 1 53 9 is_stmt 1 view .LVU260
.LVL54:
.LBB91:
	.loc 1 53 35 discriminator 1 view .LVU261
	jbe	.L77	#,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 is_stmt 0 discriminator 1 view .LVU262
	mov	r12, QWORD PTR 48[rsp]	# _208, %sfp
	lea	r8, 8[r9]	# vectp.142,
	lea	rdi, 4[r9]	# vectp.146,
	xor	eax, eax	# ivtmp.228
	lea	rsi, 12[r9]	# vectp.150,
	lea	rcx, 16[r9]	# vectp.156,
	lea	rdx, 8[r10]	# vectp.162,
.LVL55:
	.p2align 4,,10
	.p2align 3
.L70:
	.loc 1 54 13 is_stmt 1 view .LVU263
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 is_stmt 0 view .LVU264
	vmovdqu	ymm7, YMMWORD PTR [r8+rax]	# tmp631, MEM <const vector(8) unsigned int> [(const uint32_t *)vectp.142_127 + ivtmp.228_395 * 1]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU265
	vmovdqu	ymm6, YMMWORD PTR [rcx+rax]	# tmp630, MEM <const vector(8) unsigned int> [(const uint32_t *)vectp.156_86 + ivtmp.228_395 * 1]
	vpaddd	ymm0, ymm6, YMMWORD PTR [r9+rax]	# tmp399, tmp630, MEM <const vector(8) unsigned int> [(const uint32_t *)row_56 + ivtmp.228_395 * 1]
	vmovdqu	ymm5, YMMWORD PTR [rsi+rax]	# tmp632, MEM <const vector(8) unsigned int> [(const uint32_t *)vectp.150_104 + ivtmp.228_395 * 1]
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU266
	vpslld	ymm1, ymm7, 1	# tmp402, tmp631,
	vpaddd	ymm1, ymm1, ymm7	# vect__14.144, tmp402,
	vpslld	ymm1, ymm1, 1	# tmp404, vect__14.144,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU267
	vpaddd	ymm1, ymm1, ymm2	# tmp405, tmp404, tmp584
	vpaddd	ymm0, ymm0, ymm1	# tmp409, tmp399, tmp405
	vpaddd	ymm1, ymm5, YMMWORD PTR [rdi+rax]	# vect__35.152, tmp632, MEM <const vector(8) unsigned int> [(const uint32_t *)vectp.146_113 + ivtmp.228_395 * 1]
	vpslld	ymm1, ymm1, 2	# vect__67.153, vect__35.152,
	vpaddd	ymm0, ymm0, ymm1	# vect__32.159, tmp409, vect__67.153
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU268
	vpsrld	ymm0, ymm0, 4	# vect__34.160, vect__32.159,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 view .LVU269
	vmovdqu	YMMWORD PTR [rdx+rax], ymm0	# MEM <vector(8) unsigned int> [(uint32_t *)vectp.162_74 + ivtmp.228_395 * 1], vect__34.160
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU270
	.loc 1 53 35 discriminator 1 view .LVU271
	add	rax, 32	# ivtmp.228,
	cmp	r12, rax	# _208, ivtmp.228
	jne	.L70	#,
	cmp	QWORD PTR 56[rsp], 0	# %sfp,
	je	.L71	#,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 is_stmt 0 view .LVU272
	mov	rcx, QWORD PTR 32[rsp]	# _139, %sfp
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 26 view .LVU273
	mov	rax, QWORD PTR 40[rsp]	# tmp.166, %sfp
.L69:
	.loc 1 53 26 view .LVU274
	mov	rdx, r11	# _25, width
	sub	rdx, rcx	# _25, _139
	lea	rsi, -4[rdx]	# niters.163,
	sub	rdx, 5	# tmp417,
	cmp	rdx, 2	# tmp417,
	jbe	.L72	#,
	add	rcx, r15	# tmp418, ivtmp.252
	lea	rdx, 0[0+rcx*4]	# _219,
	.loc 1 54 13 is_stmt 1 view .LVU275
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 is_stmt 0 view .LVU276
	vpaddd	xmm1, xmm3, XMMWORD PTR [rbx+rcx*4]	# tmp427, tmp583, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp.168_217]
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 view .LVU277
	mov	rcx, QWORD PTR 104[rsp]	# destination, %sfp
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU278
	vmovdqu	xmm4, XMMWORD PTR 8[rbx+rdx]	# tmp635, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp.171_223]
	vpslld	xmm0, xmm4, 1	# tmp421, tmp635,
	vpaddd	xmm0, xmm0, xmm4	# vect__180.173, tmp421,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU279
	vmovdqu	xmm4, XMMWORD PTR 4[rbx+rdx]	# tmp636, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp.175_232]
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU280
	vpslld	xmm0, xmm0, 1	# tmp423, vect__180.173,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU281
	vpaddd	xmm0, xmm0, XMMWORD PTR 16[rbx+rdx]	# tmp425, tmp423, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp.185_252]
	vpaddd	xmm0, xmm0, xmm1	# tmp431, tmp425, tmp427
	vpaddd	xmm1, xmm4, XMMWORD PTR 12[rbx+rdx]	# vect__171.181, tmp636, MEM <const vector(4) unsigned int> [(const uint32_t *)vectp.179_240]
	vpslld	xmm1, xmm1, 2	# vect__170.182, vect__171.181,
	vpaddd	xmm0, xmm0, xmm1	# vect__156.188, tmp431, vect__170.182
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU282
	vpsrld	xmm0, xmm0, 4	# vect__154.189, vect__156.188,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 view .LVU283
	vmovdqu	XMMWORD PTR 8[rcx+rdx], xmm0	# MEM <vector(4) unsigned int> [(uint32_t *)vectp.191_262], vect__154.189
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU284
	.loc 1 53 35 discriminator 1 view .LVU285
	mov	rdx, rsi	# niters_vector_mult_vf.165, niters.163
	and	rdx, -4	# niters_vector_mult_vf.165,
	add	rax, rdx	# tmp.166, niters_vector_mult_vf.165
	and	esi, 3	# niters.163,
	je	.L71	#,
.L72:
	.loc 1 53 35 is_stmt 0 discriminator 1 view .LVU286
	lea	rdx, [rax+r15]	# tmp440,
	lea	rcx, 1[rax]	# _16,
	lea	rdx, [rbx+rdx*4]	# _9,
	cmp	QWORD PTR 112[rsp], rcx	# %sfp, _16
	jb	.L78	#,
	mov	rdi, QWORD PTR 80[rsp]	# niters.134, %sfp
	cmp	rcx, rdi	# _16, niters.134
	jnb	.L78	#,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 32 view .LVU287
	lea	rcx, 0[0+rax*4]	# _400,
	mov	r8d, DWORD PTR [rdx]	# _230, *_9
	mov	esi, DWORD PTR 4[rdx]	# _233, MEM[(const uint32_t *)_9 + 4B]
.LVL56:
	.loc 1 54 13 is_stmt 1 view .LVU288
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 is_stmt 0 view .LVU289
	mov	edi, DWORD PTR 8[r9+rcx]	# _421, *_420
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU290
	mov	r12d, DWORD PTR -8[r9+rcx]	# tmp446, *_402
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU291
	lea	r13d, [r8+r8*2]	# tmp451,
	lea	r14d, [rsi+rsi*2]	# tmp464,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU292
	add	r12d, edi	# tmp446, _421
	lea	r12d, 8[r12+r13*2]	# tmp453,
	mov	r13d, DWORD PTR -4[rdx]	# tmp454, MEM[(const uint32_t *)_9 + -4B]
	add	r13d, esi	# tmp454, _233
	lea	edx, [r12+r13*4]	# tmp457,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU293
	mov	r12d, DWORD PTR 12[r9+rcx]	# _449, *_448
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU294
	mov	r13d, DWORD PTR -4[r9+rcx]	# tmp459, *_408
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU295
	shr	edx, 4	# tmp458,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU296
	add	r13d, r12d	# tmp459, _449
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU297
	mov	DWORD PTR [r10+rax*4], edx	# *_425, tmp458
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU298
.LVL57:
	.loc 1 53 35 discriminator 1 view .LVU299
	.loc 1 54 13 view .LVU300
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 is_stmt 0 view .LVU301
	add	esi, r12d	# tmp478, _449
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU302
	lea	rdx, 3[rax]	# _157,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU303
	lea	r13d, 8[r13+r14*2]	# tmp466,
	lea	r14d, [r8+rdi]	# tmp467,
	lea	r13d, 0[r13+r14*4]	# tmp469,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU304
	lea	r14d, [rdi+rdi*2]	# tmp475,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU305
	shr	r13d, 4	# tmp470,
	mov	DWORD PTR 4[r10+rcx], r13d	# *_453, tmp470
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU306
.LVL58:
	.loc 1 53 35 discriminator 1 view .LVU307
	.loc 1 54 13 view .LVU308
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 is_stmt 0 view .LVU309
	mov	r13d, DWORD PTR 16[r9+rcx]	# _477, *_476
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU310
	lea	r8d, 8[r8+r13]	# tmp472,
	lea	r8d, [r8+r14*2]	# tmp477,
	mov	r14, QWORD PTR 80[rsp]	# niters.134, %sfp
	lea	esi, [r8+rsi*4]	# tmp480,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU311
	shr	esi, 4	# tmp481,
	mov	DWORD PTR 8[rcx+r10], esi	# *_481, tmp481
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU312
.LVL59:
	.loc 1 53 35 discriminator 1 view .LVU313
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 is_stmt 0 view .LVU314
	lea	rsi, 4[rax]	# tmp482,
	cmp	rsi, r14	# tmp482, niters.134
	jb	.L102	#,
.LVL60:
.L74:
	.loc 1 54 13 is_stmt 1 view .LVU315
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 32 is_stmt 0 view .LVU316
	lea	rax, 0[0+rdx*4]	# _338,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 64 view .LVU317
	mov	esi, DWORD PTR [r9+rdx*4]	# _343, *_342
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU318
	lea	r14, 2[rdx]	# _356,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU319
	mov	r8d, DWORD PTR -8[r9+rax]	# *_340, *_340
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 50 view .LVU320
	mov	r12d, DWORD PTR -4[r9+rax]	# _347, *_346
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU321
	lea	r13d, [rsi+rsi*2]	# tmp544,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU322
	mov	ecx, DWORD PTR 4[r9+rax]	# _352, *_351
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU323
	mov	edi, DWORD PTR 8[r9+rax]	# _359, *_358
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU324
	lea	r8d, 8[r8+r13*2]	# tmp548,
	add	r8d, edi	# tmp549, _359
	lea	r13d, [r12+rcx]	# tmp550,
	lea	r8d, [r8+r13*4]	# tmp552,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 35 discriminator 1 view .LVU325
	mov	r13, QWORD PTR 112[rsp]	# _143, %sfp
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU326
	shr	r8d, 4	# tmp553,
	mov	DWORD PTR [r10+rdx*4], r8d	# *_362, tmp553
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU327
	.loc 1 53 35 discriminator 1 view .LVU328
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 is_stmt 0 view .LVU329
	add	rdx, 1	# tmp554,
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 35 discriminator 1 view .LVU330
	cmp	rdx, r13	# tmp554, _143
	jnb	.L71	#,
	.loc 1 54 13 is_stmt 1 view .LVU331
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 is_stmt 0 view .LVU332
	mov	edx, DWORD PTR 12[r9+rax]	# *_387, *_387
	lea	r8d, 8[r12+rdx]	# tmp557,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU333
	lea	r12d, [rcx+rcx*2]	# tmp560,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU334
	lea	r8d, [r8+r12*2]	# tmp562,
	lea	r12d, [rsi+rdi]	# tmp563,
	lea	r8d, [r8+r12*4]	# tmp565,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU335
	shr	r8d, 4	# tmp566,
	mov	DWORD PTR 4[rax+r10], r8d	# *_391, tmp566
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU336
	.loc 1 53 35 discriminator 1 view .LVU337
	cmp	r14, r13	# _356, _143
	jnb	.L71	#,
	.loc 1 54 13 view .LVU338
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 is_stmt 0 view .LVU339
	mov	r8d, DWORD PTR 16[r9+rax]	# *_171, *_171
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU340
	lea	edi, [rdi+rdi*2]	# tmp572,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU341
	add	ecx, edx	# tmp575, *_387
	lea	esi, 8[rsi+r8]	# tmp568,
	lea	esi, [rsi+rdi*2]	# tmp574,
	lea	edx, [rsi+rcx*4]	# tmp578,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU342
	shr	edx, 4	# tmp579,
	mov	DWORD PTR 8[rax+r10], edx	# *_160, tmp579
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU343
	.loc 1 53 35 discriminator 1 view .LVU344
.LVL61:
.L71:
	.loc 1 53 35 is_stmt 0 discriminator 1 view .LVU345
.LBE91:
	.loc 1 57 9 is_stmt 1 view .LVU346
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 38 is_stmt 0 view .LVU347
	mov	rsi, QWORD PTR 112[rsp]	#, %sfp
	mov	rdx, r11	#, width
	mov	rdi, r9	#, ivtmp.243
	call	blurred_edge	#
.LVL62:
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38 view .LVU348
	mov	rsi, QWORD PTR 64[rsp]	#, %sfp
	mov	rdx, r11	#, width
	mov	rdi, r9	#, ivtmp.243
# src/kernels.cpp:57:         out[width - 2] = blurred_edge(row, width - 2, width);
	.loc 1 57 24 discriminator 1 view .LVU349
	mov	DWORD PTR -8[r10+r11*4], eax	# MEM[(uint32_t *)out_58 + -8B + width_54(D) * 4], tmp595
	.loc 1 58 9 is_stmt 1 view .LVU350
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 38 is_stmt 0 view .LVU351
	call	blurred_edge	#
.LVL63:
# src/kernels.cpp:58:         out[width - 1] = blurred_edge(row, width - 1, width);
	.loc 1 58 24 discriminator 1 view .LVU352
	mov	DWORD PTR -4[r10+r11*4], eax	# MEM[(uint32_t *)out_58 + -4B + width_54(D) * 4], tmp596
.LVL64:
.L66:
	.loc 1 58 24 discriminator 1 view .LVU353
.LBE94:
	.loc 1 41 5 is_stmt 1 discriminator 2 view .LVU354
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 31 is_stmt 0 discriminator 1 view .LVU355
	mov	rdi, QWORD PTR 88[rsp]	# _37, %sfp
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 5 discriminator 2 view .LVU356
	add	QWORD PTR 120[rsp], 1	# %sfp,
.LVL65:
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 31 discriminator 1 view .LVU357
	add	r15, r11	# ivtmp.252, width
# src/kernels.cpp:41:     for (std::size_t y = 0; y < height; ++y) {
	.loc 1 41 5 discriminator 2 view .LVU358
	mov	rax, QWORD PTR 120[rsp]	# y, %sfp
.LVL66:
	.loc 1 41 31 is_stmt 1 discriminator 1 view .LVU359
	add	r9, rdi	# ivtmp.243, _37
.LVL67:
	.loc 1 41 31 is_stmt 0 discriminator 1 view .LVU360
	add	r10, rdi	# ivtmp.251, _37
.LVL68:
	.loc 1 41 31 discriminator 1 view .LVU361
	cmp	QWORD PTR 96[rsp], rax	# %sfp, y
	jne	.L75	#,
	vzeroupper
.LVL69:
.L99:
	.loc 1 41 31 discriminator 1 view .LVU362
.LBE96:
# src/kernels.cpp:60: }
	.loc 1 60 1 view .LVU363
	lea	rsp, -40[rbp]	#,
.LVL70:
	.loc 1 60 1 view .LVU364
	pop	rbx	#
	pop	r12	#
	pop	r13	#
	pop	r14	#
	pop	r15	#
	pop	rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
.LVL71:
	.loc 1 60 1 view .LVU365
	ret	
.LVL72:
	.p2align 4,,10
	.p2align 3
.L101:
	.cfi_restore_state
.LBB97:
.LBB95:
.LBB92:
.LBB84:
	.loc 1 45 39 is_stmt 1 discriminator 1 view .LVU366
	test	r11, r11	# width
	je	.L66	#,
	.loc 1 46 17 view .LVU367
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU368
	mov	rdx, r11	#, width
	xor	esi, esi	#
	mov	rdi, r9	#, ivtmp.243
	call	blurred_edge	#
.LVL73:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU369
	mov	DWORD PTR [r10], eax	# MEM[(uint32_t *)out_58], tmp591
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU370
.LVL74:
	.loc 1 45 39 discriminator 1 view .LVU371
	cmp	r11, 1	# width,
	je	.L66	#,
	.loc 1 46 17 view .LVU372
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU373
	mov	rdx, r11	#, width
	mov	esi, 1	#,
	mov	rdi, r9	#, ivtmp.243
	call	blurred_edge	#
.LVL75:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU374
	mov	DWORD PTR 4[r10], eax	# MEM[(uint32_t *)out_58 + 4B], tmp592
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU375
.LVL76:
	.loc 1 45 39 discriminator 1 view .LVU376
	cmp	r11, 2	# width,
	je	.L66	#,
	.loc 1 46 17 view .LVU377
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU378
	mov	rdx, r11	#, width
	mov	esi, 2	#,
	mov	rdi, r9	#, ivtmp.243
	call	blurred_edge	#
.LVL77:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU379
	mov	DWORD PTR 8[r10], eax	# MEM[(uint32_t *)out_58 + 8B], tmp593
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU380
.LVL78:
	.loc 1 45 39 discriminator 1 view .LVU381
	cmp	r11, 4	# width,
	jne	.L66	#,
	.loc 1 46 17 view .LVU382
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 38 is_stmt 0 view .LVU383
	mov	edx, 4	#,
	mov	esi, 3	#,
	mov	rdi, r9	#, ivtmp.243
	call	blurred_edge	#
.LVL79:
# src/kernels.cpp:46:                 out[x] = blurred_edge(row, x, width);
	.loc 1 46 24 discriminator 1 view .LVU384
	mov	DWORD PTR 12[r10], eax	# MEM[(uint32_t *)out_58 + 12B], tmp594
	.loc 1 45 13 is_stmt 1 discriminator 3 view .LVU385
.LVL80:
	.loc 1 45 39 discriminator 1 view .LVU386
	jmp	.L66	#
.LVL81:
	.p2align 4,,10
	.p2align 3
.L77:
	.loc 1 45 39 is_stmt 0 discriminator 1 view .LVU387
.LBE84:
.LBE92:
.LBB93:
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 43 discriminator 1 view .LVU388
	xor	ecx, ecx	# _139
# src/kernels.cpp:53:         for (std::size_t x = 2; x < width - 2; ++x) {
	.loc 1 53 26 view .LVU389
	mov	eax, 2	# tmp.166,
	jmp	.L69	#
.LVL82:
.L78:
	.loc 1 53 26 view .LVU390
	mov	rdx, rax	# _157, tmp.166
	jmp	.L74	#
.LVL83:
.L102:
	.loc 1 54 13 is_stmt 1 view .LVU391
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 is_stmt 0 view .LVU392
	lea	rdx, 20[r9+rcx]	# _511,
.LVL84:
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU393
	lea	rsi, 16[r9+rcx]	# _504,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU394
	add	edi, r13d	# tmp495, _477
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 52 view .LVU395
	vmovq	xmm0, QWORD PTR 4[r9+rcx]	# vect__494.203, MEM <const vector(2) unsigned int> [(const uint32_t *)_493]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU396
	vmovq	xmm4, QWORD PTR [rdx]	# MEM <const vector(2) unsigned int> [(const uint32_t *)_511], MEM <const vector(2) unsigned int> [(const uint32_t *)_511]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU397
	sal	edi, 2	# tmp496,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU398
	mov	r14d, DWORD PTR 28[r9+rcx]	# _568, *_567
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU399
	mov	QWORD PTR 24[rsp], rsi	# %sfp, _504
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU400
	mov	esi, DWORD PTR [rdx]	# _512, *_511
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU401
	imul	edx, r12d, 6	# tmp488, _449,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU402
	vmovd	xmm6, edi	# tmp496, tmp496
	vmovq	xmm5, QWORD PTR .LC14[rip]	# tmp492,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU403
	vmovd	edi, xmm4	# tmp504, MEM <const vector(2) unsigned int> [(const uint32_t *)_511]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU404
	mov	r8d, DWORD PTR 24[r9+rcx]	# _540, *_539
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU405
	imul	edi, edi, 6	# tmp505, tmp504,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU406
	mov	DWORD PTR 24[rsp], esi	# %sfp, _512
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU407
.LVL85:
	.loc 1 53 35 discriminator 1 view .LVU408
	.loc 1 54 13 view .LVU409
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 is_stmt 0 view .LVU410
	vmovd	xmm1, edx	# tmp488, tmp488
	imul	edx, r13d, 6	# tmp489, _477,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU411
	vpinsrd	xmm1, xmm1, edx, 1	# tmp487, tmp488, tmp489
	lea	edx, [r12+rsi]	# tmp497,
	lea	esi, 8[r12+r14]	# tmp503,
	vpaddd	xmm0, xmm0, xmm1	# tmp490, vect__494.203, tmp487
	vpaddd	xmm1, xmm4, xmm5	# tmp491, MEM <const vector(2) unsigned int> [(const uint32_t *)_511], tmp492
	sal	edx, 2	# tmp498,
	add	edi, esi	# tmp506, tmp503
	vpextrd	esi, xmm4, 1	# tmp507, MEM <const vector(2) unsigned int> [(const uint32_t *)_511]
	add	esi, r13d	# tmp508, _477
	vpaddd	xmm0, xmm0, xmm1	# tmp493, tmp490, tmp491
	vpinsrd	xmm1, xmm6, edx, 1	# tmp494, tmp496, tmp498
	lea	esi, [rdi+rsi*4]	# tmp510,
	mov	rdi, QWORD PTR 80[rsp]	# niters.134, %sfp
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU412
	shr	esi, 4	# tmp511,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU413
	lea	rdx, 6[rax]	# _157,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU414
	mov	DWORD PTR 20[r10+rcx], esi	# *_572, tmp511
	lea	rsi, 7[rax]	# tmp512,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU415
	vpaddd	xmm0, xmm0, xmm1	# vect__515.207, tmp493, tmp494
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU416
	vpsrld	xmm0, xmm0, 4	# vect__517.208, vect__515.207,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 view .LVU417
	vmovq	QWORD PTR 12[r10+rcx], xmm0	# MEM <vector(2) unsigned int> [(uint32_t *)_516], vect__517.208
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU418
.LVL86:
	.loc 1 53 35 discriminator 1 view .LVU419
	.loc 1 54 13 view .LVU420
	.loc 1 53 9 discriminator 3 view .LVU421
	.loc 1 53 35 discriminator 1 view .LVU422
	cmp	rsi, rdi	# tmp512, niters.134
	jnb	.L74	#,
	.loc 1 54 13 view .LVU423
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 is_stmt 0 view .LVU424
	imul	edi, r8d, 6	# tmp515, _540,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU425
	lea	rsi, 32[r9+rcx]	# _201,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU426
	imul	edx, r14d, 6	# tmp516, _568,
.LVL87:
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 52 view .LVU427
	vmovq	xmm4, QWORD PTR [rsi]	# MEM <const vector(2) unsigned int> [(const uint32_t *)_201], MEM <const vector(2) unsigned int> [(const uint32_t *)_201]
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU428
.LVL88:
	.loc 1 53 35 discriminator 1 view .LVU429
	.loc 1 54 13 view .LVU430
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 is_stmt 0 view .LVU431
	vmovd	xmm0, edi	# tmp515, tmp515
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 52 view .LVU432
	lea	rdi, 16[r9+rcx]	# _504,
	vmovq	xmm1, QWORD PTR [rdi]	# vect__165.216, MEM <const vector(2) unsigned int> [(const uint32_t *)_504]
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU433
	vpinsrd	xmm0, xmm0, edx, 1	# tmp514, tmp515, tmp516
	mov	edi, DWORD PTR [rsi]	# tmp525, *_201
	mov	edx, DWORD PTR 24[rsp]	# _512, %sfp
	vpaddd	xmm0, xmm0, xmm5	# tmp517, tmp514, tmp492
	vpaddd	xmm1, xmm1, xmm4	# tmp520, vect__165.216, MEM <const vector(2) unsigned int> [(const uint32_t *)_201]
	add	edi, r8d	# tmp525, _540
	add	edx, r14d	# _512, _568
	mov	esi, edi	# tmp525, tmp525
	sal	edx, 2	# tmp524,
	sal	esi, 2	# tmp527,
	vmovd	xmm7, edx	# tmp524, tmp524
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 39 view .LVU434
	lea	rdx, 9[rax]	# _157,
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 57 view .LVU435
	vmovd	eax, xmm4	# tmp534, MEM <const vector(2) unsigned int> [(const uint32_t *)_201]
.LVL89:
	.loc 1 54 57 view .LVU436
	imul	eax, eax, 6	# tmp535, tmp534,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 54 view .LVU437
	vpaddd	xmm0, xmm0, xmm1	# tmp521, tmp517, tmp520
	vpinsrd	xmm1, xmm7, esi, 1	# tmp522, tmp524, tmp527
	mov	esi, DWORD PTR 40[r9+rcx]	# _540, *_315
	add	esi, r8d	# _540, _540
	lea	esi, 8[rsi+rax]	# tmp536,
	vpaddd	xmm0, xmm0, xmm1	# vect__204.220, tmp521, tmp522
	vpextrd	eax, xmm4, 1	# tmp537, MEM <const vector(2) unsigned int> [(const uint32_t *)_201]
	add	eax, r14d	# tmp538, _568
	lea	eax, [rsi+rax*4]	# tmp540,
# src/kernels.cpp:55:                       + 4u * row[x + 1] + row[x + 2] + 8u) >> 4;
	.loc 1 55 60 view .LVU438
	vpsrld	xmm0, xmm0, 4	# vect__206.221, vect__204.220,
	shr	eax, 4	# tmp541,
	mov	DWORD PTR 32[rcx+r10], eax	# *_320, tmp541
# src/kernels.cpp:54:             out[x] = (row[x - 2] + 4u * row[x - 1] + 6u * row[x]
	.loc 1 54 20 view .LVU439
	vmovq	QWORD PTR 24[rcx+r10], xmm0	# MEM <vector(2) unsigned int> [(uint32_t *)_205], vect__206.221
	.loc 1 53 9 is_stmt 1 discriminator 3 view .LVU440
.LVL90:
	.loc 1 53 35 discriminator 1 view .LVU441
	.loc 1 54 13 view .LVU442
	.loc 1 53 9 discriminator 3 view .LVU443
	.loc 1 53 35 discriminator 1 view .LVU444
	jmp	.L74	#
.LBE93:
.LBE95:
.LBE97:
	.cfi_endproc
.LFE705:
	.size	horizontal_blur_5tap, .-horizontal_blur_5tap
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC14:
	.long	8
	.long	8
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
	.file 17 "/usr/include/x86_64-linux-gnu/bits/stdlib-float.h"
	.file 18 "/usr/include/x86_64-linux-gnu/bits/stdlib-bsearch.h"
	.file 19 "/usr/include/x86_64-linux-gnu/bits/stdlib.h"
	.file 20 "/usr/include/c++/13/pstl/execution_defs.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xff6
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x29
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
	.uleb128 0xc
	.long	0x41
	.uleb128 0x2a
	.byte	0x20
	.byte	0x10
	.byte	0x3
	.value	0x1a9
	.byte	0x10
	.long	.LASF138
	.long	0x79
	.uleb128 0x1e
	.long	.LASF4
	.value	0x1aa
	.byte	0xd
	.long	0x79
	.byte	0x8
	.byte	0
	.uleb128 0x1e
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
	.uleb128 0x2b
	.long	.LASF139
	.byte	0x3
	.value	0x1b4
	.byte	0x3
	.long	0x4d
	.byte	0x10
	.uleb128 0x2c
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
	.uleb128 0x1f
	.long	.LASF8
	.byte	0x6
	.value	0x134
	.byte	0x1a
	.long	0x41
	.uleb128 0xc
	.long	0x18a
	.uleb128 0x20
	.long	.LASF9
	.value	0xab0
	.uleb128 0x20
	.long	.LASF10
	.value	0xb06
	.uleb128 0x21
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
	.uleb128 0x2d
	.byte	0x9
	.value	0x100
	.byte	0x16
	.long	0xa01
	.uleb128 0xf
	.long	.LASF12
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF14
	.long	0xa38
	.long	0x2db
	.uleb128 0x10
	.string	"_Tp"
	.long	0x388
	.uleb128 0x2
	.long	0xa38
	.uleb128 0x2
	.long	0xa38
	.byte	0
	.uleb128 0xf
	.long	.LASF13
	.byte	0x2
	.byte	0xe9
	.byte	0x5
	.long	.LASF15
	.long	0xd6c
	.long	0x303
	.uleb128 0x10
	.string	"_Tp"
	.long	0x41
	.uleb128 0x2
	.long	0xd6c
	.uleb128 0x2
	.long	0xd6c
	.byte	0
	.uleb128 0x2e
	.long	.LASF71
	.byte	0x2
	.value	0x101
	.byte	0x5
	.long	.LASF140
	.long	0xa38
	.uleb128 0x10
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
	.uleb128 0x2f
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xc
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
	.uleb128 0x30
	.byte	0x8
	.uleb128 0x6
	.long	0x437
	.uleb128 0x4
	.byte	0x1
	.byte	0x6
	.long	.LASF39
	.uleb128 0xc
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
	.uleb128 0xc
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
	.uleb128 0xc
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
	.uleb128 0x31
	.long	.LASF69
	.byte	0x6
	.value	0x157
	.byte	0xb
	.long	0x60d
	.uleb128 0x21
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
	.uleb128 0x32
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
	.uleb128 0xc
	.long	0x622
	.uleb128 0x4
	.byte	0x2
	.byte	0x10
	.long	.LASF76
	.uleb128 0x4
	.byte	0x4
	.byte	0x10
	.long	.LASF77
	.uleb128 0x22
	.long	.LASF78
	.byte	0x8
	.byte	0x38
	.long	0x650
	.uleb128 0x33
	.byte	0x8
	.byte	0x3a
	.byte	0x18
	.long	0x1aa
	.byte	0
	.uleb128 0x19
	.byte	0x8
	.byte	0x3c
	.long	.LASF81
	.long	0x673
	.uleb128 0x1a
	.long	.LASF79
	.byte	0x3d
	.byte	0x9
	.long	0x388
	.uleb128 0x1b
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
	.uleb128 0x19
	.byte	0x10
	.byte	0x44
	.long	.LASF82
	.long	0x6a2
	.uleb128 0x1a
	.long	.LASF79
	.byte	0x45
	.byte	0xe
	.long	0x2e
	.uleb128 0x1b
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
	.uleb128 0x19
	.byte	0x10
	.byte	0x4e
	.long	.LASF84
	.long	0x6d1
	.uleb128 0x1a
	.long	.LASF79
	.byte	0x4f
	.byte	0x13
	.long	0x79
	.uleb128 0x1b
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
	.uleb128 0x1f
	.long	.LASF86
	.byte	0x10
	.value	0x3b4
	.byte	0xf
	.long	0x6ef
	.uleb128 0x6
	.long	0x6f4
	.uleb128 0x34
	.long	0x388
	.long	0x708
	.uleb128 0x2
	.long	0x708
	.uleb128 0x2
	.long	0x708
	.byte	0
	.uleb128 0x6
	.long	0x70d
	.uleb128 0x35
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
	.uleb128 0x36
	.uleb128 0x37
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
	.uleb128 0xa
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
	.uleb128 0xa
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
	.uleb128 0x38
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
	.uleb128 0xa
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
	.uleb128 0x23
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
	.uleb128 0x39
	.long	.LASF98
	.byte	0x10
	.value	0x2fa
	.byte	0xd
	.long	0x891
	.uleb128 0x2
	.long	0x388
	.byte	0
	.uleb128 0x3a
	.long	.LASF142
	.byte	0x10
	.value	0x23d
	.byte	0xc
	.long	0x388
	.uleb128 0x23
	.long	.LASF100
	.value	0x23f
	.long	0x8af
	.uleb128 0x2
	.long	0x337
	.byte	0
	.uleb128 0xa
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
	.uleb128 0xf
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
	.uleb128 0xf
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
	.uleb128 0xa
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
	.uleb128 0xa
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
	.uleb128 0xf
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
	.uleb128 0xf
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
	.uleb128 0xa
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
	.uleb128 0xa
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
	.uleb128 0x22
	.long	.LASF117
	.byte	0x14
	.byte	0xf
	.long	0xa38
	.uleb128 0x3b
	.long	.LASF143
	.byte	0x14
	.byte	0x11
	.byte	0xb
	.uleb128 0x3c
	.string	"v1"
	.byte	0x14
	.byte	0x13
	.byte	0x12
	.byte	0
	.byte	0
	.uleb128 0x24
	.long	0x38f
	.uleb128 0x1c
	.long	0x2b3
	.long	0xa68
	.uleb128 0x10
	.string	"_Tp"
	.long	0x388
	.uleb128 0x11
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xa38
	.uleb128 0x11
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xa38
	.byte	0
	.uleb128 0x1d
	.long	.LASF126
	.byte	0x26
	.quad	.LFB705
	.quad	.LFE705-.LFB705
	.uleb128 0x1
	.byte	0x9c
	.long	0xcf8
	.uleb128 0x8
	.long	.LASF118
	.byte	0x26
	.byte	0x41
	.long	0xcfd
	.long	.LLST23
	.long	.LVUS23
	.uleb128 0x8
	.long	.LASF119
	.byte	0x27
	.byte	0x3b
	.long	0xd07
	.long	.LLST24
	.long	.LVUS24
	.uleb128 0x8
	.long	.LASF120
	.byte	0x28
	.byte	0x27
	.long	0x18a
	.long	.LLST25
	.long	.LVUS25
	.uleb128 0x8
	.long	.LASF121
	.byte	0x28
	.byte	0x3a
	.long	0x18a
	.long	.LLST26
	.long	.LVUS26
	.uleb128 0x15
	.long	.LLRL27
	.long	0xcec
	.uleb128 0xd
	.string	"y"
	.byte	0x29
	.byte	0x16
	.long	0x18a
	.long	.LLST28
	.long	.LVUS28
	.uleb128 0x16
	.long	.LLRL29
	.uleb128 0xd
	.string	"row"
	.byte	0x2a
	.byte	0x1e
	.long	0xcf8
	.long	.LLST30
	.long	.LVUS30
	.uleb128 0xd
	.string	"out"
	.byte	0x2b
	.byte	0x18
	.long	0xd02
	.long	.LLST31
	.long	.LVUS31
	.uleb128 0x3d
	.quad	.LBB84
	.quad	.LBE84-.LBB84
	.long	0xbc3
	.uleb128 0xd
	.string	"x"
	.byte	0x2d
	.byte	0x1e
	.long	0x18a
	.long	.LLST39
	.long	.LVUS39
	.uleb128 0x17
	.quad	.LVL73
	.long	0xd0c
	.long	0xb5e
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
	.byte	0x7b
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.quad	.LVL75
	.long	0xd0c
	.long	0xb81
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
	.byte	0x7b
	.sleb128 0
	.byte	0
	.uleb128 0x17
	.quad	.LVL77
	.long	0xd0c
	.long	0xba4
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
	.byte	0x7b
	.sleb128 0
	.byte	0
	.uleb128 0x25
	.quad	.LVL79
	.long	0xd0c
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
	.uleb128 0x15
	.long	.LLRL37
	.long	0xbde
	.uleb128 0xd
	.string	"x"
	.byte	0x35
	.byte	0x1a
	.long	0x18a
	.long	.LLST38
	.long	.LVUS38
	.byte	0
	.uleb128 0x18
	.long	0xd0c
	.quad	.LBI75
	.byte	.LVU239
	.long	.LLRL32
	.byte	0x32
	.byte	0x1e
	.long	0xc40
	.uleb128 0xb
	.long	0xd29
	.long	.LLST33
	.long	.LVUS33
	.uleb128 0x9
	.long	0xd33
	.uleb128 0xb
	.long	0xd1d
	.long	.LLST34
	.long	.LVUS34
	.uleb128 0x16
	.long	.LLRL32
	.uleb128 0x12
	.long	0xd3f
	.long	.LLST35
	.long	.LVUS35
	.uleb128 0x12
	.long	0xd4a
	.long	.LLST36
	.long	.LVUS36
	.uleb128 0xe
	.long	0xd55
	.uleb128 0xe
	.long	0xd60
	.byte	0
	.byte	0
	.uleb128 0x18
	.long	0xd0c
	.quad	.LBI86
	.byte	.LVU251
	.long	.LLRL40
	.byte	0x33
	.byte	0x1e
	.long	0xca2
	.uleb128 0xb
	.long	0xd29
	.long	.LLST41
	.long	.LVUS41
	.uleb128 0x9
	.long	0xd33
	.uleb128 0xb
	.long	0xd1d
	.long	.LLST42
	.long	.LVUS42
	.uleb128 0x16
	.long	.LLRL40
	.uleb128 0x12
	.long	0xd3f
	.long	.LLST43
	.long	.LVUS43
	.uleb128 0x12
	.long	0xd4a
	.long	.LLST44
	.long	.LVUS44
	.uleb128 0xe
	.long	0xd55
	.uleb128 0xe
	.long	0xd60
	.byte	0
	.byte	0
	.uleb128 0x17
	.quad	.LVL62
	.long	0xd0c
	.long	0xcc8
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x77
	.sleb128 112
	.byte	0x6
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7b
	.sleb128 0
	.byte	0
	.uleb128 0x25
	.quad	.LVL63
	.long	0xd0c
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x79
	.sleb128 0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x4
	.byte	0x77
	.sleb128 64
	.byte	0x6
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x7b
	.sleb128 0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x13
	.quad	.LVL69
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x6
	.long	0x49c
	.uleb128 0x26
	.long	0xcf8
	.uleb128 0x6
	.long	0x490
	.uleb128 0x26
	.long	0xd02
	.uleb128 0x3e
	.long	.LASF144
	.byte	0x1
	.byte	0x1c
	.byte	0x16
	.long	0x490
	.byte	0x1
	.long	0xd6c
	.uleb128 0x11
	.string	"row"
	.byte	0x1
	.byte	0x1c
	.byte	0x38
	.long	0xcf8
	.uleb128 0x11
	.string	"x"
	.byte	0x1
	.byte	0x1d
	.byte	0x2f
	.long	0x18a
	.uleb128 0x3f
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
	.uleb128 0x24
	.long	0x48
	.uleb128 0x1c
	.long	0x2db
	.long	0xd9c
	.uleb128 0x10
	.string	"_Tp"
	.long	0x41
	.uleb128 0x11
	.string	"__a"
	.byte	0x2
	.byte	0xe9
	.byte	0x14
	.long	0xd6c
	.uleb128 0x11
	.string	"__b"
	.byte	0x2
	.byte	0xe9
	.byte	0x24
	.long	0xd6c
	.byte	0
	.uleb128 0x1d
	.long	.LASF127
	.byte	0x12
	.quad	.LFB701
	.quad	.LFE701-.LFB701
	.uleb128 0x1
	.byte	0x9c
	.long	0xe79
	.uleb128 0x40
	.long	.LASF134
	.byte	0x1
	.byte	0x12
	.byte	0x3c
	.long	0xcfd
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x8
	.long	.LASF128
	.byte	0x13
	.byte	0x36
	.long	0xd07
	.long	.LLST13
	.long	.LVUS13
	.uleb128 0x8
	.long	.LASF129
	.byte	0x14
	.byte	0x22
	.long	0x18a
	.long	.LLST14
	.long	.LVUS14
	.uleb128 0x15
	.long	.LLRL15
	.long	0xe62
	.uleb128 0xd
	.string	"i"
	.byte	0x15
	.byte	0x16
	.long	0x18a
	.long	.LLST16
	.long	.LVUS16
	.uleb128 0x16
	.long	.LLRL17
	.uleb128 0x14
	.long	.LASF130
	.byte	0x17
	.byte	0x1c
	.long	0x467
	.uleb128 0x18
	.long	0xe79
	.quad	.LBI31
	.byte	.LVU130
	.long	.LLRL18
	.byte	0x18
	.byte	0x3a
	.long	0xe41
	.uleb128 0xb
	.long	0xe95
	.long	.LLST19
	.long	.LVUS19
	.uleb128 0x9
	.long	0xe8b
	.byte	0
	.uleb128 0x27
	.long	0xa3d
	.quad	.LBI35
	.byte	.LVU131
	.long	.LLRL21
	.byte	0x18
	.byte	0x3a
	.uleb128 0x9
	.long	0xa5b
	.uleb128 0x9
	.long	0xa4f
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x13
	.quad	.LVL28
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x13
	.quad	.LVL43
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x1c
	.long	0x303
	.long	0xea0
	.uleb128 0x10
	.string	"_Tp"
	.long	0x388
	.uleb128 0x28
	.string	"__a"
	.byte	0x14
	.long	0xa38
	.uleb128 0x28
	.string	"__b"
	.byte	0x24
	.long	0xa38
	.byte	0
	.uleb128 0x1d
	.long	.LASF131
	.byte	0x7
	.quad	.LFB700
	.quad	.LFE700-.LFB700
	.uleb128 0x1
	.byte	0x9c
	.long	0xf4e
	.uleb128 0x41
	.string	"red"
	.byte	0x1
	.byte	0x7
	.byte	0x3d
	.long	0xcfd
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x8
	.long	.LASF132
	.byte	0x8
	.byte	0x3d
	.long	0xcfd
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x8
	.long	.LASF133
	.byte	0x9
	.byte	0x3d
	.long	0xcfd
	.long	.LLST8
	.long	.LVUS8
	.uleb128 0x8
	.long	.LASF134
	.byte	0xa
	.byte	0x37
	.long	0xd07
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x8
	.long	.LASF129
	.byte	0xb
	.byte	0x23
	.long	0x18a
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x15
	.long	.LLRL11
	.long	0xf37
	.uleb128 0xd
	.string	"i"
	.byte	0xc
	.byte	0x16
	.long	0x18a
	.long	.LLST12
	.long	.LVUS12
	.byte	0
	.uleb128 0x13
	.quad	.LVL16
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x13
	.quad	.LVL22
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x4
	.byte	0x10
	.byte	0x5
	.long	.LASF135
	.uleb128 0x4
	.byte	0x10
	.byte	0x7
	.long	.LASF136
	.uleb128 0x42
	.long	0xd0c
	.quad	.LFB703
	.quad	.LFE703-.LFB703
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xb
	.long	0xd1d
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0xb
	.long	0xd29
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0xb
	.long	0xd33
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x12
	.long	0xd3f
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0xe
	.long	0xd4a
	.uleb128 0xe
	.long	0xd55
	.uleb128 0xe
	.long	0xd60
	.uleb128 0x18
	.long	0xd71
	.quad	.LBI20
	.byte	.LVU14
	.long	.LLRL4
	.byte	0x20
	.byte	0x28
	.long	0xfd9
	.uleb128 0x9
	.long	0xd8f
	.uleb128 0x9
	.long	0xd83
	.byte	0
	.uleb128 0x27
	.long	0xd71
	.quad	.LBI22
	.byte	.LVU17
	.long	.LLRL5
	.byte	0x21
	.byte	0x28
	.uleb128 0x9
	.long	0xd8f
	.uleb128 0x9
	.long	0xd83
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
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
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
	.uleb128 0xb
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
	.uleb128 0xc
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
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
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x2f
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x83
	.uleb128 0x18
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
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x17
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
	.uleb128 0x18
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
	.uleb128 0x19
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
	.uleb128 0x1a
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
	.uleb128 0x1b
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
	.uleb128 0x1c
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
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1e
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
	.uleb128 0x1f
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
	.uleb128 0x20
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
	.uleb128 0x21
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
	.uleb128 0x22
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
	.uleb128 0x23
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
	.uleb128 0x24
	.uleb128 0x10
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
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
	.byte	0
	.byte	0
	.uleb128 0x28
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
	.uleb128 0x29
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
	.uleb128 0x2a
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
	.uleb128 0x2b
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
	.uleb128 0x2c
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
	.uleb128 0x2d
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
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2f
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
	.uleb128 0x30
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x31
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
	.uleb128 0x32
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
	.uleb128 0x33
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
	.uleb128 0x34
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x35
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x36
	.uleb128 0x15
	.byte	0
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
	.uleb128 0x38
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
	.uleb128 0x39
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
	.uleb128 0x3a
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
	.uleb128 0x3b
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
	.uleb128 0x3c
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
	.uleb128 0x3d
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
	.uleb128 0x3e
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
	.uleb128 0x3f
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
	.uleb128 0x40
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
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x41
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
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x42
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
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS23:
	.uleb128 0
	.uleb128 .LVU222
	.uleb128 .LVU222
	.uleb128 .LVU362
	.uleb128 .LVU362
	.uleb128 .LVU366
	.uleb128 .LVU366
	.uleb128 0
.LLST23:
	.byte	0x4
	.uleb128 .LVL45-.Ltext0
	.uleb128 .LVL47-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL47-.Ltext0
	.uleb128 .LVL69-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL69-.Ltext0
	.uleb128 .LVL72-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS24:
	.uleb128 0
	.uleb128 .LVU227
	.uleb128 .LVU227
	.uleb128 .LVU234
	.uleb128 .LVU234
	.uleb128 .LVU364
	.uleb128 .LVU364
	.uleb128 .LVU365
	.uleb128 .LVU365
	.uleb128 .LVU366
	.uleb128 .LVU366
	.uleb128 0
.LLST24:
	.byte	0x4
	.uleb128 .LVL45-.Ltext0
	.uleb128 .LVL49-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL49-.Ltext0
	.uleb128 .LVL50-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL70-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 104
	.byte	0x4
	.uleb128 .LVL70-.Ltext0
	.uleb128 .LVL71-.Ltext0
	.uleb128 0x7
	.byte	0x76
	.sleb128 -40
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x48
	.byte	0x1c
	.byte	0x4
	.uleb128 .LVL71-.Ltext0
	.uleb128 .LVL72-.Ltext0
	.uleb128 0x7
	.byte	0x77
	.sleb128 -48
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x48
	.byte	0x1c
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 104
	.byte	0
.LVUS25:
	.uleb128 0
	.uleb128 .LVU234
	.uleb128 .LVU234
	.uleb128 .LVU362
	.uleb128 .LVU362
	.uleb128 .LVU366
	.uleb128 .LVU366
	.uleb128 0
.LLST25:
	.byte	0x4
	.uleb128 .LVL45-.Ltext0
	.uleb128 .LVL50-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL69-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0x4
	.uleb128 .LVL69-.Ltext0
	.uleb128 .LVL72-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0
.LVUS26:
	.uleb128 0
	.uleb128 .LVU223
	.uleb128 .LVU223
	.uleb128 .LVU364
	.uleb128 .LVU364
	.uleb128 .LVU365
	.uleb128 .LVU365
	.uleb128 .LVU366
	.uleb128 .LVU366
	.uleb128 0
.LLST26:
	.byte	0x4
	.uleb128 .LVL45-.Ltext0
	.uleb128 .LVL48-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL48-.Ltext0
	.uleb128 .LVL70-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 96
	.byte	0x4
	.uleb128 .LVL70-.Ltext0
	.uleb128 .LVL71-.Ltext0
	.uleb128 0x8
	.byte	0x76
	.sleb128 -40
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x8
	.byte	0x20
	.byte	0x1c
	.byte	0x4
	.uleb128 .LVL71-.Ltext0
	.uleb128 .LVL72-.Ltext0
	.uleb128 0x8
	.byte	0x77
	.sleb128 -48
	.byte	0x9
	.byte	0xe0
	.byte	0x1a
	.byte	0x8
	.byte	0x20
	.byte	0x1c
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 96
	.byte	0
.LVUS28:
	.uleb128 .LVU218
	.uleb128 .LVU234
	.uleb128 .LVU234
	.uleb128 .LVU357
	.uleb128 .LVU359
	.uleb128 .LVU362
	.uleb128 .LVU366
	.uleb128 0
.LLST28:
	.byte	0x4
	.uleb128 .LVL46-.Ltext0
	.uleb128 .LVL50-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL65-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 120
	.byte	0x4
	.uleb128 .LVL66-.Ltext0
	.uleb128 .LVL69-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 120
	.byte	0
.LVUS30:
	.uleb128 .LVU236
	.uleb128 .LVU360
	.uleb128 .LVU366
	.uleb128 0
.LLST30:
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL67-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS31:
	.uleb128 .LVU237
	.uleb128 .LVU361
	.uleb128 .LVU366
	.uleb128 0
.LLST31:
	.byte	0x4
	.uleb128 .LVL50-.Ltext0
	.uleb128 .LVL68-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0
.LVUS39:
	.uleb128 .LVU366
	.uleb128 .LVU371
	.uleb128 .LVU371
	.uleb128 .LVU376
	.uleb128 .LVU376
	.uleb128 .LVU381
	.uleb128 .LVU381
	.uleb128 .LVU386
	.uleb128 .LVU386
	.uleb128 .LVU387
.LLST39:
	.byte	0x4
	.uleb128 .LVL72-.Ltext0
	.uleb128 .LVL74-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL74-.Ltext0
	.uleb128 .LVL76-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL76-.Ltext0
	.uleb128 .LVL78-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL78-.Ltext0
	.uleb128 .LVL80-.Ltext0
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL80-.Ltext0
	.uleb128 .LVL81-.Ltext0
	.uleb128 0x2
	.byte	0x34
	.byte	0x9f
	.byte	0
.LVUS38:
	.uleb128 .LVU261
	.uleb128 .LVU263
	.uleb128 .LVU288
	.uleb128 .LVU299
	.uleb128 .LVU299
	.uleb128 .LVU307
	.uleb128 .LVU307
	.uleb128 .LVU313
	.uleb128 .LVU313
	.uleb128 .LVU315
	.uleb128 .LVU387
	.uleb128 .LVU390
	.uleb128 .LVU391
	.uleb128 .LVU393
	.uleb128 .LVU393
	.uleb128 .LVU408
	.uleb128 .LVU408
	.uleb128 .LVU419
	.uleb128 .LVU419
	.uleb128 .LVU422
	.uleb128 .LVU422
	.uleb128 .LVU427
	.uleb128 .LVU427
	.uleb128 .LVU429
	.uleb128 .LVU429
	.uleb128 .LVU436
	.uleb128 .LVU436
	.uleb128 .LVU441
	.uleb128 .LVU441
	.uleb128 .LVU444
.LLST38:
	.byte	0x4
	.uleb128 .LVL54-.Ltext0
	.uleb128 .LVL55-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL56-.Ltext0
	.uleb128 .LVL57-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL57-.Ltext0
	.uleb128 .LVL58-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL58-.Ltext0
	.uleb128 .LVL59-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 2
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL59-.Ltext0
	.uleb128 .LVL60-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL81-.Ltext0
	.uleb128 .LVL82-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL83-.Ltext0
	.uleb128 .LVL84-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL84-.Ltext0
	.uleb128 .LVL85-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 3
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL85-.Ltext0
	.uleb128 .LVL86-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 4
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL86-.Ltext0
	.uleb128 .LVL86-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 5
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL86-.Ltext0
	.uleb128 .LVL87-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL87-.Ltext0
	.uleb128 .LVL88-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 6
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL88-.Ltext0
	.uleb128 .LVL89-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 7
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL89-.Ltext0
	.uleb128 .LVL90-.Ltext0
	.uleb128 0x3
	.byte	0x71
	.sleb128 -2
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL90-.Ltext0
	.uleb128 .LVL90-.Ltext0
	.uleb128 0x3
	.byte	0x71
	.sleb128 -1
	.byte	0x9f
	.byte	0
.LVUS33:
	.uleb128 .LVU240
	.uleb128 .LVU247
.LLST33:
	.byte	0x4
	.uleb128 .LVL51-.Ltext0
	.uleb128 .LVL52-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS34:
	.uleb128 .LVU239
	.uleb128 .LVU247
.LLST34:
	.byte	0x4
	.uleb128 .LVL51-.Ltext0
	.uleb128 .LVL52-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS35:
	.uleb128 .LVU241
	.uleb128 .LVU247
.LLST35:
	.byte	0x4
	.uleb128 .LVL51-.Ltext0
	.uleb128 .LVL52-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS36:
	.uleb128 .LVU242
	.uleb128 .LVU353
	.uleb128 .LVU387
	.uleb128 0
.LLST36:
	.byte	0x4
	.uleb128 .LVL51-.Ltext0
	.uleb128 .LVL64-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL81-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS41:
	.uleb128 .LVU252
	.uleb128 .LVU257
.LLST41:
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LVUS42:
	.uleb128 .LVU251
	.uleb128 .LVU257
.LLST42:
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS43:
	.uleb128 .LVU253
	.uleb128 .LVU257
.LLST43:
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LVL53-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS44:
	.uleb128 .LVU254
	.uleb128 .LVU353
	.uleb128 .LVU387
	.uleb128 0
.LLST44:
	.byte	0x4
	.uleb128 .LVL53-.Ltext0
	.uleb128 .LVL64-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL81-.Ltext0
	.uleb128 .LFE705-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS13:
	.uleb128 0
	.uleb128 .LVU117
	.uleb128 .LVU117
	.uleb128 0
.LLST13:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LFE701-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS14:
	.uleb128 0
	.uleb128 .LVU193
	.uleb128 .LVU193
	.uleb128 .LVU198
	.uleb128 .LVU198
	.uleb128 .LVU208
	.uleb128 .LVU208
	.uleb128 .LVU213
	.uleb128 .LVU213
	.uleb128 0
.LLST14:
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL35-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL35-.Ltext0
	.uleb128 .LVL36-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL36-.Ltext0
	.uleb128 .LVL40-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL40-.Ltext0
	.uleb128 .LVL42-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL42-.Ltext0
	.uleb128 .LFE701-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0
.LVUS16:
	.uleb128 .LVU113
	.uleb128 .LVU124
	.uleb128 .LVU214
	.uleb128 0
.LLST16:
	.byte	0x4
	.uleb128 .LVL25-.Ltext0
	.uleb128 .LVL27-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL44-.Ltext0
	.uleb128 .LFE701-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS19:
	.uleb128 .LVU163
	.uleb128 .LVU165
	.uleb128 .LVU177
	.uleb128 .LVU179
	.uleb128 .LVU191
	.uleb128 .LVU193
.LLST19:
	.byte	0x4
	.uleb128 .LVL30-.Ltext0
	.uleb128 .LVL31-.Ltext0
	.uleb128 0x6
	.byte	0xa0
	.long	.Ldebug_info0+3595
	.sleb128 0
	.byte	0x4
	.uleb128 .LVL32-.Ltext0
	.uleb128 .LVL33-.Ltext0
	.uleb128 0x6
	.byte	0xa0
	.long	.Ldebug_info0+3595
	.sleb128 0
	.byte	0x4
	.uleb128 .LVL34-.Ltext0
	.uleb128 .LVL35-.Ltext0
	.uleb128 0x6
	.byte	0xa0
	.long	.Ldebug_info0+3595
	.sleb128 0
	.byte	0
.LVUS6:
	.uleb128 0
	.uleb128 .LVU37
	.uleb128 .LVU37
	.uleb128 0
.LLST6:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x59
	.byte	0
.LVUS7:
	.uleb128 0
	.uleb128 .LVU38
	.uleb128 .LVU38
	.uleb128 0
.LLST7:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL12-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0
.LVUS8:
	.uleb128 0
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU102
	.uleb128 .LVU102
	.uleb128 .LVU108
	.uleb128 .LVU108
	.uleb128 0
.LLST8:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0
.LVUS9:
	.uleb128 0
	.uleb128 .LVU41
	.uleb128 .LVU41
	.uleb128 0
.LLST9:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0
.LVUS10:
	.uleb128 0
	.uleb128 .LVU100
	.uleb128 .LVU100
	.uleb128 .LVU108
	.uleb128 .LVU108
	.uleb128 0
.LLST10:
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x58
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0
.LVUS12:
	.uleb128 .LVU35
	.uleb128 .LVU46
	.uleb128 .LVU109
	.uleb128 0
.LLST12:
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.Ltext0
	.uleb128 .LFE700-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
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
.LLRL11:
	.byte	0x4
	.uleb128 .LBB26-.Ltext0
	.uleb128 .LBE26-.Ltext0
	.byte	0x4
	.uleb128 .LBB27-.Ltext0
	.uleb128 .LBE27-.Ltext0
	.byte	0x4
	.uleb128 .LBB28-.Ltext0
	.uleb128 .LBE28-.Ltext0
	.byte	0
.LLRL15:
	.byte	0x4
	.uleb128 .LBB29-.Ltext0
	.uleb128 .LBE29-.Ltext0
	.byte	0x4
	.uleb128 .LBB53-.Ltext0
	.uleb128 .LBE53-.Ltext0
	.byte	0x4
	.uleb128 .LBB54-.Ltext0
	.uleb128 .LBE54-.Ltext0
	.byte	0
.LLRL17:
	.byte	0x4
	.uleb128 .LBB30-.Ltext0
	.uleb128 .LBE30-.Ltext0
	.byte	0x4
	.uleb128 .LBB45-.Ltext0
	.uleb128 .LBE45-.Ltext0
	.byte	0x4
	.uleb128 .LBB46-.Ltext0
	.uleb128 .LBE46-.Ltext0
	.byte	0x4
	.uleb128 .LBB47-.Ltext0
	.uleb128 .LBE47-.Ltext0
	.byte	0x4
	.uleb128 .LBB48-.Ltext0
	.uleb128 .LBE48-.Ltext0
	.byte	0x4
	.uleb128 .LBB49-.Ltext0
	.uleb128 .LBE49-.Ltext0
	.byte	0x4
	.uleb128 .LBB50-.Ltext0
	.uleb128 .LBE50-.Ltext0
	.byte	0x4
	.uleb128 .LBB51-.Ltext0
	.uleb128 .LBE51-.Ltext0
	.byte	0x4
	.uleb128 .LBB52-.Ltext0
	.uleb128 .LBE52-.Ltext0
	.byte	0
.LLRL18:
	.byte	0x4
	.uleb128 .LBB31-.Ltext0
	.uleb128 .LBE31-.Ltext0
	.byte	0x4
	.uleb128 .LBB39-.Ltext0
	.uleb128 .LBE39-.Ltext0
	.byte	0x4
	.uleb128 .LBB41-.Ltext0
	.uleb128 .LBE41-.Ltext0
	.byte	0x4
	.uleb128 .LBB42-.Ltext0
	.uleb128 .LBE42-.Ltext0
	.byte	0x4
	.uleb128 .LBB43-.Ltext0
	.uleb128 .LBE43-.Ltext0
	.byte	0
.LLRL21:
	.byte	0x4
	.uleb128 .LBB35-.Ltext0
	.uleb128 .LBE35-.Ltext0
	.byte	0x4
	.uleb128 .LBB40-.Ltext0
	.uleb128 .LBE40-.Ltext0
	.byte	0x4
	.uleb128 .LBB44-.Ltext0
	.uleb128 .LBE44-.Ltext0
	.byte	0
.LLRL27:
	.byte	0x4
	.uleb128 .LBB73-.Ltext0
	.uleb128 .LBE73-.Ltext0
	.byte	0x4
	.uleb128 .LBB96-.Ltext0
	.uleb128 .LBE96-.Ltext0
	.byte	0x4
	.uleb128 .LBB97-.Ltext0
	.uleb128 .LBE97-.Ltext0
	.byte	0
.LLRL29:
	.byte	0x4
	.uleb128 .LBB74-.Ltext0
	.uleb128 .LBE74-.Ltext0
	.byte	0x4
	.uleb128 .LBB94-.Ltext0
	.uleb128 .LBE94-.Ltext0
	.byte	0x4
	.uleb128 .LBB95-.Ltext0
	.uleb128 .LBE95-.Ltext0
	.byte	0
.LLRL32:
	.byte	0x4
	.uleb128 .LBB75-.Ltext0
	.uleb128 .LBE75-.Ltext0
	.byte	0x4
	.uleb128 .LBB81-.Ltext0
	.uleb128 .LBE81-.Ltext0
	.byte	0x4
	.uleb128 .LBB85-.Ltext0
	.uleb128 .LBE85-.Ltext0
	.byte	0x4
	.uleb128 .LBB89-.Ltext0
	.uleb128 .LBE89-.Ltext0
	.byte	0
.LLRL37:
	.byte	0x4
	.uleb128 .LBB80-.Ltext0
	.uleb128 .LBE80-.Ltext0
	.byte	0x4
	.uleb128 .LBB82-.Ltext0
	.uleb128 .LBE82-.Ltext0
	.byte	0x4
	.uleb128 .LBB91-.Ltext0
	.uleb128 .LBE91-.Ltext0
	.byte	0x4
	.uleb128 .LBB93-.Ltext0
	.uleb128 .LBE93-.Ltext0
	.byte	0
.LLRL40:
	.byte	0x4
	.uleb128 .LBB86-.Ltext0
	.uleb128 .LBE86-.Ltext0
	.byte	0x4
	.uleb128 .LBB90-.Ltext0
	.uleb128 .LBE90-.Ltext0
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
.LASF133:
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
.LASF129:
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
.LASF130:
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
.LASF128:
	.string	"contrast"
.LASF34:
	.string	"__uint_least32_t"
.LASF92:
	.string	"bsearch"
.LASF28:
	.string	"__uint64_t"
.LASF103:
	.string	"__isoc23_strtol"
.LASF131:
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
.LASF27:
	.string	"__int64_t"
.LASF137:
	.string	"GNU C++17 13.3.0 -mavx2 -masm=intel -mtune=generic -march=x86-64 -g -O3 -std=c++17 -fno-omit-frame-pointer -fopt-info-vec-all=build/vectorization_o3.txt -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
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
.LASF134:
	.string	"gray"
.LASF123:
	.string	"left1"
.LASF122:
	.string	"left2"
.LASF87:
	.string	"atexit"
.LASF47:
	.string	"uint64_t"
.LASF132:
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
