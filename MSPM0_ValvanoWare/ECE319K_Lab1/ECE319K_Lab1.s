//****************** ECE319K_Lab1.s ***************
// Your solution to Lab 1 in assembly code
// Author: Travis Beach
// Last Modified: 1/16/25
// Spring 2025
        .data
        .align 2
// Declare global variables here if needed
// with the .space assembly directive

        .text
        .thumb
        .align 2
        .global EID
EID:    .string "TMB3956" // replace ZZZ123 with your EID here

        .global Phase
        .align 2
Phase:  .long 10
// Phase= 0 will display your objective and some of the test cases, 
// Phase= 1 to 5 will run one test case (the ones you have been given)
// Phase= 6 to 7 will run one test case (the inputs you have not been given)
// Phase=10 will run the grader (all cases 1 to 7)
        .global Lab1
// Input: R0 points to the list
// Return: R0 as specified in Lab 1 assignment and terminal window
// According to AAPCS, you must save/restore R4-R7
// If your function calls another function, you must save/restore LR
Lab1: PUSH {R4-R7,LR}
       // your solution goes here
        MOVS R1, R0
       // LDR R1, =myClass        //Address of myClass is loaded into R1
        MOVS R7, #0             //Clears R7 for index
        MOVS R4, #0             //Sets R4 to 0 for ASCII counter

CHECKEID:
        LDR R5, =EID            //Loads address of my EID
        LDR R2, [R1]            //Load pointer into R2
        ADDS R2, #0         
        BEQ ENDOFARRAY          //Sees if this is the end of the array

NEXTASCII:  
        LDRB R3, [R2, R4]       //Loads ASCII into R3
        LDRB R6, [R5, R4]       //Loads  ASCII of my EID
        CMP R6, R3
        BNE CHECKNEXTEID        //Branches if ASCII is wrong
        ADDS R4, #1
        CMP R4, #8             //Sees if this is the eight digit including null terminator
        BNE NEXTASCII
        MOVS R0, R7             //Moves index to R0 for output
        B DONE

CHECKNEXTEID:
        ADDS R7, #1             //Increment index
        MOVS R4, #0             //Clears ASCII counter
        ADDS R1, #8             //Address of next EID pointer is in R1
        B CHECKEID

ENDOFARRAY:
        MOVS R0, #0        
        SUBS R0, #1             //Sets R0 to -1 if EID was not found

DONE:
      POP  {R4-R7,PC} // return


        .align 2
        .global myClass
myClass: .long pAB123  // pointer to EID
         .long 95      // Score
         .long pXYZ1   // pointer to EID
         .long 96      // Score
         .long pAB5549 // pointer to EID
         .long 94      // Score
         .long 0       // null pointer means end of list
         .long 0
pAB123:  .string "AB123"
pXYZ1:   .string "XYZ1"
pAB5549: .string "AB5549"
        .end
