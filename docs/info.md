<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a PM32 multiplier using Verilog. The design takes two binary input values and computes their product 
using combinational logic. The inputs are provided through the ui_in pins. The lower bits of ui_in represent one operand, and 
the upper bits represent the second operand. The multiplier processes these inputs and produces the result. The output of the 
multiplication is assigned to the uo_out pins. Since the output width is limited, only the lower bits of the full product may 
be shown.

## How to test
To test the design, provide input values through the ui_in pins.
For example:
- Set the lower 4 bits of ui_in to one number
- Set the upper 4 bits of ui_in to another number
The output uo_out should display the product of these two numbers.
You can verify correctness by comparing the output to the expected multiplication result.

## External hardware

This project does not require any external hardware.

All functionality is implemented inside the digital logic of the design. Inputs are provided through the on-chip input 
pins, and outputs are observed through the output pins. No additional components, sensors, or peripherals are needed.
