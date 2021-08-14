;Ex_13.1a - uso systick timer
;apg/acd led pc13, 0,5s 0,25s e 1s
			export 	__main
;---regs rcc
rcc_apb2enr equ 	&40021018
;---regs. portC
gpioc_crl 	equ 	&40011000
gpioc_crh 	equ 	&40011004
gpioc_idr 	equ 	&40011008
gpioc_odr 	equ 	&4001100c
;---regs SysTick
stk_ctrl 	equ 	&e000e010
stk_load 	equ 	&e000e014
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
			mov r1,#&a11f ;499999
			movt r1,#&7
			ldr r0,=stk_ctrl ;
			str r1,[r0,#&04] ;stk_load=499999
;---cfg SysTick
;			mov r1,#&d08f ;249999
;			movt r1,#&3
;			ldr r0,=stk_ctrl ;
;			str r1,[r0,#&04] ;stk_load=249999
;---cfg SysTick
;			mov r1,#&423f ;999999
;			movt r1,#&f
;			ldr r0,=stk_ctrl ;
;			str r1,[r0,#&04] ;stk_load=999999
;---iniciar contagem
			ldr r1,[r0] ;lê stk_ctrl
			orr r1,#&1
			str r1,[r0] ;stk_ctrl(b0)=1
;---ler countflag(b16)
pk1 		ldr r1,[r0] ;ler stk_ctrl(b16)
			ands r1,r1,#&10000 ;pres.cntflg
			beq pk1 ;cntflg=0?
;---acender/apagar PC13
lg_dg 		ldr r4,[r2,#&c];ler gpioc_odr
			eor r4,#&2000
			str r4,[r2,#&c]
			b pk1
			end