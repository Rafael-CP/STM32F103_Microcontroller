;---Ex_2e - div. vr/vs pos incr
		export 	__main
tam		equ		8
;---diretiva area-dados -sram
		area 	d_2, data, readwrite
vr 		space	tam
vs		space	tam
vrs		space	tam
;---directive area-programa
		area 	m_prog, code, readonly
__main
pk0 	ldr 	r0,=vr 		;r0=&vr
		ldr 	r1,=vrs		;r1=&vs
		ldr		r2,=vr+tam	;r2=&vrs
pk1 	ldrsb 	r4,[r0,#tam]
		ldrsb	r3,[r0],#1
		sdiv 	r5,r3,r4
		strb 	r5,[r1],#1	;pos incremento
		cmp		r0,r2
		bne 	pk1 
		b 		pk0 
		end	