//****************** ECE319K_Lab2.s ***************
// Your solution to Lab 2 in assembly code
// Author: Travis Beach
// Last Modified: 1/22/2025
// ECE319K Spring 2025 (ECE319H students do Lab2H)
// I/O port addresses
    .include "../inc/msp.s"

        .data
        .align 2
// Declare global variables here if needed
// with the .space assembly directive


        .text
        .thumb
        .align 2
        .global EID
EID:    .string "TMB3956" // replace ZZZ123 with your EID here
        .align 2

// this allow your Lab2 programs to the Lab2 grader
        .global Lab2Grader
// this allow the Lab2 grader to call your Lab2 program
        .global Lab2
// these two allow your Lab2 programs to all your Lab3 solutions
        .global Debug_Init
        .global Dump

// Switch input: PB2 PB1 or PB0, depending on EID
// LED output:   PB18 PB17 or PB16, depending on EID
// logic analyzer pins PB18 PB17 PB16 PB2 PB1 PB0
// analog scope pin PB20
Lab2:
// Initially the main program will
//   set bus clock at 80 MHz,
//   reset and power enable both Port A and Port B
// Lab2Grader will
//   configure interrupts  on TIMERG0 for grader or TIMERG7 for TExaS
//   initialize ADC0 PB20 for scope,
//   initialize UART0 for grader or TExaS
     MOVS R0,#10
// 0 for info,
// 1 debug with logic analyzer,
// 2 debug with scope,
// 3 debug without scope or logic analyzer
// 10 for grade
     BL   Lab2Grader
     BL   Debug_Init // your Lab3 (ignore this line while doing Lab 2)
     BL   Lab2Init
loop:
        BL Duty15
        BL Duty35
        BL Duty45
        BL Duty75


     B    loop


// make switch an input, LED an output
// PortB is already reset and powered
// Set IOMUX for your input and output
// Set GPIOB_DOE31_0 for your output (be friendly)
Lab2Init: PUSH {R4-R7, LR}
// ***do not reset/power Port A or Port B, already done****
        
        //Change Switch Setup
        LDR R0, =IOMUXPB2
        LDR R1, =0x00040081
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        //LED Setup
        LDR R0, =IOMUXPB18
        MOVS R1, 0x81
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        //Enable LED Output
        LDR R0, =GPIOB_DOE31_0
        LDR R1, =0x00040000
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]

        POP {R4-R7, PC}
   BX   LR

LEDOn:  PUSH {R4-R7, LR}

        //Turn on LED (Pin 18 = High)
        LDR R0, =GPIOB_DOUT31_0
        LDR R1, =0x40000
        LDR R2, [R0]
        ORRS R2, R2, R1
        STR R2, [R0]
        
        BL Dump       //For Lab 3

        POP {R4-R7, PC}
        BX LR

LEDOff: PUSH {R4-R7, LR}

        //Turn off LED (Pin 18 = low)
        LDR R0, =GPIOB_DOUT31_0
        LDR R1, =0x40000
        LDR R2, [R0]
        BICS R2, R2, R1
        STR R2, [R0]

        BL Dump       //For Lab 3

        POP {R4-R7, PC}
        BX LR

Duty15: PUSH {R4-R7, LR}
        
        //Duty Cycle of 15%
        BL LEDOn
        LDR R0, =240000 // 3ms delay
        BL Delay
        ADDS R2, R2, #0
        BNE Done15
        BL LEDOff
        LDR R0, =1360000 // 17ms delay
        BL Delay
        ADDS R2, R2, #0
        BEQ Duty15
Done15:
        POP {R4-R7, PC}
        BX LR

Duty35: PUSH {R4-R7, LR}

        //Duty Cycle of 35%
        BL LEDOn
        LDR R0, =560000 // 7ms delay
        BL Delay
        ADDS R2, R2, #0
        BNE Done35
        BL LEDOff
        LDR R0, =1040000 // 13ms delay
        BL Delay
        ADDS R2, R2, #0
        BEQ Duty35
Done35:
        POP {R4-R7, PC}
        BX LR

Duty45: PUSH {R4-R7, LR}

        //Duty Cycle of 45%
        BL LEDOn
        LDR R0, =720000 // 9ms delay
        BL Delay
        ADDS R2, R2, #0
        BNE Done45
        BL LEDOff
        LDR R0, =880000 // 11ms delay
        BL Delay
        ADDS R2, R2, #0
        BEQ Duty45
Done45:
        POP {R4-R7, PC}
        BX LR 

Duty75: PUSH {R4-R7, LR}

        //Duty Cycle of 75%
        BL LEDOn
        LDR R0, =1200000 // 15ms delay
        BL Delay
        ADDS R2, R2, #0
        BNE Done75
        BL LEDOff
        LDR R0, =400000 // 5ms delay
        BL Delay
        ADDS R2, R2, #0
        BEQ Duty75
Done75:
        POP {R4-R7, PC}
        BX LR

Delay:
        SUBS R0, R0, #2
DelayLoop:
        LDR R3, =GPIOB_DIN31_0
        MOVS R1, 0x4
        LDR R2, [R3]
        ANDS R2, R2, R1
        BNE SwitchDuty
        SUBS R0, R0, #10 //Was subs 4 but had to increase due to time to check switch embedded
        NOP
        BHS DelayLoop
SwitchDuty:
        BX LR

   .end
