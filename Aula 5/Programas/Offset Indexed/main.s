;========EXERCICIO 1G ==========
		EXPORT __main
			
dst		EQU		vr1-vr2
	
		AREA 	M_DADOS, DATA, READWRITE
vr1		space	8
testz	dcw		&39af, &b287
textw	dcb		&a7, &3b, &c5
vr2		space	8	
	
		AREA 	M_PROGRAM, CODE, READONLY
__main
		LDR		r0,=vr2
		MOV		r1, #8
pk1		LDRSB	r2,[r0, #dst]
		STRB	r2,[r0], #1
;		ADD		r0,#1 ;NÃO É MAIS NECESSARIO
		SUBS	r1,#1
		BNE		pk1
		B		__main		
		END
		