		EXPORT __main
			
		AREA 	M_DADOS1, DATA, READONLY; READONLY = JA ESCREVE NA MEMORIA AUTOMATICAMENTE /// READWRITE = DADOS NA MEMORIA MANUALMENTE
m		SPACE	4
n 		SPACE	4	
moodle	DCD		0xfc39de72
	
		AREA 	M_DADOS2, DATA, READWRITE		
mn1		SPACE	1 ; ESTE BYTE IRA SERVIR PARA SINALIZAR O VALOR COMO POSITIVO OU NEGATIVO
mn2		SPACE	4	
	
		AREA 	M_PROG, CODE, READONLY
__main
		ldr  	r0,=moodle
		ldrsb  	r1,[r0]    ;(1)
		movs   	r2,r1      ;(2)
		add   	r1,r1      ;(3)


;		LDR		r0,=m
;		LDR		r1,=n
;LOOP	LDR		r2,=mn2
;		LDR		r3,[r0]
;		LDR		r4,[r1]
;		SUBS	r5,r3,r4
;		STR		r5,[r2]
;		MOV		r6,#0
;		SBC		r6,#0
;		LDR		r2,=mn1
;		STRB	r6,[r2]
LOOP	B		LOOP
		END