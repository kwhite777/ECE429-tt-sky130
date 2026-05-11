<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This design showcases a secure combination lock. The design has 6 input bits. Four of these bits are for inputting the code, one is for the reset operation, and the last one is to change the modes. On the other side of things, this design has 3 output bits. One for unlock, one to set off the alarm, and one for tamper. These are the overall pins of the system. 

This design acts like a typical combination lock, however there are a few things to explain. There are two modes (mode 0 and mode 1). You can change which mode you are in in your mode input, and depending on which mode you are in, the correct input code is different. In mode 0, the correct input code is 1011. In mode 1, the correct input code is 0101. As long as you input the right code for the corresponding mode, the following description applies to both modes.

When the reset input is triggered, every other input and output goes to 0. This includes the input code, the mode, unlock, alarm, and tamper. It is important to note that if you click reset, you will automatically be put in mode 0, therefore if you want to go to mode 1, you must be sure that the reset input is 0, and then change the mode to 1. 

When the incorrect code is input for either mode, unlock goes low, and alarm goes high. Tamper stays low, as the symbolic 1111 input that represents suspicious activity is the only thing that can make tamper go high. This applies for both modes. 

Overall, the system unlocks when the correct code is entered for the corresponding mode, triggers an alarm when the incorrect code is entered, sets everything to 0 when reset goes high, and triggers temper and alarm when suspicious activity (input of 1111) occurs. 

                                           |------------------------|
                                           |                        |
                                           |          Reset         |
                                           |        (ui_in[4])      |
                                           |                        |
                                           |------------------------|
                                                        |
                                                        |
                                                        |
                                                        v
                                           |------------------------|
                                           |                        |
                                           |       Mode Select      |
                                           |        (ui_in[5])      |
                                           |                        |
                                           |------------------------|
                                                        |
                                                        |
                                                        |
                                                        v
                                           |------------------------|
                                           |                        |
                                           |        Input Code      |
                                           |       (ui_in[0:3])     |
                                           |                        |
                                           |------------------------|                                           
                                                        |
                                                        |
                                                        |
                                                        v                                           
                                           |------------------------|           |---------------|
                                           |            Is          |           |               |
                                           |        Input Code      |    YES    |               |
                                           |         Correct?       |---------->|     Unlock    |
                                           |       (ui_in[0:3])     |           |               |
                                           |------------------------|           |---------------|                       
                                                        |
                                                        | NO
                                                        |
                                                        v                                           
                                           |------------------------|          |---------------|
                                           |            Is          |          |               |
                                           |        Input Code      |    NO    |               |  
                                           |           1111?        |--------->|     Alarm     |
                                           |       (ui_in[0:3])     |          |               |
                                           |------------------------|          |---------------|                                
                                                        |                              ^ 
                                                        | YES                          |
                                                        |-------------------------------
                                                        v                               
                                                |---------------|
                                                |               |
                                                |     Tamper    |
                                                |               |
                                                |               |
                                                |---------------|  


## How to test
To test the design, provide input values through the ui_in pins and observe the values at the uo_out pins.

Input Pins:
ui_in[0:3] - input code
ui_in[4]   - reset
ui_in[5]   - mode

Output Pins:
uo_out[0]  - unlock
uo_out[1]  - alarm
uo_out[2]  - tamper

To test unlock functionality, enter the correct code and see if unlock goes high. If unlock goes high then 
it is working. Be sure to also test the incorrect code and ensure that unlock goes back to 0. If this is 
the case then unlock is working. 

To test the reset, set the reset to 1, if all inputs and outputs go to 0, then reset is functioning properly

To test the mode, set mode 0 and type in the corresponding code for mode 0. If unlock goes to 1 for that 
input code, but not any other input code then mode 0 is working. Repeat the same process for mode 1 and if
that passes the same tests for mode 0 then you know your mode input is working

To test the alarm, type in the wrong code. If alarm goes to 1 when the incorrect code is typed but stays at
zero when the correct code is typed, then alarm is operating correctly. Be sure to also test the tamper case.

To test tamper, input the code 1111. If the tamper output goes high when 1111 is input, but stays low for 
all other inputs, then the tamper function is working correctly. Note that when the tamper condition is met,
alarm should also go to 1.

That is how you can test this!



## External hardware

This project does not require any external hardware.

All functionality is implemented inside the digital logic of the design. Inputs are provided through the on-chip input 
pins, and outputs are observed through the output pins. No additional components, sensors, or peripherals are needed.
