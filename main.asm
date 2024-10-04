;
; LM7
;
; Created: 11/12/2022
; Author : Bo Broyles
;
; compile with:
; gavrasm.exe -b main.asm
; 
; upload with:
; avrdude -c arduino -p atmega328p -P COM4 -U main.hex

.DEVICE ATmega328p

;Storing the Password in SRAM, Password is 1010 ;;
	ldi r28, $10
	sts $8000, r28
	ldi r28, $20
	sts $8001, r28
	ldi r28, $20
	sts $8002, r28
	ldi r28, $10 
	sts $8003, r28
	clr r28
;Values representing a press of the left and right buttons
    ldi r20, $10 ; left button pressed, add $10
    ldi r21, $20 ; right button pressed, add $20
;Values to check that the password order is correct
    ldi r22, $00 ; left button pressed flag
    ldi r24, $00 ; right button pressed flag
    
    ;lds r26, $8000 ; need the first password value 
;Setting up data direction for PORTD for the LEDs
    ldi r16, $f8
    out DDRD, r16
    clr r16
    out PORTD, r16
;Setting up pins in portB for the buttons
    ldi r16, $f0 
    out DDRB, r16
    clr r16 ; making sure r16 is empty to output to PORTD
    clr r17 ; making sure r17 is empty for when i take in button pressing information

    ldi r23, $00 ; clearing count
  
mainloop:

    in r17, PINB
  
    cpi r17, $01 ; checking to see if the left button was pressed
    breq lbuttonflag

    cpi r17, $02 ; checking to see if the right button was pressed
    breq rbuttonflag

    jmp mainloop ; keep looping until a button has been pressed

lbuttonflag:
    in r18, PINB ; checking to see if the button has been up pressed to jump to leftbuttonpressed, loop until button is unpressed
    SBRS r18, 0
    jmp Leftbuttonpressed
    jmp lbuttonflag

rbuttonflag:
    in r18, PINB ; checking to see if right button has been released to jump to rightbuttonpressed, loop until button is unpressed
    SBRS r18, 1
    jmp Rightbuttonpressed
    jmp rbuttonflag

Leftbuttonpressed:

    ADD r16, r20
    out PORTD, r16
    inc r22
    jmp CheckPassword
    ;;need to add something here to check if the password is correct
    ;jmp mainloop

Rightbuttonpressed:
     
    ADD r16, r21 ; Right button is pressed so adding $20 to value outputted to PORTD
    out PORTD, r16
    inc r24 ; setting the right button pressed flag
    jmp CheckPassword
   
GoodPassword:
    ldi r16, $f8 ; if the password was correct then green LED needs to display
    out PORTD, r16
    clr r23

    jmp mainloop
    nop;
CheckPassword:
    
    inc r23;
    
    cpi r23, $01
    breq Check_one
    cpi r23, $02
    breq Check_two
    cpi r23, $03
    breq Check_three
    cpi r23, $04
    breq Check_four

    cpi r23, $05
    breq BadPassword


Check_one:
    lds r26, $8000

    sbrc r22, 0
    cp r20, r26
    brne BadPassword

    sbrc r24, 0
    cp r21, r26
    brne BadPassword

    cpi r23, $04
    breq GoodPassword

    jmp mainloop

Check_two:
    lds r26, $8001

    sbrc r22, 0
    cp r20, r26
    brne BadPassword

    sbrc r24, 0
    cp r21, r26
    brne BadPassword

    cpi r23, $04
    breq GoodPassword

    jmp mainloop
Check_three:
    lds r26, $8002

    sbrc r22, 0
    cp r20, r26
    brne BadPassword

    sbrc r24, 0
    cp r21, r26
    brne BadPassword

    cpi r23, $04
    breq GoodPassword

    jmp mainloop
Check_four:
    lds r26, $8003

    sbrc r22, 0
    cp r20, r26
    brne BadPassword

    sbrc r24, 0
    cp r21, r26
    brne BadPassword

    cpi r23, $04
    breq GoodPassword

    jmp mainloop
    
BadPassword:
    clr r16
    out PORTD, r16
    clr r23

    jmp mainloop
    nop;