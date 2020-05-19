;
; CSc 230 Assignment 1 Part 2 Programming
; Programming Problem #1: Adding
;  
; YOUR NAME GOES HERE:  Kevin San Gabriel V00853258
;	Date: January 26, 2017
;
.include "m2560def.inc"
; This program should sum 3 numbers together: 27, 41 and 15 (all decimal).  
;
; The result should be stored in (result).
;
; Where:
;
;   (result) refers to the byte memory location where the result is stored
;
.cseg

;***
; YOUR CODE GOES HERE:
;


	ldi r19, 0	
	sts result, r19	;initialize result with value 0
	
	clr r19
	clr r16
	clr r17
	clr r18
	clr r0	;clear all registers
	
	ldi r16, 27
	ldi r17, 41
	ldi r18, 15 ;load our values to be summed up into registers

	add r0, r16
	add r0, r17
	add r0, r18	;sum is calculated in r0

	sts result, r0	;store r0 into memory location result





;
; YOUR CODE FINISHES HERE
;****

done:	jmp done

; This is in the data segment (ie. SRAM)
; The first real memory location in SRAM starts at location 0x200 on
; the ATMega 2560 processor.  Locations less than 0x200 are special
; and will be discussed later
;
.dseg
.org 0x200

result:	.byte 1

