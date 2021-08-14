;Ex_11.1a uso timer2/prescaler
			export 	__main
cnt_x 		equ 	10
;--- cfg rcc
rcc_apb2enr equ 	&40021018 	; Configuracao dos registros 
rcc_apb1enr equ 	&4002101C ;
;---regs. timer2
tim2_cr1 	equ 	&40000000 ; 
tim2_sr 	equ 	&40000010 ; 
tim2_psc 	equ 	&40000028 ; 
tim2_arr 	equ 	&4000002C ; 
;---regs. portC
gpioc_crl 	equ 	&40011000
gpioc_crh 	equ 	&40011004
gpioc_idr 	equ 	&40011008
gpioc_odr 	equ 	&4001100c
;---dir. area-progr. (flash)
		area m_prg, code, readonly
__main
pk0 	ldr r0,=rcc_apb2enr 	;en.clk port C = Carrega r0 com APB2 para habilitar clock na porta C 
		ldr r1,[r0] 			;l� apb2enr
		orr r1,r1,#&10 			;bit b4=1 = Colocando o 1 no bit 4 em apb2, o clock para C � habilitado
		str r1,[r0] 			;salva apb2enr = Substitui o valor antigo com valor de clock habilitado
		
		;---timer2 - en.clk TIM2
		ldr r1,[r0,#4]			;l� apb2enr = R0, que aponta para apb2, e sua distancia para apb1 � de 4
		orr r1,r1,#&1 			;bits b0=1 = Agora o bit 0 precisa ter valor 1
		str r1,[r0,#4]			;salva apb1enr
		
		;---cfg/ci PC13 output
		ldr r2,=gpioc_crl		; cfg portc PC13
		ldr r3,[r2,#4] ;		; = Precisamos acessar crh, pois nele se encontra o bit 13 (CNF 13) da porta C
		orr r3,#&200000 		; Coloca 1 no bit 22 (CNF3) de crh fazendo com que PC13 seja output op-dr = Operacao de OU para ajustar a porta como open drain
		str r3,[r2,#4]			; Atualiza o valor no local lido
		
		;---ci PC13=0(valor inicial) = Como PC13 foi definido como sa�da, � necessario estabelecer um valor 
		mov r4,#&2000
		movt r4,#0
		str r4,[r2,#&c]			; = Coloca valor em gpioc_odr (Registro de saida de dados da porta C)
		mov r5,#cnt_x 			;cont.auxiliar
		
		;timer2 cfg = Configuracao do sistema de temporizacao
		; Regra de 3 => 1us = 1unidade (A cada clock de 1us, conta-se uma unidade) ; 0.5s = x => Encontra-se um valor de 500.000
		; Portanto, para 0.5 segundos, o overflow de 50k deve acontecer 10 vezes (Por isso cont_x � 10)
		ldr r0,=tim2_cr1 		; Ler endereco dos registros de Timer 2		
		mov r3,#49999		
		strh r3,[r0,#&2c] 		;tim2_arr=49999 = Coloca no registro de recarga o valor 49999 
		mov r3,#&7				;Divide a frequencia em 8, fazendo com que o clock opere com 1Mhz		
		strh r3,[r0,#&28] 		;tim_psc=&7 = Alteracao no registro de prescaler 

		ldrh r3,[r0] 			;l� tim2_cr1 = Controle do temporizador 
		orr r3,#1 				;b0=cen=1 = Coloca 1 no bit 0
		strh r3,[r0] 			;inicia(liga)timer!! = Coloca 1 em r0, iniciando contagem
		
		;---ler uif(timer overflow)-RECENSEAMENTO! = Calculamos quantos overflows serao necessarios para se atingir 0.5 segundos
pk1 	ldrh r3,[r0,#&10]		;ler [tim2_sr(uif)] = L� registro de status
		ands r3,r3,#&1 			;pres. uif = � o bit que indica a presenca de overflow
		beq 	pk1 			;uif=0? = Enquanto 0, o contador ainda nao teve overflow (Recenseamento = monitora o bit uif)
		;---
		eor r3,#&1 ;			; Quando ocorre o overflow, bit que foi para 1 deve voltar a ser 0 
		strh r3,[r0,#&10]		; uif=0 = Retorna ao registro original
		subs r5,#1				; Contador � subtraido por 1
		bne 	pk1				; 10 overflows para se ter 0.5 segundos
		mov r5,#cnt_x 	 		; Reseta contador
		
		;---acender/apagar PC13
lg_dg 	ldr r4,[r2,#&c]			; ler gpioc_odr = Registro de saida
		eor r4,#&2000			; Muda estado do bit
		str r4,[r2,#&c]			; Atualiza seu conteudo
		b 	pk1
		end