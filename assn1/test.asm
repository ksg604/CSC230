;
; CSc 230 Assignment 1 Part 2 Programming
; Question 2  Hexadecimal Numbers
;  
; YOUR NAME GOES HERE:	Kevin San Gabriel  V00853258	  
;	Date: January 27, 2017
;
.include "m2560def.inc"
; This program writes hexadecimal numbers from a program specified constant (maximum 0x4f) downto
;   0 into consecutive data segment memory locations,  
;
; Where:
;
;   (result) The first number is stored in result and the remainder are in consecutive locations. 
;
.cseg

;  Obtain the constant from location init
	ldi zH, High(init<<1)
	ldi zL, low(init<<1)
	lpm r16, Z

;***
; YOUR CODE GOES HERE:
;


	ldi xH, high(0x200)
	ldi xL, low(0x200)
loop: 
		

	st x, r16
	dec r16

	adiw xH:xL, 8

	cpi r16, 0
	brlt done

	rjmp loop


; YOUR CODE FINISHES HERE
;****

done:	jmp done

; The constant, named init, holds the starting number.  It is in the program memory area,
;   rather than the data segment, which is suitable for program constants.  
; Program memory must be specified in words (2 bytes) which
; is why there is a 2nd byte (0x00) at the end.
init:	.db 0x4f, 0x00

; This is in the data segment (ie. SRAM)
; The first real memory location in SRAM starts at location 0x200 on
; the ATMega 2560 processor.  
;
.dseg
.org 0x200

result:	.byte 0x50

