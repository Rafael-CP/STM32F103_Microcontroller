;---Ex_8.3a - pass.par. regs./reference EXTRA
		export 	__main 
;---diret. area dados
		area 	dds1, data, readwrite
va1		space	1
va2		space	1
vr1		space	2
;---diret. area - progr.
		area 	mprg, code, readonly
__main
pkg 	ldr 	r0,=va1
		ldr		r1,=va2
		ldr		r2,=vr1
		ldrb	r3,[r0]
		ldrb	r4,[r1]
		mul		r2,r3,r4	; resultado da multiplicaçao em r2
		cmp		r2,#0		; compara com 0
		bne		subrot		; se diferente de zero, segue branch
		b		pkg			; caso contrario, reinicia programa
		
subrot	bl		temp		
		b		pkg

;---sub-rotina (temporizador)
temp 	push 	{r1-r3}		;50us = 400 ciclos por unidade de vr1
		ldr		r1,[r2]
		ldr		r3,=400
loop	subs	r1,r3		
		bne		loop
		pop 	{r1-r3}
		bx 		r14
;---
		end