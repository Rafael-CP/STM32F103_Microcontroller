;Ex_13.2a - uso systick timer
;apg/acd;ledPC13;0,5s; interrupção
			export __main
			export __isrST
;---regs rcc
rcc_apb2enr equ &40021018
;---regs. portC
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c
;---regs SysTick
stk_ctrl 	equ &e000e010
stk_load 	equ &e000e014
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr ;en.clk port C
			ldr r1,[r0] ;lê apb2enr
			orr r1,r1,#&10 ;bit b4=1(C)
			str r1,[r0] ;salva apb2enr
;---cfg/ci PC13 output
			ldr r2,=gpioc_crl;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 ;PC13 output op-dr
			str r3,[r2,#4]
			;---ci PC13=0(valor inicial)
			mov r4,#&2000
			movt r4,#0
			str r4,[r2,#&c]
;---cfg SysTick
;			mov r1,#&a11f ;499999
;			movt r1,#&7
;			ldr r0,=stk_ctrl ;
;			str r1,[r0,#&04] ;stk_load=499999
;---cfg SysTick
			mov r1,#&eb0f ; 649 999
			movt r1,#&9
			ldr r0,=stk_ctrl ;
			str r1,[r0,#&04] ;stk_load=649999
;---iniciar contagem
			ldr r1,[r0] ;lê stk_ctrl
			orr r1,#&3 ;b1=1(int);b0=1count
			str r1,[r0] ;stk_ctrl(b0)=1!INICIA!
;---tarefa cpu (loop de tempo)
pkx 		mov r5,#&ffff
			movt r5,#&ffff
pk1 		subs r5,#1
			nop
			bne pk1
			b pkx
;rotina de serviço de interrupção(on/off PC13)
__isrST 	ldr r4,[r2,#&c];ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]
			bx lr ;importante!!
			end