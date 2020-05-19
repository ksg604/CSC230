.cseg	;select current segment as code
.org 0	;begin assembling at address 0

;Define symbolic names for resources used
.def count =r16
	ldi count, 0x01

lp:
	inc count
	cpi count, 0x05
	breq done
	rjmp lp

done: jmp done
