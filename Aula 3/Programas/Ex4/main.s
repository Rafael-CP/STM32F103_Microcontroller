		EXPORT 	__main
;===================================	
		AREA	PROGRAMA, CODE, READONLY
__main
pk0		MOV		r0, #&aa
		NOP
pk1		B		pk2
teste		MOV		r2, #&CD	;nunca serao executados
		NOP			
		NOP			
pk2		MOV		r1, #&ee
pk3 		B		pk0

		END