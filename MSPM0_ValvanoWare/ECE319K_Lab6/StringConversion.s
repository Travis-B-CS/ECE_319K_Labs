// StringConversion.s
// Student names: Travis and Jonathan
// Last modification date: 03/08/25
// Runs on any Cortex M0
// ECE319K lab 6 number to string conversion
//
// You write udivby10 and Dec2String
     .data
     .align 2
// no globals allowed for Lab 6
    .global OutChar    // virtual output device
    .global OutDec     // your Lab 6 function
    .global Test_udivby10

    .text
    .align 2
// **test of udivby10**
// since udivby10 is not AAPCS compliant, we must test it in assembly
Test_udivby10:
    PUSH {LR}

    MOVS R0,#123
    BL   udivby10
// put a breakpoint here
// R0 should equal 12 (0x0C)
// R1 should equal 3

    LDR R0,=12345
    BL   udivby10
// put a breakpoint here
// R0 should equal 1234 (0x4D2)
// R1 should equal 5

    MOVS R0,#0
    BL   udivby10
// put a breakpoint here
// R0 should equal 0
// R1 should equal 0
    POP {PC}

//****************************************************
// divisor=10
// Inputs: R0 is 16-bit dividend
// quotient*10 + remainder = dividend
// Output: R0 is 16-bit quotient=dividend/10
//         R1 is 16-bit remainder=dividend%10 (modulus)
// not AAPCS compliant because it returns two values
udivby10:
   PUSH {R4-R7, LR}
// write this
   LDR R7, =52429 //52429*2^-19 = 0.1000003815
   MOVS R6, #19
   MOVS R5, R0
   MULS R5, R5, R7
   LSRS R5, R5, R6 //This is R0/~10
   MOVS R1, R5
   MOVS R3, #10
   MULS R1, R3
   SUBS R1, R0, R1 //This is remainder
   MOVS R0, R5
   POP  {R4-R7, PC}

  
//-----------------------OutDec-----------------------
// Convert a 16-bit number into unsigned decimal format
// Call the function OutChar to output each character
// You will call OutChar 1 to 5 times
// OutChar does not do actual output, OutChar does virtual output used by the grader
// Input: R0 (call by value) 16-bit unsigned number
// Output: none
// Invariables: This function must not permanently modify registers R4 to R11
OutDec:
   PUSH {R4-R7, LR}
.equ quotient, 0
.equ remainder, 4
.equ counter, 8
   SUB SP, SP, #12
   MOV R7, SP
   MOVS R6, #0
   STR R6, [R7, #counter]
Repeat:  
   BL udivby10
   STR R0, [R7, #quotient]
   STR R1, [R7, #remainder]
   MOVS R4, #0
   LDR R5, [R7, #quotient]
   CMP R4, R5
   BEQ LastChar
   LDR R0, [R7, #remainder]
   ADDS R0, 0x30
   PUSH {R0}
   LDR R6, [R7, #counter]
   ADDS R6, #1
   STR R6, [R7, #counter]
   LDR R0, [R7, #quotient]
   B Repeat

LastChar:
   LDR R0, [R7, #remainder]
   ADDS R0, 0x30
   PUSH {R0}
   LDR R6, [R7, #counter]
   ADDS R6, #1
   STR R6, [R7, #counter]

Print:
   CMP R6, #0
   BEQ Done
   POP {R0}
   BL OutChar
   LDR R6, [R7, #counter]
   SUBS R6, #1
   STR R6, [R7, #counter]
   B Print

Done:
   ADD SP, SP, #12
   POP  {R4-R7, PC}
//* * * * * * * * End of OutDec * * * * * * * *

// ECE319H recursive version
// Call the function OutChar to output each character
// You will call OutChar 1 to 5 times
// Input: R0 (call by value) 16-bit unsigned number
// Output: none
// Invariables: This function must not permanently modify registers R4 to R11

OutDec2:
   PUSH {LR}
// write this

   POP  {PC}



     .end
