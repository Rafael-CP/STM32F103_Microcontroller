;=======EXERCICIO 1.2==============
		EXPORT 	__main
;==================================			
		AREA 	DADOS, DATA, READONLY ;TROCANDO O READWRITE PARA QUE NAO SEJA PRECISO ESCREVER OS DADOS NA RAM MANUALMENTE
ct1		DCB		&33, &aa
ct2		DCB		&77, &ab		
ct3		DCB		&99, &9c
ct4		DCB		&bb, &f5
		AREA	PROGRAMA, CODE, READONLY
__main
pk0		LDR		r0,=ct1
		NOP
		LDRH	r1,[r0]
		NOP	
		LDR		r0,=ct2
		NOP
		LDRH	r2,[r0]
		NOP
		LDR		r0,=ct3
		NOP
		LDRH	r3,[r0]
		NOP
		LDR		r0,=ct4
		NOP
		LDRH	r4,[r0]
LOOP	B	LOOP
		END