#define LCD_LIBONLY
.include "lcd.asm"
.include "m2560def.inc"

;SPH, SPL etc are defined in "m2560def.inc"

.cseg

; initialize the Analog to Digital conversion (from lab 4)

	ldi r16, 0x87
	sts ADCSRA, r16
	ldi r16, 0x40
	sts ADMUX, r16


; Macros with arguments will reduce the amount of repetitive code we need to write for the loops.
.MACRO set_counters
	
	ldi r16, @1
	push r16
	ldi r16, @0
	push r16
	call lcd_gotoxy

.ENDMACRO

.MACRO display_line

	
	push r16
	ldi r16, high(@0)
	push r16
	ldi r16, low(@0)
	push r16
	call lcd_puts
	pop r16



.ENDMACRO

	call lcd_init
	call lcd_clr
	call init_strings
	call reverse_lines

	;r18 will keep track of the amount of times loop_3 loops.
	ldi r18, 3

loop_3:	
	

	;Set row counter to 0 col counter to 0
	set_counters 0,0

	;Display line 1
	display_line line1
	
	;Set row counter to 1 col counter to 0
	set_counters 0,1
	
	;Display line 2
	display_line line2

	;Delay for 1 second and then clear the screen
	
	call delay
	call lcd_clr

	;Set row counter to 0, col counter to 1

	set_counters 1,0
	
	;Display line 2
	display_line line2

	;Set row counter to 1, col counter to 1
	set_counters 1,1

	;Display line 3
	display_line line3

	;Delay for 1 second and clear the screen
	call delay
	call lcd_clr
	
	;Set row counter to 0, col counter to 0
 	set_counters 0,0
	
	;Display line 3
	display_line line3
	
	;Set row counter to 1, col counter to 0
	set_counters 0,1

	;Display line 4
	display_line line4

	;Delay for 1 second, clear the screen
	call delay
	call lcd_clr
	
	;Set row counter to 0, col counter to 1
	set_counters 1,0

	;Display line 4
	display_line line4

	;Set row counter to 1, col counter to 1
	set_counters 1,1

	;Display line 1
	display_line line1
	
	;Delay for 2 seconds
	call delay
	call delay

	;Decrement r18 and test if it is 0.  If it is, we have looped 3 times so branch to infinite loop.
	dec r18
	tst r18 
	breq continue

	jmp loop_3

;Once we're done looping 3 times, continue onwards to infinite_loop.
continue:

	rjmp infinite_loop

infinite_loop:
	
	;Display all asterisks
	call lcd_clr
	set_counters 0,0
	display_line line5
	set_counters 0,1
	display_line line5
	
	;Delay for 1 second and clear lcd
	call delay
	call lcd_clr
	
	;Display all periods
	set_counters 0,0
	display_line line6
	set_counters 0,1
	display_line line6
	
	;Delay for 1 second and clear lcd
	call delay
	call lcd_clr

jmp infinite_loop

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
		push r24
		
		;Do some operations to delay for one second
		ldi r20, 0x08
del1_2:	
		nop
		ldi r21,0xFF
del2_2:	
		nop
		ldi r22, 0xFF
del3_2:	

		;During delay, check to see if a button is pressed
		call check_button
		cpi r24, 1
		breq pressed_up
		cpi r24, 2
		breq pressed_down

		;If no buttons are pressed, continue with the delay.
no_buttons_pressed:		

		dec r22
		brne del3_2
		dec r21
		brne del2_2
		dec r20
		brne del1_2
		jmp done_delay

		;These two branches will display the messages respective to the buttons pressed.
pressed_up:
		
		call display_button_up
		jmp done_delay

pressed_down: 

		call display_button_down
		jmp done_delay


done_delay:	

		;Clear stack.	
		pop r24
		pop r22
		pop r21
		pop r20

ret



;Loads 1 into r24 if up or right is pressed and 2 if down is pressed
check_button:
	
	push r16
	push r17

	lds r16, ADCSRA
	ori r16, 0x40
	sts ADCSRA, r16

wait:

	lds r16, ADCSRA
	andi r16, 0x40

	lds r16, ADCL
	lds r17, ADCH

	clr r24

	;If select button is pressed, r24 will remain 0, thus, delay will continue as it normally would.
	cpi r17, 2 ;ADCSRA value is < 0x316 so select button is pressed
	brge skip

	cpi r17, 0
	breq up_pressed ;ADCSRA value is < 0x0C3 so up OR right button is pressed

	cpi r17, 1
	breq down_pressed ;ADCSRA value is < 0x17C so down button is pressed


;If up(or right) button is pressed, load 1 into r24
up_pressed:
	ldi r24, 1
	jmp skip

;If down button(or left) is pressed, load 2 into r24
down_pressed:
	ldi r24, 2
	jmp skip

skip: 

	pop r17
	pop r16

	ret

;Display message 1 on line 1, message 2 on line 2 if up button is pressed.
display_button_up:
	
	push r16
	call lcd_clr
	set_counters 0,0
	display_line line1
	set_counters 0,1
	display_line line2
	pop r16
	call delay
	ret

;Display message 3 on line 1, message 4 on line 2 if down button is pressed.
display_button_down:

	push r16
	call lcd_clr
	set_counters 0,0
	display_line line3
	set_counters 0,1
	display_line line4
	pop r16
	call delay
	ret
	

; sample strings
; These are in program memory

msg1_p: .db "Kevin San Gabriel", 0
msg2_p: .db "UVIC: Computer Sci", 0
msg3_p: .db "******************", 0
msg4_p: .db "..................", 0
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
