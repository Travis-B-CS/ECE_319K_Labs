// Travis Beach
// -5 points if you do not add your name

// This is Exam2_ArrayofStruct 
// EE319K Fall 2014 exam2, November 6, 2014
// You edit this file only  
       .data


       .text
	   .align 2
       

//***************** Linear****************************
// Calculate the result of a linear equation y = 16*x-50  
// Input parameter: x is unsigned 8 bits
// Output parameter: y is unsigned 8 bits
// Error conditions: implement ceiling on overflow
//                   implement floor on underflow
// Test Cases as (Input, Output) pairs: 
// (0,0),(3,0),(4,14),(5,30),(11,126),
// (15,190),(19,254),(20,255),(100,255),(255,255)
// C prototype   uint8_t Linear(uint8_t x){
       .global Linear
Linear:
       LSLS R0, R0, #4
       SUBS R0, #50
       BMI NEG //Check Neg
       LDR R1, =255
       CMP R0, R1
       BHI OVERFLOW //Check Overflow
       B DONE
NEG:
       MOVS R0, #0
       B DONE
OVERFLOW:
       MOVS R0, #255
       B DONE
DONE:
       BX  LR

//ABOVE WORKS


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
       .global Swap
Swap:  PUSH {R4-R7}
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

//ABOVE WORKS


//struct LabGrades{
//  int32_t size//
//  int32_t score[10]//
//}//
//typedef struct LabGrades LabGrades_t//
// *******************Average******************
// You will write this function. 
// The function should take a pointer to a lab grade structure and return the average.
// Average can be calculated only if the size is 1 to 10. 
// Input:  Pointer to a lab grade structure
// Output: Average of the lab grades
// Error conditions: If the size is outside the range of 1 to 10, return 0.
// test data
// size  score                                  Average
// 10  |  90  90  90  90  90  90  90  90  90  90 | 90
// 5   |  90  91  92  93  94                     | 92
// 1   | 100                                     |100
// 5   |  85  90  100 70 -25                     | 64
// 8   |  -4  -5  -6  -7 -10   1   2   5         | -3
// 0   |                                         |  0
// 255 |                                         |  0
// C prototype   int32_t Average(LabGrades_t *pt){ // debug this code
       .global Average
Average:  PUSH {R4-R7}
       LDR R1, [R0] //Loads size
       MOVS R2, #0
       CMP R0, R2
       BLE WrongSize
       MOVS R2, #11
       BGE WrongSize

       MOVS R4, #4 //Offset
       MOVS R5, #0
Loop:
       LDR R2, [R0, R4]
       ADDS R5, R5, R2
       ADDS R4, #4
       SUBS R1, #1
       CMP R1, #0
       BNE Loop
       //Otherwise divide R5 by size but how without fixed pt?



WrongSize:
       MOVS R0, #0
       B Done
  
Done:
       POP {R4-R7}
       BX  LR

//FINISH THE ABOVE FUNC


// **************ClassAverage****************
//   Find the average of all the lab grades in the class
//   Sum up all grades and divide by the number of grades
//   Do not sum up student averages and divide by the number of students
//   if size is 255, it means end of list
//   When dividing, do not round, simply divide sum/count
// Each Labgrade structure is 44 bytes (4 bytes for size and 40 bytes for 10 grades)
// Input:  array of Grades_t data
// Output: the average lab grade
// Error conditions: if there are no students or no grades, return 0
//------------------------------------------------------------------
//Case 1: six students in the class
//{{5,{84,90,88,70,-25}},    
// {1,{70}},    
// {9,{90,90,90,90,-90,70,10,10,10}},
// {0,{}}, 
// {10,{80,80,80,80,80,80,80,80,80,99}}, 
// {2,{80,82}},
// {255,{}}
//}
//Class Average = 64// (see handout for explanation)
//------------------------------------------------------------------
//Case 2: three students in the class
//{{2,{100,100,}}, 
// {1,{95}}, 
// {2,{90,90}}, 
// {255,{0}}
//}
//Class Average = (100+100+95+90+90)/5 = 475/5 = 95 
//-------------------------------------------------------------------
//Case 3: one student in the class
//{{4    ,{-1,-1,-1,-1}},
// {255,{0}}
//}
//Class Average = -1//
//
//Case 4:    no students at all
//{{255,{0}}
//}
//Class Average = 0// 
//------------------------------------------------------------------
// C prototype   int32_t ClassAverage(LabGrades_t ee319k[]){
       .global ClassAverage
ClassAverage:
  // put your answer here


       MOVS R0,#42 // replace this line with your solution
       BX  LR


       .end
           