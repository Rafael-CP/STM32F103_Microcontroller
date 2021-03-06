;Ex_11.2a uso timer2/output compare
;sa?da compara??o - desabilitada
			export __main
;--- cfg rcc
rcc_apb2enr equ &40021018
rcc_apb1enr equ &4002101C
	
;---regs. timer2
tim2_cr1 	equ &40000000
tim2_sr 	equ &40000010
tim2_psc 	equ &40000028
tim2_arr	equ &4000002C
tim2_ccr4 	equ &40000040 ; OUTPUT COMPARE 4
	
;---regs. portC
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c
	
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr ;en.clk port C
			ldr r1,[r0] ;l? apb2enr
			orr r1,r1,#&10 ;bit b4=1
			str r1,[r0] ;salva apb2enr
			
;---timer2
			ldr r1,[r0,#4];l? apb1enr
			orr r1,r1,#&1 ;bits b0=1
			str r1,[r0,#4];salva apb1enr
			
;---cfg/ci PC13 output
			ldr r2,=gpioc_crl;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 ;PC13 output op-dr
			str r3,[r2,#4]
			
;---ci PC13=0(valor inicial)
			mov r4,#&2000
			movt r4,#0
			
;timer2 cfg
			; arr * T = 0.35 
			; Escolhendo arbitrariamente um arr de 7k, encontra-se um T de 50us, logo f = 20kHz.
			; Queremos 0.35 segundos. Para isso, sera contado at? 7.000 com periodos de 50us (7k*50u = 0.35s)
			ldr r0,=tim2_cr1
			mov r3,#6999
			strh r3,[r0,#&2c] 	;tim2_arr=6999
			mov r3,#399			;Prescaler agora sera 399, dividindo a frequencia de 8 MHz em 400
			str r3,[r0,#&28] 	;tim_psc=399(fsys/400) Agora possui uma frequencia de 20kHz e um periodo de 50us
			
			mov r3,#2000		; move valor 2000 para registro de comparacao 4
			strh r3,[r0,#&40] 	;tim2_ccr4=2000
			
			ldrh r3,[r0] 		;l? tim2_cr4
			orr r3,#1 		;b0=cen=1
			strh r3,[r0] 		;inicia(liga)timer!!
			
;---ler cc1if(compare=cnt)-RECENSEAMENTO!
pk1 		ldrh r3,[r0,#&10]	;ler [tim2_sr(cc1if)] = Lendo registro de status no bit que indica igualdade na contagem e no registro ccr
			ands r3,r3,#&2 		;pres.cc1if
			beq pk1 			;cc1if=0?
;---
			eor r3,#&2 ;
			strh r3,[r0,#&10]	;cc1if=0
			
;---acender/apagar PC13
lg_dg 		ldr r4,[r2,#&c]		;ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]
			b pk1
			end