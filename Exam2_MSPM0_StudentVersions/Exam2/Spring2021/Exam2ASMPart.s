// Exam2ASMPart.s
// EE319K/EE319H Exam2, Spring 2021
// ***Put your name here***
// This is the assembly Part of the Exam 2 (See Exam2ASMPart.c for the C part)
// The assembly part is not related to the C part
// The assembly part has one function

     .text
     .align 2
     .global  FirstLastCompute


    
//***********FirstLastCompute**************
// Question 1: You are given a variable-length
// array of 16-bit unsigned non-zero values
// terminated by a sentinel value of 0.
// The array length 'n' can be between 0 and 16
// Compute and return the following value:
//     ((array[0]*(16-n) + array[n-1]*n )
// That is, the first element times (16-n) plus the
//          last element times (n)
// Input:  R0 holds the address of the array
// Output: R0 holds the computed result
// Error Conditions: If the array length is zero,
//                   return R0=0xFFFF (65535)
// The first test case is:
// R0 points to {1,12,123,44,555,2,0}// Result(R0) = 1*(16-6) + 2*6 = 22
// The remaining cases are randomly generated
//Must comply with AAPCS, save/restore R4-R11 if used
FirstLastCompute:
// AAPCS
   MOVS R0,#42 // remove this line
   BX	LR
     


   .end
        
