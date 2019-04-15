result	fill		200
		
main		sub		sp, sp, #8
		movs		r3, #0
		str		r3, [sp, #4]
		b		L2
		
L5		movs		r3, #0
		str		r3, [sp]
		b		L3
		
L4		ldr		r3, [sp, #4]
		ldr		r2, [sp]
		;mul		r3, r2, r3
		MOV		r8, r2
		MOV		r9, r3
		BL		mul
		MOV		r3, r10
		lsls		r1, r3, #1
		adr		r0, result
		ldr		r2, [sp, #4]
		mov		r3, r2
		lsls		r3, r3, #2
		add		r3, r3, r2
		ldr		r2, [sp]
		add		r3, r3, r2
		str		r1, [r0, r3, lsl #2]
		ldr		r3, [sp]
		adds		r3, r3, #1
		str		r3, [sp]
		
L3		ldr		r3, [sp]
		cmp		r3, #4
		ble		L4
		ldr		r3, [sp, #4]
		adds		r3, r3, #1
		str		r3, [sp, #4]
		
L2		ldr		r3, [sp, #4]
		cmp		r3, #9
		ble		L5
		movs		r3, #0
		mov		r0, r3
		add		sp, sp, #8
		end
		
		;Multiply	uses	r8 for operand 1, r9 for operand 2, r10 for result
mul		MOV		r10, #0		;initialize result register
		
loop		LSRS		r9, r9, #1	;shifts r9 (b) right 1, writes that back to r9, and sets the status flags
		ADDCS	r10, r10, r8	;if the carry bit is set, add r8 to r10
		LSL		r8, r8, #1	;update r8 (a) by shifting it left 1
		CMP		r9, #0
		BNE		loop			;branch back to loop if r9 is not 0
		
		MOV		pc, lr		;returns
