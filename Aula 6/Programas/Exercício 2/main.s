;========= EXERCICIO 1 ========= LSR(S)
		EXPORT 	__main
					
dist1	EQU		vt2-vt1
dist2	EQU		vt3-vt1
	
		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	4		
vt2		space	4	
vt3		space	4
	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1-1		;recebe endereço de vt1
		MOV		R1, #4		;contador
		
LOOP	LDRSB	R2,[R0,#1]!		;carrega o conteudo de r0 em r1 (dados de vt1)
		LSRS	R3,R2,#1
		BCS		IMP
PAR		STRB	R3,[R0,#dist1]
		B		SUBT		
IMP		STRB	R3,[R0,#dist2] 	;armazena o conteudo de r1 em r0 deslocado
SUBT	SUBS	R1,#1			;subtrai para o contador
		BNE		LOOP
		B		__main
		END
		
