.cseg	
.org 0

;Student Name: Kevin San Gabriel
;Student ID  : V00853258
 

;Checks if r18 is even or odd.  If r18 is even, r19 will be 0x01.  
;If r18 is odd, r19 will be 0x00.  For our purposes, r18 will be initialized as 0x09.


	ldi		r18, 0x09	;set r18 to 0x09
	ldi		r19, 0x00	;set r19 to 0x00

	andi	r18, 0x01	;Mask r18 with an AND and set every bit
						;except the least significant to 0. (r18 will be 0x00 or 0x01)

	cpi		r18, 0x00	;Compare r18 with 0x00
	brne 	done		;If r18 is not equal to 0x00 (it is odd) 
						;then r19 will remain 0x00 (branches to done)

	ldi		r19, 0x01	;If r18 is equal to 0x00, set r19 to 0x01


done: jmp done
