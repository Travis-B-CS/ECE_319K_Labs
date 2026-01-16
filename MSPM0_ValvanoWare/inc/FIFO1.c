// FIFO1.c
// Runs on any microcontroller
// Provide functions that implement the Software FiFo Buffer
// Last Modified: 04/03/2025
// Student names: Travis and Jonathan
#include <stdint.h>


// Declare state variables for FiFo
//        size, buffer, put and get indexes
#define FifoSize 13
static uint8_t FifoPutIndex;  // index to put new
static uint8_t FifoGetIndex;  // index of oldest
static char Fifo[FifoSize];

// *********** Fifo1_Init**********
// Initializes a software FIFO1 of a
// fixed size and sets up indexes for
// put and get operations
void Fifo1_Init(){
  FifoPutIndex = 0;
  FifoGetIndex = 0;
}

// *********** Fifo1_Put**********
// Adds an element to the FIFO1
// Input: data is character to be inserted
// Output: 1 for success, data properly saved
//         0 for failure, FIFO1 is full
uint32_t Fifo1_Put(char data){
  if(((FifoPutIndex+1)%FifoSize) == FifoGetIndex){
    return 0; //Fifo is full
  }
  else{
    Fifo[FifoPutIndex] = data; //Push to Fifo
    FifoPutIndex = ((FifoPutIndex+1)%FifoSize); //Increments FifoPutIndex
    return 1; //Sucessfully pushed to Fifo
  }
}

// *********** Fifo1_Get**********
// Gets an element from the FIFO1
// Input: none
// Output: If the FIFO1 is empty return 0
//         If the FIFO1 has data, remove it, and return it
char Fifo1_Get(void){
  char temp;
  if(FifoGetIndex == FifoPutIndex){
    return 0; //Fifo is empty
  }
  else{
    temp = Fifo[FifoGetIndex]; //Retrived char
    FifoGetIndex = ((FifoGetIndex+1)%FifoSize); // next place to get
    return temp; //Success, returns char
  }
}



