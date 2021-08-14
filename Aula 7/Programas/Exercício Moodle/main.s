;---Ex-1a - multiply instructions 16x16 bits
		export __main
;---directive area-programa
		area m_prog, code, readonly
__main
		movw 	r0,#&FFFF ;r0=&ffff
		movt	r0,#&8FFF
		movw 	r1,#&1 ;r1=&abcd
		muls 	r1,r0,r1 ;R2=r0*r1=&fffe0001
		movw 	r3,#0 ;r3=65536
		movt 	r3,#1 ;r3=&10000
		movw 	r4,#65535 ;r4=&ffff
		mul 	r5,r3,r4 ;R5=&ffff0000
		mov 	r6,r3 ;r6=r3=&10000
		mov 	r7,r3 ;r7=r3=&10000
		mul 	r8,r6,r7 ;r8=&00000000
pk0 	b 		pk0
		end
		