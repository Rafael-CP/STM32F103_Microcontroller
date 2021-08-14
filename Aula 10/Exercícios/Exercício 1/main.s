;;---uso portas E/S
			export __main
				
;--- cfg ports
rcc_apb2enr equ &40021018
	
;---regs. portB
gpiob_crl 	equ &40010c00
gpiob_crh 	equ &40010c04
gpiob_idr 	equ &40010c08
gpiob_odr 	equ &40010c0c
	
;---regs. portC
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c
	
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr 	;en.clk ports B,C
			ldr r1,[r0] 			;lê apb2enr
			orr r1,r1,#&18 			;bits b4:b3=11
			str r1,[r0] 			;salva apb2enr
			
;---cfg PB12 input
			ldr r0,=gpiob_crl		;cfg portc PB12
			ldr r1,[r0,#4] ;
			orr r1,#&40000 			;PB12 input floating
			str r1,[r0]
			
;---cfg PC13 output
			ldr r2,=gpioc_crl		;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 		;PC13 output op-dr
			str r3,[r2,#4]
			
;---ler sw1
pk1 		ldr r1,[r0,#8]			;ler PB12
			ands r1,r1,#&1000 		;pres. PB12
			beq apaga
			
;---acender/apagar PC13			
acende 		mov r3,#0
			movt r3,#0
			str r3,[r2,#&c]
			b	pk1
			
apaga		mov r3,#&2000
			movt r3,#0
			str r3,[r2,#&c]
			b pk1
			;---
			end