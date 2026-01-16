//****************** Scratch.s ***************
//
// Author: Travis Beach
// Last Modified: 1/29/2025
       .data
       .align 2
// Declare global variables here if needed
// with the .space assembly directive

// I/O port addresses
    .include "../inc/msp.s"

// Instructions go in FLASH ROM
       .text
       .thumb
       .align 2
       .global main
main:
       BL LEDInit
       BL RedOn
       BL BlueOn

loop:

   B    loop

RedOn:  PUSH {R4-R7, LR}

        //Turn on LED (Pin 26 = High)
        LDR R0, =GPIOB_DOUT31_0
        LDR R1, =(1<<26)
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        POP {R4-R7, PC}
        BX LR

BlueOn:  PUSH {R4-R7, LR}

        //Turn on LED (Pin 22 = High)
        LDR R0, =GPIOB_DOUT31_0
        LDR R1, =0x400000
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        POP {R4-R7, PC}
        BX LR        

LEDInit: PUSH {R4-R7, LR}

       //LED Setup Blue (PB22)
        LDR R0, =IOMUXPB22
        MOVS R1, 0x81
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        //Enable LED Output
        LDR R0, =GPIOB_DOE31_0
        LDR R1, =0x400000
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

       //LED Setup Red (PB26)
        LDR R0, =IOMUXPB26
        MOVS R1, 0x81
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        //Enable LED Output
        LDR R0, =GPIOB_DOE31_0
        LDR R1, =(1<<26)
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

       POP {R4-R7, PC}
       BX LR

    .end          // end of file
