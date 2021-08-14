;Ex_12.3a uso adc
			export 	__main
;--- cfg rcc
rcc_cfgr 	equ &40021004
rcc_apb2enr equ &40021018
;---regs. adc1
adc_sr 		equ &40012400
adc_cr1 	equ &40012404
adc_cr2 	equ &40012408
adc_smpr1 	equ &4001240C
adc_smpr2 	equ &40012410
adc_sqr1 	equ &4001242C
adc_sqr2 	equ &40012430
adc_sqr3 	equ &40012434
adc_dr 		equ &4001244C
;---regs. portB
gpiob_crl 	equ &40010C00
;---dados - area (sram)
			area 	dd_0, data, readwrite
potv 		space 	2
;---dir. area-progr. (flash)
			area 	m_prg, code, readonly
__main
pk0 		ldr r0,=rcc_cfgr ;clk ADC(/8)- fad=1MHz

			ldr r1,[r0] ;lê rcc_cfgr
			orr r1,r1,#&c00 ;bit b15b14=11(ADC)
			str r1,[r0] ;salva rcc_cfgr
;---en.clk->adc, PB
			ldr r1,[r0,#&14];lê apb2enr-en.clk
			orr r1,r1,#&208 ;b9=b3=1(ADC,PB)
			str r1,[r0,#&14];salva apb1enr
;---cfg/ci PB1 input analog
			mov r3,#&ffbf
			movt r3,#&ffff
			ldr r0,=gpiob_crl;cfg portc PB1
			ldr r1,[r0] ;
			and r1,r3 ;PB1 input analogue
			str r1,[r0]
;---dados pointer
			ldr r2,=potv
;---adc cfg - ligar adc
			ldr r0,=adc_sr ;
			ldr r1,[r0,#&8] ;ler adc_cr2
			orr r1,#&1 ;adon=1(power-up)
			str r1,[r0,#&8] ;escr adc_cr2
;---adc tempo establz.
			mov r1,#2;~1us
px1 		subs r1,#1
			bne px1
;---adc ch9
			ldr r1,[r0,#&34] ;ler adc_sqr3
			orr r1,#&9 ;ch=9(PB1)
			str r1,[r0,#&34] ;escr adc_sqr3
;---iniciar conv
pk2 		ldr r1,[r0,#&8] ;ler adc_cr2
			orr r1,#&1 ;adon=1-inic.conv.
			str r1,[r0,#&8] ;escr adc_cr2
;---flag EOC? ler adc_sr(EOC)-RECENSEAMENTO!
pk1 		ldrh r3,[r0];ler adc_sr(eoc)
			ands r3,r3,#&2 ;pres. eoc
			beq pk1 ;eoc=0?
;---zerar eoc
; eor r3,#&2 ;
; str r3,[r0];eoc=0
;---ler valor/salvar
			ldr r4,[r0,#&4c];ler adc_dr
			strh r4,[r2]
			b pk2
			end