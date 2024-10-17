	.extern ___TIMER0_COUNT
	.extern ___TIMER1_COUNT
	.extern ___TIMER1_ENABLE
	.public _limiterThreshold
	.public _outputMode
	.public _sampleBuffer
	.public _variablesGain
	.extern _cl_get_cycle_count
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
_string_const_9
	.dw  (0x25)
	.dw  (0x6c)
	.dw  (0x6c)
	.dw  (0x75)
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

_main:			/* LN: 95 | CYCLE: 0 | RULES: () */ 
	xmem[i7] = a2g; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = a2h; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = a2l; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = i2; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = i3; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = a3g; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = a3h; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = a3l; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = b2g; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = b2h; i7 += 1			# LN: 95, 95 | 
	xmem[i7] = b2l; i7 += 1			# LN: 95, 95 | 
	a2 =+ a0			# LN: 95 | 
	i7 = i7 + (0x200)			# LN: 95 | 
	i2 = i0			# LN: 95 | 
	uhalfword(a0) = (0x4)			# LN: 116 | 
	a2 - a0			# LN: 116 | 
	if (a <= 0) jmp (else_2)			# LN: 116 | 
	i0 = i2 + (0x6)			# LN: 117 | 
	i0 = xmem[i0]			# LN: 117 | 
	i1 = (0) + (_string_const_0)			# LN: 117 | 
	call (_strcmp)			# LN: 117 | 
	a0 & a0			# LN: 117 | 
	if (a != 0) jmp (else_3)			# LN: 117 | 
	a0 = 0			# LN: 118 | 
	xmem[_outputMode + 0] = a0h			# LN: 118 | 
	jmp (else_2)			# LN: 118 | 
else_3:			/* LN: 117 | CYCLE: 0 | RULES: () */ 
	i0 = i2 + (0x6)			# LN: 119 | 
	i0 = xmem[i0]			# LN: 119 | 
	i1 = (0) + (_string_const_1)			# LN: 119 | 
	call (_strcmp)			# LN: 119 | 
	a0 & a0			# LN: 119 | 
	if (a != 0) jmp (else_4)			# LN: 119 | 
	uhalfword(a0) = (0x1)			# LN: 120 | 
	xmem[_outputMode + 0] = a0h			# LN: 120 | 
	jmp (else_2)			# LN: 120 | 
else_4:			/* LN: 119 | CYCLE: 0 | RULES: () */ 
	i0 = i2 + (0x6)			# LN: 121 | 
	i0 = xmem[i0]			# LN: 121 | 
	i1 = (0) + (_string_const_2)			# LN: 121 | 
	call (_strcmp)			# LN: 121 | 
	a0 & a0			# LN: 121 | 
	if (a != 0) jmp (else_5)			# LN: 121 | 
	uhalfword(a0) = (0x2)			# LN: 122 | 
	xmem[_outputMode + 0] = a0h			# LN: 122 | 
	jmp (else_2)			# LN: 122 | 
else_5:			/* LN: 121 | CYCLE: 0 | RULES: () */ 
	i0 = (0) + (_string_const_3)			# LN: 125 | 
	call (_printf)			# LN: 125 | 
	halfword(a0) = (0xffff)			# LN: 126 | 
	jmp (__epilogue_238)			# LN: 126 | 
endif_2:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
else_2:			/* LN: 116 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x3)			# LN: 131 | 
	a2 - a0			# LN: 131 | 
	if (a <= 0) jmp (else_6)			# LN: 131 | 
	i0 = i2 + (0x3)			# LN: 132 | 
	i0 = xmem[i0]			# LN: 132 | 
	i1 = (0) + (_string_const_4)			# LN: 132 | 
	call (_strcmp)			# LN: 132 | 
	a0 & a0			# LN: 132 | 
	if (a != 0) jmp (else_7)			# LN: 132 | 
	a0 = 0			# LN: 133 | 
	xmem[_enabled + 0] = a0h			# LN: 133 | 
	jmp (else_6)			# LN: 133 | 
else_7:			/* LN: 132 | CYCLE: 0 | RULES: () */ 
	i0 = i2 + (0x3)			# LN: 134 | 
	i0 = xmem[i0]			# LN: 134 | 
	i1 = (0) + (_string_const_5)			# LN: 134 | 
	call (_strcmp)			# LN: 134 | 
	a0 & a0			# LN: 134 | 
	if (a == 0) jmp (else_6)			# LN: 134 | 
	i0 = (0) + (_string_const_6)			# LN: 135 | 
	call (_printf)			# LN: 135 | 
	halfword(a0) = (0xffff)			# LN: 136 | 
	jmp (__epilogue_238)			# LN: 136 | 
endif_6:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
else_6:			/* LN: 131 | CYCLE: 0 | RULES: () */ 
	a0 = 0			# LN: 143 | 
	do (0x8), label_end_93			# LN: 143 | 
label_begin_93:			/* LN: 143 | CYCLE: 0 | RULES: () */ 
	a1 = 0			# LN: 144 | 
	do (0x10), label_end_92			# LN: 144 | 
label_begin_92:			/* LN: 144 | CYCLE: 0 | RULES: () */ 
	b0 =+ a0			# LN: 145 | 
	b0 = b0 << 4			# LN: 145 | 
	i0 = b0; b0 = 0			# LN: 145, 145 | 
	uhalfword(b1) = (0x1)			# LN: 144 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 145 | 
	a2 = i0			# LN: 145 | 
	a2 = a2 + a1			# LN: 145 | 
	AnyReg(i0, a2h)			# LN: 145 | 
	a1 = a1 + b1			# LN: 144 | 
label_end_92:			# LN: 144 | CYCLE: 9 | RULES: ()
	ymem[i0] = b0h			# LN: 145 | 
init_latch_label_1:			/* LN: 145 | CYCLE: 0 | RULES: () */ 
for_end_1:			/* LN: 144 | CYCLE: 0 | RULES: () */ 
	uhalfword(a1) = (0x1)			# LN: 143 | 
label_end_93:			# LN: 143 | CYCLE: 1 | RULES: ()
	a0 = a0 + a1			# LN: 143 | 
for_end_0:			/* LN: 143 | CYCLE: 0 | RULES: () */ 
	i1 = xmem[i2]			# LN: 149 | 
	i0 = i7 - (256 - 0)			# LN: 149 | 
	call (_strcpy)			# LN: 149 | 
	i0 = i7 - (256 - 0)			# LN: 150 | 
	call (_cl_wavread_open)			# LN: 150 | 
	AnyReg(i3, a0h)			# LN: 150 | 
	a0 = i3			# LN: 151 | 
	a0 & a0			# LN: 151 | 
	if (a != 0) jmp (else_9)			# LN: 151 | 
	i0 = (0) + (_string_const_7)			# LN: 153 | 
	call (_printf)			# LN: 153 | 
	halfword(a0) = (0xffff)			# LN: 154 | 
	jmp (__epilogue_238)			# LN: 154 | 
endif_9:			/* LN: 151 | CYCLE: 0 | RULES: () */ 
else_9:			/* LN: 151 | CYCLE: 0 | RULES: () */ 
	i0 = i3			# LN: 160 | 
	call (_cl_wavread_getnchannels)			# LN: 160 | 
	i2 += 1; a2 =+ a0			# LN: 168, 160 | 
	i0 = i3			# LN: 161 | 
	call (_cl_wavread_bits_per_sample)			# LN: 161 | 
	a1 =+ a0			# LN: 161 | 
	i0 = i3			# LN: 162 | 
	call (_cl_wavread_frame_rate)			# LN: 162 | 
	b0 =+ a0			# LN: 162 | 
	i0 = i3			# LN: 163 | 
	call (_cl_wavread_number_of_frames)			# LN: 163 | 
	i0 = i7 - (512 - 0)			# LN: 168 | 
	i1 = xmem[i2]			# LN: 168 | 
	b1 =+ a0			# LN: 163 | 
	call (_strcpy)			# LN: 168 | 
	a0 = xmem[_outputMode + 0]			# LN: 170 | 
	uhalfword(a3) = (0x1)			# LN: 170 | 
	a3 = a0 + a3			# LN: 170 | 
	a3 = a3 << 1			# LN: 170 | 
	i0 = i7 - (512 - 0)			# LN: 171 | 
	a0 =+ a1			# LN: 171 | 
	a1 =+ a3			# LN: 171 | 
	call (_cl_wavwrite_open)			# LN: 171 | 
	AnyReg(i2, a0h)			# LN: 171 | 
	a0 = i2			# LN: 172 | 
	a0 & a0			# LN: 172 | 
	if (a != 0) jmp (else_10)			# LN: 172 | 
	i0 = (0) + (_string_const_8)			# LN: 174 | 
	call (_printf)			# LN: 174 | 
	halfword(a0) = (0xffff)			# LN: 175 | 
	jmp (__epilogue_238)			# LN: 175 | 
endif_10:			/* LN: 172 | CYCLE: 0 | RULES: () */ 
else_10:			/* LN: 172 | CYCLE: 0 | RULES: () */ 
	uhalfword(a1) = (0x10)			# LN: 188 | 
	a0 =+ b1			# LN: 188 | 
	call (__div)			# LN: 188 | 
	AnyReg(i0, a0h)			# LN: 188 | 
	nop #empty cycle
	do (i0), label_end_98			# LN: 188 | 
label_begin_98:			/* LN: 188 | CYCLE: 0 | RULES: () */ 
	b2 = 0			# LN: 190 | 
	do (0x10), label_end_95			# LN: 190 | 
label_begin_95:			/* LN: 190 | CYCLE: 0 | RULES: () */ 
	AnyReg(i0, a2h)			# LN: 192 | 
	b0 = 0			# LN: 192 | 
	do (i0), label_end_94			# LN: 192 | 
label_begin_94:			/* LN: 192 | CYCLE: 0 | RULES: () */ 
	i0 = i3			# LN: 194 | 
	call (_cl_wavread_recvsample)			# LN: 194 | 
	a1 =+ a0; b1 =+ b0			# LN: 194, 195 | 
	b1 = b1 << 4			# LN: 195 | 
	i0 = b1; a0 =+ a1			# LN: 195, 195 | 
	uhalfword(a1) = (0x1)			# LN: 192 | 
	i0 = i0 + (_sampleBuffer + 0)			# LN: 195 | 
	b1 = i0; b0 = b0 + a1			# LN: 195, 192 | 
	a1 =+ b1			# LN: 195 | 
	a1 = a1 + b2			# LN: 195 | 
	AnyReg(i0, a1h)			# LN: 195 | 
	nop #empty cycle
label_end_94:			# LN: 192 | CYCLE: 12 | RULES: ()
	ymem[i0] = a0h			# LN: 195 | 
init_latch_label_3:			/* LN: 197 | CYCLE: 0 | RULES: () */ 
for_end_4:			/* LN: 192 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x1)			# LN: 190 | 
label_end_95:			# LN: 190 | CYCLE: 1 | RULES: ()
	b2 = b2 + a0			# LN: 190 | 
for_end_3:			/* LN: 190 | CYCLE: 0 | RULES: () */ 
	call (_cl_get_cycle_count)			# LN: 200 | 
	b2 =+ a0			# LN: 200 | 
	a0 = xmem[_enabled + 0]			# LN: 202 | 
	a0 & a0			# LN: 202 | 
	if (a == 0) jmp (else_11)			# LN: 202 | 
	i0 = (0) + (_sampleBuffer)			# LN: 203 | 
	i1 = (0) + (_sampleBuffer)			# LN: 203 | 
	call (_signalProcessing)			# LN: 203 | 
endif_11:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
else_11:			/* LN: 202 | CYCLE: 0 | RULES: () */ 
	call (_cl_get_cycle_count)			# LN: 205 | 
	a0 = a0 - b2			# LN: 206 | 
	i0 = (0) + (_string_const_9)			# LN: 207 | 
	call (_printf)			# LN: 207 | 
	a1 = 0			# LN: 210 | 
	do (0x10), label_end_97			# LN: 210 | 
label_begin_97:			/* LN: 210 | CYCLE: 0 | RULES: () */ 
	AnyReg(i0, a3h)			# LN: 212 | 
	b0 = 0			# LN: 212 | 
	do (i0), label_end_96			# LN: 212 | 
label_begin_96:			/* LN: 212 | CYCLE: 0 | RULES: () */ 
	a0 =+ b0			# LN: 214 | 
	a0 = a0 << 4			# LN: 214 | 
	i1 = a0			# LN: 214 | 
	i0 = i2			# LN: 215 | 
	i1 = i1 + (_sampleBuffer + 0)			# LN: 214 | 
	a0 = i1			# LN: 214 | 
	a0 = a0 + a1			# LN: 214 | 
	AnyReg(i1, a0h)			# LN: 214 | 
	uhalfword(a0) = (0x1)			# LN: 212 | 
	b1 = ymem[i1]; b0 = b0 + a0			# LN: 214, 212 | 
	a0 =+ b1			# LN: 214 | 
label_end_96:			# LN: 212 | CYCLE: 11 | RULES: ()
	call (_cl_wavwrite_sendsample)			# LN: 215 | 
init_latch_label_5:			/* LN: 217 | CYCLE: 0 | RULES: () */ 
for_end_6:			/* LN: 212 | CYCLE: 0 | RULES: () */ 
	uhalfword(a0) = (0x1)			# LN: 210 | 
label_end_97:			# LN: 210 | CYCLE: 1 | RULES: ()
	a1 = a1 + a0			# LN: 210 | 
init_latch_label_6:			/* LN: 218 | CYCLE: 0 | RULES: () */ 
for_end_5:			/* LN: 210 | CYCLE: 0 | RULES: () */ 
label_end_98:			# LN: 188 | CYCLE: 0 | RULES: ()
	nop #empty cycle
for_end_2:			/* LN: 188 | CYCLE: 0 | RULES: () */ 
	i0 = i3			# LN: 223 | 
	call (_cl_wavread_close)			# LN: 223 | 
	i0 = i2			# LN: 224 | 
	call (_cl_wavwrite_close)			# LN: 224 | 
	a0 = 0			# LN: 227 | 
__epilogue_238:			/* LN: 228 | CYCLE: 0 | RULES: () */ 
	i7 = i7 - (0x200)			# LN: 228 | 
	i7 -= 1			# LN: 228 | 
	b2l = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	b2h = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	b2g = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a3l = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a3h = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a3g = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	i3 = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	i2 = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a2l = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a2h = xmem[i7]; i7 -= 1			# LN: 228, 228 | 
	a2g = xmem[i7]			# LN: 228 | 
	ret			# LN: 228 | 



_saturation:			/* LN: 22 | CYCLE: 0 | RULES: () */ 
	a1 =+ a0			# LN: 22 | 
	b0 =+ a1			# LN: 26 | 
	b0 = b0 >> 1			# LN: 26 | 
	a0 = xmem[_limiterThreshold + 0]			# LN: 26 | 
	a0 = a0 >> 1			# LN: 26 | 
	b0 - a0			# LN: 26 | 
	if (b <= 0) jmp (else_0)			# LN: 26 | 
	a0 = xmem[_limiterThreshold + 0]			# LN: 28 | 
	jmp (__epilogue_234)			# LN: 28 | 
else_0:			/* LN: 26 | CYCLE: 0 | RULES: () */ 
	a0 = xmem[_limiterThreshold + 0]			# LN: 30 | 
	a0 =- a0			# LN: 30 | 
	b0 =+ a1			# LN: 30 | 
	a0 = a0 >> 1; b0 = b0 >> 1			# LN: 30, 30 | 
	b0 - a0			# LN: 30 | 
	if (b >= 0) jmp (else_1)			# LN: 30 | 
	a0 = xmem[_limiterThreshold + 0]			# LN: 32 | 
	a0 =- a0			# LN: 32 | 
	jmp (__epilogue_234)			# LN: 32 | 
endif_0:			/* LN: 26 | CYCLE: 0 | RULES: () */ 
endif_1:			/* LN: 30 | CYCLE: 0 | RULES: () */ 
else_1:			/* LN: 30 | CYCLE: 0 | RULES: () */ 
	a0 =+ a1			# LN: 34 | 
__epilogue_234:			/* LN: 35 | CYCLE: 0 | RULES: () */ 
	ret			# LN: 35 | 
