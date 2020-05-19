;
; lab5.asm
;
.include "m2560def.inc"

;SPH, SPL etc are defined in "m2560def.inc"

	; initialize the stack pointer
.cseg
	ldi r16, 0xFF
	out SPL, r16
	ldi r16, 0x21
	out SPH, r16
		
	;call subroutine void strcpy(src, dest)
	;push 1st parameter - src address
	ldi r16, high(src << 1)
	push r16
	ldi r16, low(src <<1)
	push r16

	;push 2nd parameter - des address
	ldi r16, high(dest)
	push r16
	ldi r16, low(dest)
	push r16

	call strcpy
	pop ZL
	pop ZH
	pop r16
	pop r16

	push ZL
	push ZH

	call strlength

	pop ZH
	pop ZL

	sts length, r24

	;call subroutine int strlen(string dest)
	;return value is in r24
	;push parameter dest, note it is in register Z alreay
	;call the method
	;clear the stack and write the result to length in SRAM
	;write your code here
	

done: jmp done

strcpy:
	push r30
	push r31
	push r29
	push r28
	push r26
	push r27
	push r23
	IN YH, SPH ;SP in Y
	IN YL, SPL
	ldd ZH, Y + 14
	ldd ZL, Y + 13
	ldd XH, Y + 12
	ldd XL, Y + 11

next_char:
	lpm r23, Z+
	st X+, r23
	tst r23
	brne next_char
	pop r23
	pop r27
	pop r26
	pop r28
	pop r29
	pop r31
	pop r30
	ret
	
;One parameter - the address of the string, could be in 
;flash or SRAM (chose one). The length of the string is
;going to be stored in r24
strlength:
	;write your code here
	
	clr r24
	push r31
	push r30
	push r29
	push r28
	push r23



	IN YH, SPH
	IN YL, SPL
	ldd ZH, Y + 10	;load dest address into Z pointer
	ldd ZL, Y + 9

next_char2:	
	lpm r23, Z+	;load characters pointed to by Z into r23
	inc r24	;r24 holds the length of the string. incremented each time a char is loaded into r23
	tst r23	;if r23 is 0, then the string char is null and we have reached end of string
	brne next_char2	;if r23 =/= 0, loop
	dec r24 ;decrement r24 because we dont consider the null terminator as part of the length of a string
	pop r23
	pop r28
	pop r29
	pop r30
	pop r31
	ret



src: .db "Hello, world!", 0 ; c-string format

.dseg
.org 0x200
dest: .byte 14
length: .byte 1
