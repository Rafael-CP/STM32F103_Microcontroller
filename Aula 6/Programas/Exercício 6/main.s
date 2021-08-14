;========= EXERCICIO 5 ========= VN + VN
		EXPORT 	__main
dist	EQU		g2-g1
	
		AREA 	M_DADOS, DATA,	READWRITE		
g1		SPACE	4
g2		SPACE	4
	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
pk0		LDR		R0,=g1
		MOV		R1,#4
pk1		LDRB	R2,[R0]
		AND		R3,R2,#&0F
		STRB	R3,[R0,#dist]
		ADD		R0,#1
		SUBS	R1,#1
		BNE		pk1
		B		pk0
		END