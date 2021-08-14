;========EXERCICIO 1H CORRIGIDO ==========
		EXPORT __main			
dst		EQU		vr1-vr2
		AREA 	M_DADOS, DATA, READWRITE
vr1		space	3
vr2		space	3	
	
		AREA 	M_PROGRAM, CODE, READONLY
__main
		LDR		r0,=vr2			;DADOS DE ENTRADA
		MOV		r1, #3
pk0		LDRSB	r2,[r0, #dst]	;DADOS EM R0 DESLOCADOS E ARMAZENADOS EM R2 
		CMP		r2,#&50
		BHS		pk1				;SE FOR >= &50 PULA PRA PK1
		STRB	r2,[r0];,#1		;SE NÃO, REGISTRA O VALOR NA MEMORIA EM R2
		;SUB		r0,#1
		
pk1		ADD		r0,#1
		SUBS		r1,#1
		BNE		pk0
		B		__main		
		END
				