;========= EXERCICIO 1 ========= ASR
		EXPORT 	__main
					
dist	EQU		vt2-vt1

		AREA 	M_DADOS, DATA,	READWRITE		
vt1		space	4		
vt2		space	4	
	
		AREA 	M_PROGRAMA, CODE, READONLY
__main	
		LDR		R0,=vt1-1		;recebe endereço de vt1
		MOV		R1, #4		;contador
		
LOOP	LDRSB	R2,[R0,#1]!		;carrega o conteudo de r0 em r1 (dados de vt1)
		ASR		R3,R2,#1
		STRB	R3,[R0,#dist] ;armazena o conteudo de r1 em r0 deslocado de 16 espaços
		SUBS	R1,#1		;subtrai para o contador
		BNE		LOOP
		B		__main
		END
		
