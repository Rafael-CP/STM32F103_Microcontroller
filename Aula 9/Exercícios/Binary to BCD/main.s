;Ex_9.1b - bin(2b) to bcd(5 alg cptd)
		export __main
;---diret. area-dados (sram)sram
		area dds1, data, readwrite
vbin 	space 	2
dezmm	space 	1
centdez	space 	1
unid 	space 	1
;---diret area-prog (flash)
		area mprg, code, readonly
__main
		ldr 	r0,=vbin
pki 	mov 	r1,#0 ;
		mov 	r5,#10000
		str 	r1,[r0,#2]		;dmil=mil=cent=dez=unid=0
		
pk0 	ldrh 	r2,[r0]
		subs 	r2,r2,r5		;dezena milhar
		bmi 	pk1x
		strh 	r2,[r0]
		ldrh 	r1,[r0,#2]
		add 	r1,#1
		strb 	r1,[r0,#2]
		b 		pk0
		
pk1x	lsl		r5, r1,4
		strb 	r5,[r0,#2]

pk1y	ldrh 	r2,[r0]
		subs 	r2,#1000  		;milhar
		bmi 	pk2
		
		strh 	r2,[r0]
		ldrh 	r1,[r0,#2]
		add 	r1,#1
		orr		r1,r5
		strb	r1,[r0,#2]
		b 		pk1y
		
pk2 	ldrh 	r2,[r0]			;centena
		subs 	r2,#100
		bmi 	pk2x
		strh 	r2,[r0]
		ldrh 	r1,[r0,#3]
		add 	r1,#1
		strb 	r1,[r0,#3]
		b 		pk2
		
pk2x	lsl		r5,r1,4
		strb 	r5,[r0,#3]

pk2y	ldrh 	r2,[r0]
		subs 	r2,#10  		;dezena
		bmi 	pk4
		
		strh 	r2,[r0]
		ldrh 	r1,[r0,#3]
		add 	r1,#1
		orr		r1,r5
		strb	r1,[r0,#3]
		b 		pk2y
		
pk4		ldrb 	r2,[r0]			;unidade
		strb 	r2,[r0,#4]
		b 		pki
		end