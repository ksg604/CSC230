#define LCD_LIBONLY
.include "lcd.asm"
.include "m2560def.inc"

;SPH, SPL etc are defined in "m2560def.inc"


.cseg

	call lcd_init
	call lcd_clr
	call init_strings
	call reverse_lines

;This loop is unfinished for now, need to implement subroutines to make this shorter.
loop_3:

	;Set row counter to 0 col counter to 0
	push r16
	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	;Display line 1
	ldi r16, high(line1)
	push r16
	ldi r16, low(line1)
	push r16
	call lcd_puts
	pop r16
	pop r16
	
	;Set row counter to 1 col counter to 0
	push r16
	ldi r16, 0x01
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
	
	;Display line 2
	ldi r16, high(line2)
	push r16
	ldi r16, low(line2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;Delay for 1 second and then clear the screen
	call delay
	call lcd_clr

	;Set row counter to 0, col counter to 1
	push r16
	ldi r16, 0x00
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
	
	;Display line 2
	ldi r16, high(line2)
	push r16
	ldi r16, low(line2)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;Set row counter to 1, col counter to 1
	push r16
	ldi r16, 0x01
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	;Display line 3
	ldi r16, high(line3)
	push r16
	ldi r16, low(line3)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;Delay for 1 second and clear the screen
	call delay
	call lcd_clr
	
	;Set row counter to 0, col counter to 0
	push r16
	ldi r16, 0x00
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16
	
	;Display line 3
	ldi r16, high(line3)
	push r16
	ldi r16, low(line3)
	push r16
	call lcd_puts
	pop r16
	pop r16
	
	;Set row counter to 1, col counter to 0
	push r16
	ldi r16, 0x01
	push r16
	ldi r16, 0x00
	push r16
	call lcd_gotoxy
	pop r16
	pop r16


	;Display line 4
	ldi r16, high(line4)
	push r16
	ldi r16, low(line4)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;Delay for 1 second, clear the screen
	call delay
	call lcd_clr
	
	;Set row counter to 0, col counter to 1
	push r16
	ldi r16, 0x00
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	;Display line 4
	ldi r16, high(line4)
	push r16
	ldi r16, low(line4)
	push r16
	call lcd_puts
	pop r16
	pop r16

	;Set row counter to 1, col counter to 1
	push r16
	ldi r16, 0x01
	push r16
	ldi r16, 0x01
	push r16
	call lcd_gotoxy
	pop r16
	pop r16

	;Display line 1
	ldi r16, high(line1)
	push r16
	ldi r16, low(line1)
	push r16
	call lcd_puts
	pop r16
	pop r16
	
	;Delay for 2 seconds
	call delay
	call delay

display_line1:

	ldi r16, high(line1)
	push r16
	ldi r16, low(line1)
	push r16
	call lcd_puts
	pop r16
	pop r16
	ret

display_line2:
	ldi r16, high(line2)
	push r16
	ldi r16, low(line2)
	push r16
	call lcd_puts
	pop r16
	pop r16
	ret

;Copy strings from program memory into data memory
init_strings:

	push r16
	ldi r16, high(line1)
	push r16
	ldi r16, low(line1)
	push r16
	ldi r16, high(msg1_p << 1)
	push r16
	ldi r16, low(msg1_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

		
	ldi r16, high(line2)
	push r16
	ldi r16, low(line2)
	push r16
	ldi r16, high(msg2_p << 1)
	push r16
	ldi r16, low(msg2_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	ldi r16, high(line5)
	push r16
	ldi r16, low(line5)
	push r16
	ldi r16, high(msg3_p << 1)
	push r16
	ldi r16, low(msg3_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16

	ldi r16, high(line6)
	push r16
	ldi r16, low(line6)
	push r16
	ldi r16, high(msg4_p << 1)
	push r16
	ldi r16, low(msg4_p << 1)
	push r16
	call str_init
	pop r16
	pop r16
	pop r16
	pop r16
	
	pop r16

	ret
	

;This subroutine will reverse lines 1 and 2 and copy them into lines 3 and 4 respectively
reverse_lines:

	;Save registers
	push r23
	push ZH
	push ZL
	push XH
	push XL
	
	;Push the null terminator for each string
	ldi r23, 0
	push r23
	
	;Load Z-pointer with address of line1
	ldi ZH, high(line1)
	ldi ZL, low(line1)

	;Load Z-pointer with address of line3
	ldi XH, high(line3)
	ldi XL, low(line3)
	
	;Go through line1 and load each character into r23
	;Test if the character is the null terminator each iteration
	;Push each character into r23
	;If the character loaded into r23 is the null terminator, end loop
	next_char:
		ld r23, Z+
		tst r23
		push r23
		brne next_char

	;Pop the null terminator off because it was pushed into the stack
	;in the last iteration of next_char
	pop r23

	;Pop characters off the stack into r23 and store into line 3
	;As items are popped off, they will be appended onto line3
	;in reverse.
	;
	load2dest:
		pop r23
		st X+, r23
		tst r23
		brne load2dest


	;REPEAT THE PROCESS FOR REVERSING LINE2
	ldi r23, 0
	push r23

	ldi ZH, high(line2)
	ldi ZL, low(line2)

	ldi XH, high(line4)
	ldi XL, low(line4)

	next_char2:
		ld r23, Z+
		tst r23
		push r23
		brne next_char2

	pop r23

	load2dest2:
		pop r23
		st X+, r23
		tst r23
		brne load2dest2


	;Clear the stack
	pop XL
	pop XH
	pop ZL
	pop ZH
	pop r23
ret

;Delay for one second
delay:	
		;Save these registers
		push r20
		push r21
		push r22
		
		;Do some operations to delay for one second
		ldi r20, 0x40
del1_2:	nop
		ldi r21,0xFF
del2_2:	nop
		ldi r22, 0xFF
del3_2:	nop
		dec r22
		brne del3_2
		dec r21
		brne del2_2
		dec r20
		brne del1_2
		
		;Clear stack
		pop r22
		pop r21
		pop r20
ret


; sample strings
; These are in program memory

msg1_p: .db "Kevin San Gabriel", 0
msg2_p: .db "UVIC: Computer Sci", 0
msg3_p: .db "******************"
msg4_p: .db ".................."
.dseg

;
; The program copies the strings from program memory
; into data memory.
;

msg1: .byte 200
msg2: .byte 200


; These strings contain the 18 characters to be displayed on the LCD
; Each time through, the 18 characters are copied into these memory locations

line1: .byte 19
line2: .byte 19
line3: .byte 19 ;Reverse of line 1
line4: .byte 19 ;Reverse of line 2
line5: .byte 19 ;Asterisks, msg3_p will be copied into here
line6: .byte 19 ;Periods, msg4_p will be copied into here
