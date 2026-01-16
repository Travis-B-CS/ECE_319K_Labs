//****************** Scratch.s ***************
//
// Author: your name
// Last Modified: date
       .data
       .align 2
Buffer: .short 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
// Declare global variables here if needed
// with the .space assembly directive

// I/O port addresses
    .include "../inc/msp.s"

// Instructions go in FLASH ROM
       .text
       .thumb
       .align 2
       .global main

//******************Swap**************************
// You are given an 11-element 16-bit array.
// Your function should swap the order of the data in the array
// Input: pointer to array
// Output: none
// Error conditions: none
// Test Cases:
// 1. buf before: -5, 4, 7, 0,-1, 3, 4,-8, 2, 9, 9  
//    buf after:  9, 9, 2,-8, 4, 3,-1, 0, 7, 4,-5   
// 2. buf before: 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11
//    buf after:  11,10, 9, 8, 7, 6, 5, 4, 3, 2, 1
// 3. buf before: 1000,2,3,4,5,-1000,7,10000,9,10,0 
//    buf after:  0,10,9,10000,7,-1000,5,4,3,2,1000
// C prototype   void Swap(int16_t buf[11]){

main:  PUSH {R4-R7}
       LDR R0, =Buffer
       MOVS R4, #0
       MOVS R5, #20
       MOVS R6, #5
Loop:
       LDRSH R1, [R0, R4] //Loads element 0
       LDRSH R2, [R0, R5]   
       STRH R1, [R0, R5]
       STRH R2, [R0, R4]
       ADDS R4, #2
       SUBS R5, #2
       SUBS R6, #1
       CMP R6, #0
       BNE Loop      
       
       POP {R4-R7}
       BX  LR


loop:

   B    loop


    .end          // end of file
