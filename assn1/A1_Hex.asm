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
	ldi xL, low(0x200)	;load 0x200 into x pointer register
						;x will act as the value for memory
						;locations in our data memory


loop: 
		

	st x+, r16		;store r16 into our starting memory location 0x200
	dec r16			;decrement r16


	;adiw xH:xL, 8	;add 8 to our x pointer register
					;so we can move to consecutive
					;memory locations in our data memory


	cpi r16, 0		;compared r16 to 0
	brlt done		;if r16 is less than 0, we're done


	rjmp loop		;otherwise jump back to loop
					;and keep storing decrementing
					;values of r16 into consecutive
					;memory locations.


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

