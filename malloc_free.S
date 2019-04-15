heap		fill		1000

malloc	cmp		r0, #250		;checks if the arguments is greater than 250
		movgt	r0, #0		;if greater than, put 0 in r0
		bgt		return		;if greater than, branch to return

		adr		r1, heap		;sets pointer to heap
		ldr		r2, [r1]		;loads the first 4 bytes at heap
		b		L0

pointer	add		r1, r1, r2	;adds the offset to point to the next allocation in heap
		add		r1, r1, #4	;accounts for metadata overhead
		ldr		r2, [r1]		;loads the metadata for this allocation
L0		cmp		r2, #0
		bne		pointer

		str		r0, [r1], #4	;stores metadata
		mov		r1, r0		;positions return address

return	mov		pc, lr

free		sub		r1, r0, #4	;positions r1 at metadata
		mov		r0, #0		
		str		r0, [r1]		;clears metadata
		b		return