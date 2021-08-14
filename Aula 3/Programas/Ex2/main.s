;==========EXERICIO 2.2=============
		EXPORT 	__main
;===================================			
		AREA 	DADOS, DATA, READONLY ;TROCANDO O READWRITE PARA QUE NAO SEJA PRECISO ESCREVER OS DADOS NA RAM MANUALMENTE
ct1		DCB		&99, &59
ct2		DCB		&BB, &AA
ct3		DCB		&DD, &EF
ct4		DCB		&FF, &84
		AREA 	DADOS2, DATA, READWRITE 
mem1	space	1
mem2	space	2
mem3	space	4
;==================================
		AREA	PROGRAMA, CODE, READONLY
__main
pk0		LDR		r0,=ct1
		LDRH	r1,[r0]
		LDR		r0,=ct2
		LDRH	r2,[r0]
		LDR		r0,=ct3
		LDRH	r3,[r0]
		LDR		r0,=ct4
		LDRH	r4,[r0]
		LDR		r5,=mem1
		STRH	r1,[r5]
		LDR 	r5,=mem2
		STRH	r2,[r5]
		LDR		r5,=mem3
		STRH	r3,[r5]
LOOP	B	LOOP
		END