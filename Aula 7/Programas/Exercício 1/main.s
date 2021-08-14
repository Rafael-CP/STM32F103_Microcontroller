;---Ex_1e - mult. vt1*vt2 pos incr
		export 	__main
;---diretiva area-dados -sram
		area 	d_2, data, readwrite
vt1 	space	8
vt2		space	8
vtk		space	16
;---directive area-programa
		area 	m_prog, code, readonly
__main
pk0 	ldr 	r0,=vt1 		;r0=&vt1
		ldr 	r1,=vt2 		;r1=&vt1
		ldr		r2,=vtk			;r2=&vtk
		mov		r3,r0			;contador
		add		r3,#8	
pk1 	ldrh	r4,[r0]
		ldrh	r5,[r1]
		mul 	r6,r4,r5
		str 	r6,[r2],#4		;pos incremento
		add		r0,#2
		add		r1,#2
		cmp		r0,r3
		bne 	pk1 
		b 		pk0 
		end