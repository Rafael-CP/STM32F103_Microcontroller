;========= EXERCICIO 1 ========= LSR(S)
		EXPORT 	__main
					
dist	EQU		vt2-vt1
nb		EQU		4		;num de bytes

		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	nb		
vt2		space	nb	

		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1+nb		;recebe endereço de vt1
		MOV		R1, #nb			;contador		
LOOP	LDRSB	R2,[R0,#-1]!	;carrega o conteudo de r0 em r1 (dados de vt1)
		LSL		R3,R2,#1		
		STRB	R3,[R0,#dist] 	;armazena o conteudo de r1 em r0 deslocado
		SUBS	R1,#1			;subtrai para o contador
		BNE		LOOP
		B		__main
		END