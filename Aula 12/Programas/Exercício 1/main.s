;Ex_12.1a uso timer2/output compare
;saída comparação-habilitada
			export __main
;--- cfg rcc
rcc_apb2enr	equ &40021018
rcc_apb1enr equ &4002101C
;---regs. timer2
tim2_cr1 	equ &40000000
tim2_sr 	equ &40000010
tim2_ccmr1 	equ &40000018
tim2_ccer1 	equ &40000020
tim2_psc 	equ &40000028
tim2_arr 	equ &4000002C
tim2_ccr1 	equ &40000034
;---regs. portA
gpioa_crl 	equ &40010800
;---regs. portC
gpioc_crl 	equ &40011000
gpioc_crh 	equ &40011004
gpioc_idr 	equ &40011008
gpioc_odr 	equ &4001100c
;---dir. area-progr. (flash)
			area m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_apb2enr ;en.clk port A,C
			ldr r1,[r0] ;lê apb2enr
			orr r1,r1,#&14 ;bit b4=b2=1(C,A)
			str r1,[r0] ;salva apb2enr
;---timer2 enable clk
			ldr r1,[r0,#4];lê apb1enr
			orr r1,r1,#&1 ;bit b0=1
			str r1,[r0,#4];salva apb1enr
;---cfg/ci PC13 output
			ldr r2,=gpioc_crl;cfg portc PC13
			ldr r3,[r2,#4] ;
			orr r3,#&200000 ;PC13 output op-dr
			str r3,[r2,#4]
;---ci PC13=0(valor inicial)
			mov r4,#&2000
			movt r4,#0
			str r4,[r2,#&c]
;---cfg PA0
			ldr r0,=gpioa_crl ;cfg.portA,PA0
			ldr r3,[r0] ;altenate function
			eor r3,r3,#&e ;OC;p-p(PA0)
			str r3,[r0]
;timer2 cfg
			ldr r0,=tim2_cr1
			mov r3,#49999
			strh r3,[r0,#&2c] ;arr=49999
;---
			mov r3,#79
			str r3,[r0,#&28] ;psc=79(fsys/80)
;---
			mov r3,#2000
			strh r3,[r0,#&34] ;ccr1=2000
;---
			ldrh r3,[r0,#&18] ;lê ccmr1
			orr r3,#&30 ;toggle qdo igual
			strh r3,[r0,#&18] ;ccmr1=&0030
;---
			ldrh r3,[r0,#&20] ;lê ccer
			orr r3,#&01 ;enable OC1
			strh r3,[r0,#&20] ;ccer=&1
;---
			ldr r3,[r0]
			orr r3,#1 ;b0=cen=1
			strh r3,[r0] ;inicia(liga)timer!!
;---ler cc1if(timer OC flag)-RECENSEAMENTO! => SERVE APENAS PARA PISCAR O LED DE PC13, ENQUANTO PA0 PISCA DEPENDENDO DO CONTADOR
pk1 		ldrh r3,[r0,#&10];ler [tim2_sr(cc1if)]
			ands r3,r3,#&2 ;pres.cc1if
			beq pk1 ;cc1if=0?
;---zerar cc1if
			eor r3,#&2 ;
			strh r3,[r0,#&10];cc1if=0
;---acender/apagar PC13
lg_dg 		ldr r4,[r2,#&c];ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]
			b pk1
			end
			