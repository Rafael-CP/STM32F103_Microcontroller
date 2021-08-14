;---Ex_10.2a - uso timer2
			export __main
				
;--- cfg rcc
rcc_apb2enr equ &40021018
rcc_apb1enr equ &4002101C
	
;---regs. timer2
tim2_cr1 	equ &40000000
tim2_sr 	equ &40000010
tim2_arr 	equ &4000002C

;---regs. portC
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c

;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main 		ldr r0,=rcc_apb2enr ;en.clk port C
			ldr r1,[r0] ;lê apb2enr
			orr r1,r1,#&10 ;bit b4=1
			str r1,[r0] ;salva apb2enr
;---timer2
; ldr r0,=rcc_apb1enr ;en.clk TIM2
			ldr r1,[r0,#4];lê apb1enr
			orr r1,r1,#&1 ;bits b0=1
			str r1,[r0,#4];salva apb1enr
;---cfg/ci PC13 output
			ldr r2,=gpioc_crl;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 ;PC13 output op-dr
			str r3,[r2,#4]
;---ci PC13=0(valor inicial)
			mov r4,#&2000
; mov r4,#&0
			movt r4,#0
			str r4,[r2,#&c]
			mov r5,#241 ;cont.auxiliar - 121 para 1 seg 
			movt r5,#0
;timer2 cfg
			ldr r0,=tim2_cr1
			mov r3,#&ffff
			strh r3,[r0,#&2c] ;tim2_arr=&ffff
			ldrh r3,[r0] ;lê tim2_cr1
			orr r3,#1 ;b0=cen=1
			strh r3,[r0] ;inicia(liga)timer!!
;---ler uif(timer overflow)-RECENSEAMENTO!
pk1 		ldrh r3,[r0,#&10];ler [tim2_sr(uif)]
			ands r3,r3,#&1 ;pres. uif
			beq pk1 ;uif=0?
;---
			eor r3,#&1 ;
			strh r3,[r0,#&10];uif=0
			subs r5,#1
			bne pk1
			mov r5,#241 ; 121 para 1 seg
;---acender/apagar PC13
lg_dg 		ldr r4,[r2,#&c];ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]
			b 	pk1
			end