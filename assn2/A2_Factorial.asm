;
; CSc 230 Assignment 2 Part 2 Programming
; Question 2  Factorial
;  
; YOUR NAME GOES HERE: Kevin San Gabriel 
;	Date: February 4, 2017
;
.include "m2560def.inc"
; This program . . . (edit this line)
;
; Where:
;
;   (result) . . . (edit this line)  
;
.cseg

;  Obtain the constant from location init
	ldi zH, High(init<<1)
	ldi zL, low(init<<1)
	lpm r16, Z

;***
; YOUR CODE GOES HERE:
;
	




;Programming Problem #1:

.def word_aH = r23	;argument a
.def word_aL = r22

.def word_bH = r25	;argument b
.def word_bL = r24

;using register based parameters

.MACRO ADDWORD


	add @1, @3

	adc @2, @4


.ENDMACRO

.undef word_aH 
.undef word_aL 

.undef word_bH 
.undef word_bL




;Programming Problem #2: 


.def word_aL=r24	;word is the number we are multiplying	
.def word_aH=r25

.def byte_n=r20		;byte_n = number of times we are multiplying word by
.def temp = r21		

	;passing parameters onto the stack

	mov temp, byte_n
	push temp

	mov temp, word_aH
	push temp

	mov temp, word_aL
	push temp

	rcall Multiply

	pop temp
	pop temp
	pop temp

.undef word_aL
.undef word_aH

.undef byte_n
.undef temp 





;mulword(byte byte_n, byte word_aH, byte word_aL)
;using stack based parameters


.def word_rvH= r25	;returns value to r25:r24
.def word_rvL= r24
.def word_tempH = r19
.def word_tempL = r18

.def temp_byte = r17


Multiply:
	
	push temp_byte
	push word_tempL
	push word_tempH
	push YL
	push YH
	in YL, SPL
	in YH, SPH
	
	ldd word_rvL, Y+0
	ldd word_rvH, Y+1

	mov word_tempL, word_rvL
	mov word_tempH, word_rvH

	ldd temp_byte, Y+2

	lp:	
		cpi temp_byte, 0
		breq donemul
		add word_rvL, word_tempL
		adc word_rvH, word_tempH
		dec temp_byte
		rjmp lp

	donemul: 
			
		pop YL
		pop YH
		pop word_tempL
		pop word_tempH
		ret

.undef word_rvH
.undef word_rvL
.undef word_tempH
.undef word_tempL
.undef temp_byte


;Programming Problem #3:

;Factorial(byte n)
;using stack based parameters


.def nH = r25
.def nL = r24
.def n = r17
.def temp = r20

	mov temp, nL
	push temp

	mov temp, nH
	push temp

	rcall Factorial

	pop temp 
	pop temp


Factorial:
	
	push YL
	push YH
	in YL, SPL
	in YH, SPH
		
	

	ret 


.undef nH 
.undef nL 
.undef n 
.undef temp 

	

		



		






	
	

	


	

	

	






; YOUR CODE FINISHES HERE
;****

done:	jmp done

; The constant, named init, holds the starting number.  
init:	.db 0x03, 0x00

; This is in the data segment (ie. SRAM)
; The first real memory location in SRAM starts at location 0x200 on
; the ATMega 2560 processor.  
;
.dseg
.org 0x200

result:	.byte 2

