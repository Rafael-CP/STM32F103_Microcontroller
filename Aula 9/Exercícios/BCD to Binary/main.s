;Ex_9.1a - bcd (3 alg.n-cptd) to bin
		export 	__main
;---diret. area-dados (sram)sram
		area 	dds1, data, readwrite
cent 	space 	1
dez 	space 	1
unid 	space 	1
nbin 	space 	1
;---diret area-prog (flash)
		area mprg, code, readonly
__main
		ldr 	r0,=cent
pki 	mov 	r1,#0 ;nbin=0
pk0 	ldrb 	r2,[r0] ;r2=cent
		ands 	r2,r2,#&0f ;pres.nibbleLSB
		beq 	pk1
		sub 	r2,r2,#1
		strb 	r2,[r0]
		add 	r1,r1,#100
		b 		pk0
		
pk1 	ldrb 	r2,[r0,#1]
		ands 	r2,r2,#&0f
		beq 	pk2
		sub 	r2,r2,#1
		strb 	r2,[r0,#1]
		add 	r1,r1,#10
		b 		pk1
		
pk2 	ldrb 	r2,[r0,#2]
		and 	r2,r2,#&0f
		add 	r1,r2
		strb 	r1,[r0,#3]
		b 		pki
		end