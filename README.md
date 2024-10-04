# LM7 Password Keypad
Due at start of class 11/1/2022  

You should be ok with two buttons and five LEDs. Now we have what we need to make an electronic door lock! Think of a custom escape room puzzle. Just imagine that one of your outputs (the fifth LED) is connected to a locking motor. When the light is on, the door is unlocked, when off, the door is locked.

## Grade Break Down
| Part   |                           | Points  |
|--------|---------------------------|---------|
| Part 1 | Password Keypad           | 90 pts  |   
|        | Self Reflection           | 10 pts  |
|        |                           |Total: 100|

Video link to working demo: 

## LM Evaluation
You will be graded on:
  - Good circuit planning
  - Effective implementation of the requirements
  - Well documented code

**Remember to read and fill out the self-reflection AFTER finishing the assignment.**

## Reference links:
METRO Schematics: https://github.com/adafruit/Adafruit-METRO-328-PCB  
ATmega328P Data Sheet: https://ww1.microchip.com/downloads/en/DeviceDoc/  Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf  
AVR Language Set: http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf  

AVR Debugger: http://www.avr-asm-tutorial.net/avr_sim/index_en.html  
AVR Assembler: http://www.avr-asm-tutorial.net/gavrasm/index_en.html  
AVR Uploader: https://github.com/avrdudes/avrdude   
Alternate for Windows AVRDUDE: https://github.com/mariusgreuel/avrdude/releases  

# Project Requirements

You are going to need to wire the following:
4 LEDs to represent the progress of the lock-entry process
2 switches to get user input
1 LED (I would suggest the green one) to represent 'open (on)' or 'locked (off)'

Your 'password' needs to be stored in SRAM. Set up the password before starting your main loop. You can decide on the password format and pattern (it just can't be all 1s or all zeros). This also means that you need to load from SRAM to check the password.

Because we don't want to mess with time-based entry (i.e. how long did a button get pressed) you are instead going to use button presses (BL (left) or BR (right)) as the trigger. The password will take the form of: BL, BR, BR, BL. As in press the left button, then the right, then the right again, then the left.

As the user is entering the password, one of the progress LEDs will turn on for each button press. Once four values have been entered, then the Open/Locked LED will turn on if the correct password was entered.

At any point, if both buttons are pressed, the lock will reset. This means you will need to measure the pressed-to-not-pressed transition (not the off-to-on transition). A reset means that the lock will be set to locked and the progress will reset.

Positive example (assuming the above password): 
```
Status 1    : 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |  
Status 2    : 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |  
Status 3    : 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 |  
Status 4    : 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |  
ON LED      : 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |  
Button Left :   | P |   |   |   |   |   | P |   | P |  
Button Right:   |   |   | P |   | P |   |   |   | P |  
```

Negative example (assuming the above password):  
```
Status 1    : 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |  
Status 2    : 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 |  
Status 3    : 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 |  
Status 4    : 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 0 |  
ON LED      : 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |  
Button Left :   | P |   |   |   | P |   | P |   | P |  
Button Right:   |   |   | P |   |   |   |   |   | P |  
```

## Extra Credit:
(+5 pts) Make your code work for longer passwords. You will still need to meaningfully represent 'progress'
(+10 pts) incorporate time delays. I.e. the lock will only stay open for 5 seconds, then reset.
