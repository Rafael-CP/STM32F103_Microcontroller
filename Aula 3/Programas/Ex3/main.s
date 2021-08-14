;==========EXERCICIO 3.2============
		EXPORT 	__main
;===================================			
		AREA 	DADOS, DATA, READONLY ;TROCANDO O READWRITE PARA QUE NAO SEJA PRECISO ESCREVER OS DADOS NA RAM MANUALMENTE
ct1		dcb		&33, &77
ct2		dcb		&aa, &80
ct3		dcb		&32, &ac
ct4		dcb		&3A, &6c
;===================================
		AREA	PROGRAMA, CODE, READONLY
__main
pk0		LDR		r0,=ct1
		LDRSH	r1,[r0]
		NOP
		LDR		r0,=ct2
		LDRSH	r2,[r0]
		NOP
		LDR		r0,=ct3
		LDRSH	r3,[r0]
		NOP
		LDR		r0,=ct4
		LDRSH	r4,[r0]
		NOP
LOOP	B	LOOP
		END