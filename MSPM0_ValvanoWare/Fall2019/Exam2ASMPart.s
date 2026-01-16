//Exam2AsmPart.s
// EE319K Fall 2019 exam 2, November 2019
// ***Put your name here***
// -5 points if you do not add your name
// This is the assembly Part of the Exam (See Exam2CPart.c for the C part)
// The assembly part is not related to the C part

// All three functions in the assembly part, solve this one problem
// 1) grandmother should take three pills each day,
//        the pills are numbered from 0 to 2
// 2) the order of taking the pills could change each day
// 3) there are seven days in a week, the days are numbers 0 to 6
// 4) grandmother should take one of each type of pill each day

// move test cases to printout
//1) init 30
//2)takes (look at array) 15
//3)my takes, and their needs 15

// just takespill
// the init is always called first and once per week, but the other functions could be called in any order


//Example 1
// Grandmother_Init()//
// Grandmother_TakesPill(0,0)// // should return 0, takes pill 0 on day 0
// Grandmother_TakesPill(1,0)// // should return 0, takes pill 1 on day 0
// Grandmother_TakesPill(2,0)// // should return 0, takes pill 2 on day 0
// Grandmother_TakesPill(1,1)// // should return 0, takes pill 1 on day 1
// Grandmother_TakesPill(0,1)// // should return 0, takes pill 0 on day 1
// Grandmother_TakesPill(2,1)// // should return 0, takes pill 2 on day 1
// Grandmother_TakesPill(2,2)// // should return 0, takes pill 2 on day 2
// Grandmother_TakesPill(1,2)// // should return 0, takes pill 1 on day 2
// Grandmother_TakesPill(0,2)// // should return 0, takes pill 0 on day 2
// Grandmother_NeedsPill(1)//   // should return 3 because she completed all 3 pills on day 1
// Grandmother_NeedsPill(2)//   // should return 3 because she completed all 3 pills on day 2
// Grandmother_NeedsPill(0)//   // should return 3 because she completed all 3 pills on day 0

//Example 3
// Grandmother_Init()//
// Grandmother_TakesPill(2,3)// // should return 0, takes pill 2 on day 3
// Grandmother_TakesPill(0,3)// // should return 0, takes pill 0 on day 3
// Grandmother_NeedsPill(3)//   // should return 1 because she needs pill 1 on day 3
//Example 4
// Grandmother_Init()//
// Grandmother_NeedsPill(0)// // should return 0 1 or 2 because she needs all pills for day 0
//Example 5
//Grandmother_Init()//
//Grandmother_TakesPill(2,6)// // should return 0, takes pill 2 on day 6
//Grandmother_TakesPill(0,6)// // should return 0, takes pill 0 on day 6
//Grandmother_NeedsPill(6)//  // should return 1 because needed pill 1


       .data
       .align 2
//****DO NOT MODIFY THE NEXT ELEVEN LINES**************
         .global  Pills
         .global  KeepOut
         .global  Grandmother_Init
         .global  Grandmother_TakesPill
         .global  Grandmother_NeedsPill
         .space 3 // do not read or write this location
Pills:
Pill0:   .space 7 // array of counters for pill 0, one 8-bit counter for each day
Pill1:   .space 7 // array of counters for pill 1, one 8-bit counter for each day
Pill2:   .space 7 // array of counters for pill 2, one 8-bit counter for each day
KeepOut: .space 4 // do not read or write this location
     .align 2
     .text
     .align 2

//*** Question 1 ***** Grandmother_Init **********
// At the beginning of every week, this function will be called.
// This function should clear all bytes in the three arrays
// Input: none
// Output: none
// you may not write into the KeepOut variable
// C prototype is void Grandmother_Init(void)//
Grandmother_Init:
     // put your answer here

     BX   LR
     
//*** Question 2 ***** Grandmother_TakesPill **********
// This function is called when grandmother takes a pill.
// Inputs: R0 is the pill number (0 to 2)
//         R1 is the day number (0 to 6)
// You must update the appropriate array with the count of pills taken
// Output: R0 is the result
//         return -1 if illegal pill parameter (pill number not 0 to 2)
//         return -1 if illegal day parameter (day not 0 to 6)
//         return +1 if grandmother has taken more than one of these types of pills on this day
//         return 0 if grandmother has properly taken this pill
// you may not write into the KeepOut variable
// C prototype is int32_t Grandmother_TakesPill(uint32_t pill, uint32_t day)//
Grandmother_TakesPill:
     MOVS  R0,#42 // delete this line and replace with solution

     BX  LR
     
//*** Question 3 ***** Grandmother_NeedsPill **********
// This function is called to check if grandmother needs to take a pill.
// Inputs: R0 is the day number
// Output: R0 is the result
//   return 2 if grandmother needs to take pill 2
//   return 1 if grandmother needs to take pill 1
//   return 0 if grandmother needs to take pill 0
// if she needs more than one pill, return any of the pills she needs
//   return 3 if grandmother has taken at least one of all three of her pills for this day
// Note: you will be guaranteed that the day number will be properly 0 to 6
// C prototype is int32_t Grandmother_NeedsPill(uint32_t day)//
Grandmother_NeedsPill:
     MOVS R0,#42 // delete this line and replace with solution


     BX   LR

 .end
        
