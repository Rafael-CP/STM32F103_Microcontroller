			EXPORT __main	
valor1 	EQU	0xAC 	; 1 byte (8bits) = de 0 a 255
valor2	EQU	0xACDC 	; 2 bytes(16 bits) = de 0 a ~65k
valor3 	EQU 	0xABCD	; 2 bytes(16bits) = de 0 a ~65k
valor4	EQU	0x01
	
		AREA M_PROG, CODE, READONLY
__main
		MOV 	R0, #valor1
		MOV 	R1, R0	
		MOV 	R2, #valor2
		MOV 	R3, R2
		MOVT 	R4, #valor3 ; Move para metade mais significativa 
		MOV 	R5, R4
		ADD 	R2, R0
		MOV 	R6, #valor4
		MOV 	R7, R6
		MOV 	R8, R6
		ADD 	R7, R8
		
LOOP		B	LOOP
		END