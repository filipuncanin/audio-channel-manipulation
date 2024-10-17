	.public _limiterThreshold
	.public _outputMode
	.public _sampleBuffer
	.public _variablesGain
	.extern _cl_wavread_bits_per_sample
	.extern _cl_wavread_close
	.extern _cl_wavread_frame_rate
	.extern _cl_wavread_getnchannels
	.extern _cl_wavread_number_of_frames
	.extern _cl_wavread_open
	.extern _cl_wavread_recvsample
	.extern _cl_wavwrite_close
	.extern _cl_wavwrite_open
	.extern _cl_wavwrite_sendsample
	.public _main
	.extern _printf
	.public _saturation
	.extern _signalProcessing
	.extern _strcmp
	.extern _strcpy
	.extern __div
	.xdata_ovly
_enabled
	.dw  (0x1)
	.xdata_ovly
_limiterThreshold
	.dw  (0x7fdf3b64)
	.xdata_ovly
_outputMode
	.dw  (0x2)
	.ydata_ovly
_sampleBuffer
	.bss (0x80)
	.xdata_ovly
_string_const_0
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x0)
	.xdata_ovly
_string_const_1
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x30)
	.dw  (0x0)
	.xdata_ovly
_string_const_2
	.dw  (0x33)
	.dw  (0x5f)
	.dw  (0x32)
	.dw  (0x5f)
	.dw  (0x31)
	.dw  (0x0)
	.xdata_ovly
_string_const_3
	.dw  (0x57)
	.dw  (0x72)
	.dw  (0x6f)
	.dw  (0x6e)
	.dw  (0x67)
	.dw  (0x20)
	.dw  (0x6d)
	.dw  (0x6f)
	.dw  (0x64)
	.dw  (0x65)
	.dw  (0x21)
	.dw  (0xa)
	.dw  (0x0)
	.xdata_ovly
_string_const_4
	.dw  (0x30)
	.dw  (0x0)
	.xdata_ovly
_string_const_5
	.dw  (0x31)
	.dw  (0x0)
	.xdata_ovly
_string_const_6
	.dw  (0x57)
	.dw  (0x72)
	.dw  (0x6f)
	.dw  (0x6e)
	.dw  (0x67)
	.dw  (0x20)
	.dw  (0x45)
	.dw  (0x6e)
	.dw  (0x61)
	.dw  (0x62)
	.dw  (0x6c)
	.dw  (0x65)
	.dw  (0x20)
	.dw  (0x63)
	.dw  (0x6f)
	.dw  (0x6e)
	.dw  (0x74)
	.dw  (0x72)
	.dw  (0x6f)
	.dw  (0x6c)
	.dw  (0x21)
	.dw  (0xa)
	.dw  (0x0)
	.xdata_ovly
_string_const_7
	.dw  (0x45)
	.dw  (0x72)
	.dw  (0x72)
	.dw  (0x6f)
	.dw  (0x72)
	.dw  (0x3a)
	.dw  (0x20)
	.dw  (0x43)
	.dw  (0x6f)
	.dw  (0x75)
	.dw  (0x6c)
	.dw  (0x64)
	.dw  (0x20)
	.dw  (0x6e)
	.dw  (0x6f)
	.dw  (0x74)
	.dw  (0x20)
	.dw  (0x6f)
	.dw  (0x70)
	.dw  (0x65)
	.dw  (0x6e)
	.dw  (0x20)
	.dw  (0x77)
	.dw  (0x61)
	.dw  (0x76)
	.dw  (0x65)
	.dw  (0x66)
	.dw  (0x69)
	.dw  (0x6c)
	.dw  (0x65)
	.dw  (0x2e)
	.dw  (0xa)
	.dw  (0x0)
	.xdata_ovly
_string_const_8
	.dw  (0x45)
	.dw  (0x72)
	.dw  (0x72)
	.dw  (0x6f)
	.dw  (0x72)
	.dw  (0x3a)
	.dw  (0x20)
	.dw  (0x43)
	.dw  (0x6f)
	.dw  (0x75)
	.dw  (0x6c)
	.dw  (0x64)
	.dw  (0x20)
	.dw  (0x6e)
	.dw  (0x6f)
	.dw  (0x74)
	.dw  (0x20)
	.dw  (0x6f)
	.dw  (0x70)
	.dw  (0x65)
	.dw  (0x6e)
	.dw  (0x20)
	.dw  (0x77)
	.dw  (0x61)
	.dw  (0x76)
	.dw  (0x65)
	.dw  (0x66)
	.dw  (0x69)
	.dw  (0x6c)
	.dw  (0x65)
	.dw  (0x2e)
	.dw  (0xa)
	.dw  (0x0)
	.xdata_ovly
_variablesGain
	.dw  (0x50c332f0)
	.dw  (0x50c332f0)
	.code_ovly



	# This construction should ensure linking of crt0 in case when target is a standalone program without the OS
	.if defined(_OVLY_)
		.if .strcmp('standalone',_OVLY_)=0
		.if .strcmp('crystal32',_TARGET_FAMILY_)=0
			.extern __start         # dummy use of __start to force linkage of crt0
dummy		.equ(__start)
		.else
			.extern __intvec         # dummy use of __intvec to force linkage of intvec
dummy		.equ(__intvec)
		.endif
		.endif
	.endif

_main:			/* LN: 94 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = i7			# LN: 94 | 
	i7 += 1			# LN: 94 | 
	i7 = i7 + (0x20f)			# LN: 94 | 
	i1 = i7 - (0x1)			# LN: 94 | 
	xmem[i1] = a0h			# LN: 94 | 
	i1 = i7 - (0x2)			# LN: 94 | 
	xmem[i1] = i0			# LN: 94 | 
cline_94_0:			/* LN: 113 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 113 | 
	a0 = xmem[i0]			# LN: 113 | 
	uhalfword(a1) = (0x4)			# LN: 113 | 
	a0 - a1			# LN: 113 | 
	if (a <= 0) jmp (else_2)			# LN: 113 | 
cline_113_0:			/* LN: 114 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 114 | 
	i0 = xmem[i0]			# LN: 114 | 
	i1 = (0) + (_string_const_0)			# LN: 114 | 
	i0 = i0 + (0x6)			# LN: 114 | 
	i0 = xmem[i0]			# LN: 114 | 
	call (_strcmp)			# LN: 114 | 
	a0 & a0			# LN: 114 | 
	if (a != 0) jmp (else_3)			# LN: 114 | 
cline_114_0:			/* LN: 115 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 115 | 
	xmem[_outputMode + 0] = a0h			# LN: 115 | 
	jmp (endif_3)			# LN: 115 | 
cline_115_0:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
else_3:			/* LN: 114 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 116 | 
	i0 = xmem[i0]			# LN: 116 | 
	i1 = (0) + (_string_const_1)			# LN: 116 | 
	i0 = i0 + (0x6)			# LN: 116 | 
	i0 = xmem[i0]			# LN: 116 | 
	call (_strcmp)			# LN: 116 | 
	a0 & a0			# LN: 116 | 
	if (a != 0) jmp (else_4)			# LN: 116 | 
cline_116_0:			/* LN: 117 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x1)			# LN: 117 | 
	xmem[_outputMode + 0] = a0h			# LN: 117 | 
	jmp (endif_4)			# LN: 117 | 
cline_117_0:			/* LN: 118 | CYCLE: 0 | RULES: () */ 
else_4:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 118 | 
	i0 = xmem[i0]			# LN: 118 | 
	i1 = (0) + (_string_const_2)			# LN: 118 | 
	i0 = i0 + (0x6)			# LN: 118 | 
	i0 = xmem[i0]			# LN: 118 | 
	call (_strcmp)			# LN: 118 | 
	a0 & a0			# LN: 118 | 
	if (a != 0) jmp (else_5)			# LN: 118 | 
cline_118_0:			/* LN: 119 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x2)			# LN: 119 | 
	xmem[_outputMode + 0] = a0h			# LN: 119 | 
	jmp (endif_5)			# LN: 119 | 
cline_119_0:			/* LN: 122 | CYCLE: 0 | RULES: () */ 
else_5:			/* LN: 118 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_string_const_3)			# LN: 122 | 
	call (_printf)			# LN: 122 | 
cline_122_0:			/* LN: 123 | CYCLE: 0 | RULES: () */ 
	halfword(a0) = (0xffff)			# LN: 123 | 
	jmp (__epilogue_224)			# LN: 123 | 
cline_123_0:			/* LN: 114 | CYCLE: 0 | RULES: () */ 
endif_3:			/* LN: 114 | CYCLE: 0 | RULES: () */ 
endif_4:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
endif_5:			/* LN: 118 | CYCLE: 0 | RULES: () */ 
	jmp (endif_2)			# LN: 114 | 
cline_114_1:			/* LN: 128 | CYCLE: 0 | RULES: () */ 
endif_2:			/* LN: 113 | CYCLE: 0 | RULES: () */ 
else_2:			/* LN: 113 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 128 | 
	a0 = xmem[i0]			# LN: 128 | 
	uhalfword(a1) = (0x3)			# LN: 128 | 
	a0 - a1			# LN: 128 | 
	if (a <= 0) jmp (else_6)			# LN: 128 | 
cline_128_0:			/* LN: 129 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 129 | 
	i0 = xmem[i0]			# LN: 129 | 
	i1 = (0) + (_string_const_4)			# LN: 129 | 
	i0 = i0 + (0x3)			# LN: 129 | 
	i0 = xmem[i0]			# LN: 129 | 
	call (_strcmp)			# LN: 129 | 
	a0 & a0			# LN: 129 | 
	if (a != 0) jmp (else_7)			# LN: 129 | 
cline_129_0:			/* LN: 130 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 130 | 
	xmem[_enabled + 0] = a0h			# LN: 130 | 
	jmp (endif_7)			# LN: 130 | 
cline_130_0:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
else_7:			/* LN: 129 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 131 | 
	i0 = xmem[i0]			# LN: 131 | 
	i1 = (0) + (_string_const_5)			# LN: 131 | 
	i0 = i0 + (0x3)			# LN: 131 | 
	i0 = xmem[i0]			# LN: 131 | 
	call (_strcmp)			# LN: 131 | 
	a0 & a0			# LN: 131 | 
	if (a == 0) jmp (else_8)			# LN: 131 | 
cline_131_0:			/* LN: 132 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_string_const_6)			# LN: 132 | 
	call (_printf)			# LN: 132 | 
cline_132_0:			/* LN: 133 | CYCLE: 0 | RULES: () */ 
	halfword(a0) = (0xffff)			# LN: 133 | 
	jmp (__epilogue_224)			# LN: 133 | 
cline_133_0:			/* LN: 129 | CYCLE: 0 | RULES: () */ 
endif_7:			/* LN: 129 | CYCLE: 0 | RULES: () */ 
endif_8:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
else_8:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
	jmp (endif_6)			# LN: 129 | 
cline_129_1:			/* LN: 140 | CYCLE: 0 | RULES: () */ 
endif_6:			/* LN: 128 | CYCLE: 0 | RULES: () */ 
else_6:			/* LN: 128 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 140 | 
	a0 = 0			# LN: 140 | 
	xmem[i0] = a0h			# LN: 140 | 
	do (0x8), label_end_93			# LN: 140 | 
cline_140_0:			/* LN: 141 | CYCLE: 0 | RULES: () */ 
label_begin_93:			/* LN: 140 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 141 | 
	a0 = 0			# LN: 141 | 
	xmem[i0] = a0h			# LN: 141 | 
	do (0x10), label_end_92			# LN: 141 | 
cline_141_0:			/* LN: 142 | CYCLE: 0 | RULES: () */ 
label_begin_92:			/* LN: 141 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 142 | 
	a0 = xmem[i0]; a1 = 0			# LN: 142, 142 | 
	a0 = a0 << 4			# LN: 142 | 
	i0 = a0			# LN: 142 | 
	i1 = i7 - (0x4)			# LN: 142 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 142 | 
	a0 = xmem[i1]			# LN: 142 | 
	b0 = i0			# LN: 142 | 
	a0 = a0 + b0			# LN: 142 | 
	AnyReg(i0, a0h)			# LN: 142 | 
	nop #empty cycle
	ymem[i0] = a1h			# LN: 142 | 
cline_142_0:			/* LN: 141 | CYCLE: 0 | RULES: () */ 
init_latch_label_0:			/* LN: 142 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 141 | 
	a0 = xmem[i0]			# LN: 141 | 
	uhalfword(a1) = (0x1)			# LN: 141 | 
	a0 = a0 + a1			# LN: 141 | 
	i0 = i7 - (0x4)			# LN: 141 | 
label_end_92:			# LN: 141 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 141 | 
cline_141_1:			/* LN: 140 | CYCLE: 0 | RULES: () */ 
init_latch_label_1:			/* LN: 142 | CYCLE: 0 | RULES: () */ 
for_end_1:			/* LN: 141 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x3)			# LN: 140 | 
	a0 = xmem[i0]			# LN: 140 | 
	uhalfword(a1) = (0x1)			# LN: 140 | 
	a0 = a0 + a1			# LN: 140 | 
	i0 = i7 - (0x3)			# LN: 140 | 
label_end_93:			# LN: 140 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 140 | 
cline_140_1:			/* LN: 146 | CYCLE: 0 | RULES: () */ 
for_end_0:			/* LN: 140 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 146 | 
	i0 = xmem[i0]			# LN: 146 | 
	i1 = i7 - (260 - 0)			# LN: 146 | 
	i4 = xmem[i0]			# LN: 146 | 
	i0 = i1			# LN: 146 | 
	i1 = i4			# LN: 146 | 
	call (_strcpy)			# LN: 146 | 
cline_146_0:			/* LN: 147 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (260 - 0)			# LN: 147 | 
	call (_cl_wavread_open)			# LN: 147 | 
	AnyReg(i0, a0h)			# LN: 147 | 
	i1 = i7 - (0x105)			# LN: 147 | 
	xmem[i1] = i0			# LN: 147 | 
cline_147_0:			/* LN: 148 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 148 | 
	a0 = xmem[i0]			# LN: 148 | 
	a0 & a0			# LN: 148 | 
	if (a != 0) jmp (else_9)			# LN: 148 | 
cline_148_0:			/* LN: 150 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_string_const_7)			# LN: 150 | 
	call (_printf)			# LN: 150 | 
cline_150_0:			/* LN: 151 | CYCLE: 0 | RULES: () */ 
	halfword(a0) = (0xffff)			# LN: 151 | 
	jmp (__epilogue_224)			# LN: 151 | 
cline_151_0:			/* LN: 157 | CYCLE: 0 | RULES: () */ 
endif_9:			/* LN: 148 | CYCLE: 0 | RULES: () */ 
else_9:			/* LN: 148 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 157 | 
	i0 = xmem[i0]			# LN: 157 | 
	call (_cl_wavread_getnchannels)			# LN: 157 | 
	i0 = i7 - (0x106)			# LN: 157 | 
	xmem[i0] = a0h			# LN: 157 | 
cline_157_0:			/* LN: 158 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 158 | 
	i0 = xmem[i0]			# LN: 158 | 
	call (_cl_wavread_bits_per_sample)			# LN: 158 | 
	i0 = i7 - (0x107)			# LN: 158 | 
	xmem[i0] = a0h			# LN: 158 | 
cline_158_0:			/* LN: 159 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 159 | 
	i0 = xmem[i0]			# LN: 159 | 
	call (_cl_wavread_frame_rate)			# LN: 159 | 
	i0 = i7 - (0x108)			# LN: 159 | 
	xmem[i0] = a0h			# LN: 159 | 
cline_159_0:			/* LN: 160 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 160 | 
	i0 = xmem[i0]			# LN: 160 | 
	call (_cl_wavread_number_of_frames)			# LN: 160 | 
	i0 = i7 - (0x109)			# LN: 160 | 
	xmem[i0] = a0h			# LN: 160 | 
cline_160_0:			/* LN: 165 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x2)			# LN: 165 | 
	i0 = xmem[i0]			# LN: 165 | 
	i1 = i7 - (521 - 0)			# LN: 165 | 
	i0 += 1			# LN: 165 | 
	i4 = xmem[i0]			# LN: 165 | 
	i0 = i1			# LN: 165 | 
	i1 = i4			# LN: 165 | 
	call (_strcpy)			# LN: 165 | 
cline_165_0:			/* LN: 167 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_outputMode + 0]			# LN: 167 | 
	uhalfword(a1) = (0x1)			# LN: 167 | 
	a0 = a0 + a1			# LN: 167 | 
	a0 = a0 << 1			# LN: 167 | 
	i0 = i7 - (0x20a)			# LN: 167 | 
	xmem[i0] = a0h			# LN: 167 | 
cline_167_0:			/* LN: 168 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (521 - 0)			# LN: 168 | 
	i1 = i7 - (0x107)			# LN: 168 | 
	a0 = xmem[i1]			# LN: 168 | 
	i1 = i7 - (0x20a)			# LN: 168 | 
	a1 = xmem[i1]			# LN: 168 | 
	i1 = i7 - (0x108)			# LN: 168 | 
	b0 = xmem[i1]			# LN: 168 | 
	call (_cl_wavwrite_open)			# LN: 168 | 
	AnyReg(i0, a0h)			# LN: 168 | 
	i1 = i7 - (0x20b)			# LN: 168 | 
	xmem[i1] = i0			# LN: 168 | 
cline_168_0:			/* LN: 169 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20b)			# LN: 169 | 
	a0 = xmem[i0]			# LN: 169 | 
	a0 & a0			# LN: 169 | 
	if (a != 0) jmp (else_10)			# LN: 169 | 
cline_169_0:			/* LN: 171 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_string_const_8)			# LN: 171 | 
	call (_printf)			# LN: 171 | 
cline_171_0:			/* LN: 172 | CYCLE: 0 | RULES: () */ 
	halfword(a0) = (0xffff)			# LN: 172 | 
	jmp (__epilogue_224)			# LN: 172 | 
cline_172_0:			/* LN: 185 | CYCLE: 0 | RULES: () */ 
endif_10:			/* LN: 169 | CYCLE: 0 | RULES: () */ 
else_10:			/* LN: 169 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20c)			# LN: 185 | 
	a0 = 0			# LN: 185 | 
	xmem[i0] = a0h			# LN: 185 | 
for_2:			/* LN: 185 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x109)			# LN: 185 | 
	a0 = xmem[i0]			# LN: 185 | 
	uhalfword(a1) = (0x10)			# LN: 185 | 
	call (__div)			# LN: 185 | 
	i0 = i7 - (0x20c)			# LN: 185 | 
	a1 = xmem[i0]			# LN: 185 | 
	a1 - a0			# LN: 185 | 
	if (a >= 0) jmp (for_end_2)			# LN: 185 | 
cline_185_0:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20d)			# LN: 187 | 
	a0 = 0			# LN: 187 | 
	xmem[i0] = a0h			# LN: 187 | 
	do (0x10), label_end_94			# LN: 187 | 
cline_187_0:			/* LN: 189 | CYCLE: 0 | RULES: () */ 
label_begin_94:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 189 | 
	a0 = 0			# LN: 189 | 
	xmem[i0] = a0h			# LN: 189 | 
for_4:			/* LN: 189 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 189 | 
	a0 = xmem[i0]			# LN: 189 | 
	i0 = i7 - (0x106)			# LN: 189 | 
	a1 = xmem[i0]			# LN: 189 | 
	a0 - a1			# LN: 189 | 
	if (a >= 0) jmp (for_end_4)			# LN: 189 | 
cline_189_0:			/* LN: 191 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 191 | 
	i0 = xmem[i0]			# LN: 191 | 
	call (_cl_wavread_recvsample)			# LN: 191 | 
	i0 = i7 - (0x20f)			# LN: 191 | 
	xmem[i0] = a0h			# LN: 191 | 
cline_191_0:			/* LN: 192 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 192 | 
	a0 = xmem[i0]			# LN: 192 | 
	a0 = a0 << 4			# LN: 192 | 
	i0 = a0			# LN: 192 | 
	i1 = i7 - (0x20d)			# LN: 192 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 192 | 
	a0 = xmem[i1]			# LN: 192 | 
	a1 = i0			# LN: 192 | 
	a0 = a1 + a0			# LN: 192 | 
	AnyReg(i0, a0h)			# LN: 192 | 
	i1 = i7 - (0x20f)			# LN: 192 | 
	a0 = xmem[i1]			# LN: 192 | 
	ymem[i0] = a0h			# LN: 192 | 
cline_192_0:			/* LN: 189 | CYCLE: 0 | RULES: () */ 
init_latch_label_2:			/* LN: 193 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 189 | 
	a0 = xmem[i0]			# LN: 189 | 
	uhalfword(a1) = (0x1)			# LN: 189 | 
	a0 = a0 + a1			# LN: 189 | 
	i0 = i7 - (0x20e)			# LN: 189 | 
	xmem[i0] = a0h			# LN: 189 | 
	jmp (for_4)			# LN: 189 | 
cline_189_1:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
init_latch_label_3:			/* LN: 194 | CYCLE: 0 | RULES: () */ 
for_end_4:			/* LN: 189 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20d)			# LN: 187 | 
	a0 = xmem[i0]			# LN: 187 | 
	uhalfword(a1) = (0x1)			# LN: 187 | 
	a0 = a0 + a1			# LN: 187 | 
	i0 = i7 - (0x20d)			# LN: 187 | 
label_end_94:			# LN: 187 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 187 | 
cline_187_1:			/* LN: 197 | CYCLE: 0 | RULES: () */ 
for_end_3:			/* LN: 187 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_enabled + 0]			# LN: 197 | 
	a0 & a0			# LN: 197 | 
	if (a == 0) jmp (else_11)			# LN: 197 | 
cline_197_0:			/* LN: 198 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_sampleBuffer)			# LN: 198 | 
	i1 = (0) + (_sampleBuffer)			# LN: 198 | 
	call (_signalProcessing)			# LN: 198 | 
	jmp (endif_11)			# LN: 198 | 
cline_198_0:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
endif_11:			/* LN: 197 | CYCLE: 0 | RULES: () */ 
else_11:			/* LN: 197 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20d)			# LN: 200 | 
	a0 = 0			# LN: 200 | 
	xmem[i0] = a0h			# LN: 200 | 
	do (0x10), label_end_95			# LN: 200 | 
cline_200_0:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
label_begin_95:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 202 | 
	a0 = 0			# LN: 202 | 
	xmem[i0] = a0h			# LN: 202 | 
for_6:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 202 | 
	a0 = xmem[i0]			# LN: 202 | 
	i0 = i7 - (0x20a)			# LN: 202 | 
	a1 = xmem[i0]			# LN: 202 | 
	a0 - a1			# LN: 202 | 
	if (a >= 0) jmp (for_end_6)			# LN: 202 | 
cline_202_0:			/* LN: 204 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 204 | 
	a0 = xmem[i0]			# LN: 204 | 
	a0 = a0 << 4			# LN: 204 | 
	i0 = a0			# LN: 204 | 
	i1 = i7 - (0x20d)			# LN: 204 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 204 | 
	a0 = xmem[i1]			# LN: 204 | 
	a1 = i0			# LN: 204 | 
	a0 = a1 + a0			# LN: 204 | 
	AnyReg(i0, a0h)			# LN: 204 | 
	i1 = i7 - (0x20f)			# LN: 204 | 
	a0 = ymem[i0]			# LN: 204 | 
	xmem[i1] = a0h			# LN: 204 | 
cline_204_0:			/* LN: 205 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20b)			# LN: 205 | 
	i1 = i7 - (0x20f)			# LN: 205 | 
	a0 = xmem[i1]			# LN: 205 | 
	i0 = xmem[i0]			# LN: 205 | 
	call (_cl_wavwrite_sendsample)			# LN: 205 | 
cline_205_0:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
init_latch_label_4:			/* LN: 206 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20e)			# LN: 202 | 
	a0 = xmem[i0]			# LN: 202 | 
	uhalfword(a1) = (0x1)			# LN: 202 | 
	a0 = a0 + a1			# LN: 202 | 
	i0 = i7 - (0x20e)			# LN: 202 | 
	xmem[i0] = a0h			# LN: 202 | 
	jmp (for_6)			# LN: 202 | 
cline_202_1:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
init_latch_label_5:			/* LN: 207 | CYCLE: 0 | RULES: () */ 
for_end_6:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20d)			# LN: 200 | 
	a0 = xmem[i0]			# LN: 200 | 
	uhalfword(a1) = (0x1)			# LN: 200 | 
	a0 = a0 + a1			# LN: 200 | 
	i0 = i7 - (0x20d)			# LN: 200 | 
label_end_95:			# LN: 200 | CYCLE: 5 | RULES: ()
	xmem[i0] = a0h			# LN: 200 | 
cline_200_1:			/* LN: 185 | CYCLE: 0 | RULES: () */ 
init_latch_label_6:			/* LN: 208 | CYCLE: 0 | RULES: () */ 
for_end_5:			/* LN: 200 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20c)			# LN: 185 | 
	a0 = xmem[i0]			# LN: 185 | 
	uhalfword(a1) = (0x1)			# LN: 185 | 
	a0 = a0 + a1			# LN: 185 | 
	i0 = i7 - (0x20c)			# LN: 185 | 
	xmem[i0] = a0h			# LN: 185 | 
	jmp (for_2)			# LN: 185 | 
cline_185_1:			/* LN: 213 | CYCLE: 0 | RULES: () */ 
for_end_2:			/* LN: 185 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x105)			# LN: 213 | 
	i0 = xmem[i0]			# LN: 213 | 
	call (_cl_wavread_close)			# LN: 213 | 
cline_213_0:			/* LN: 214 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x20b)			# LN: 214 | 
	i0 = xmem[i0]			# LN: 214 | 
	call (_cl_wavwrite_close)			# LN: 214 | 
cline_214_0:			/* LN: 217 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 217 | 
	jmp (__epilogue_224)			# LN: 217 | 
cline_217_0:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
__epilogue_224:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x20f)			# LN: 218 | 
	i7 -= 1			# LN: 218 | 
	ret			# LN: 218 | 



_saturation:			/* LN: 21 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = i7			# LN: 21 | 
	i7 += 1			# LN: 21 | 
	i7 = i7 + (0x4)			# LN: 21 | 
	i0 = i7 - (0x1)			# LN: 21 | 
	xmem[i0] = a0h			# LN: 21 | 
cline_21_0:			/* LN: 23 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 23 | 
	a0 = xmem[i0]			# LN: 23 | 
	i0 = i7 - (0x4)			# LN: 23 | 
	xmem[i0] = a0g; i0 += 1			# LN: 23, 23 | 
	xmem[i0] = a0h; i0 += 1			# LN: 23, 23 | 
	xmem[i0] = a0l			# LN: 23 | 
cline_23_0:			/* LN: 25 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x4)			# LN: 25 | 
	a1g = xmem[i0]; i0 += 1			# LN: 25, 25 | 
	a1h = xmem[i0]; i0 += 1			# LN: 25, 25 | 
	a1l = xmem[i0]			# LN: 25 | 
	b0 =+ a1			# LN: 25 | 
	b0 = b0 >> 1			# LN: 25 | 
	a0 = xmem[_limiterThreshold + 0]			# LN: 25 | 
	a0 = a0 >> 1			# LN: 25 | 
	b0 - a0			# LN: 25 | 
	if (b <= 0) jmp (else_0)			# LN: 25 | 
cline_25_0:			/* LN: 27 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_limiterThreshold + 0]			# LN: 27 | 
	jmp (__epilogue_220)			# LN: 27 | 
cline_27_0:			/* LN: 29 | CYCLE: 0 | RULES: () */ 
else_0:			/* LN: 25 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_limiterThreshold + 0]			# LN: 29 | 
	i0 = i7 - (0x4)			# LN: 29 | 
	a1g = xmem[i0]; i0 += 1			# LN: 29, 29 | 
	a1h = xmem[i0]; i0 += 1			# LN: 29, 29 | 
	a0 =- a0			# LN: 29 | 
	a1l = xmem[i0]			# LN: 29 | 
	b0 =+ a1			# LN: 29 | 
	a0 = a0 >> 1; b0 = b0 >> 1			# LN: 29, 29 | 
	b0 - a0			# LN: 29 | 
	if (b >= 0) jmp (else_1)			# LN: 29 | 
cline_29_0:			/* LN: 31 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_limiterThreshold + 0]			# LN: 31 | 
	a0 =- a0			# LN: 31 | 
	jmp (__epilogue_220)			# LN: 31 | 
cline_31_0:			/* LN: 33 | CYCLE: 0 | RULES: () */ 
endif_0:			/* LN: 25 | CYCLE: 0 | RULES: () */ 
endif_1:			/* LN: 29 | CYCLE: 0 | RULES: () */ 
else_1:			/* LN: 29 | CYCLE: 0 | RULES: () */ 
	i0 = i7 - (0x1)			# LN: 33 | 
	a0 = xmem[i0]			# LN: 33 | 
	jmp (__epilogue_220)			# LN: 33 | 
cline_33_0:			/* LN: 34 | CYCLE: 0 | RULES: () */ 
__epilogue_220:			/* LN: 34 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x4)			# LN: 34 | 
	i7 -= 1			# LN: 34 | 
	ret			# LN: 34 | 
