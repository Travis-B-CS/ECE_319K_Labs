/* ECE319K_Lab4main.c
 * Traffic light FSM
 * ECE319H students must use pointers for next state
 * ECE319K students can use indices or pointers for next state
 * Put your names here or look silly
  */

#include <ti/devices/msp/msp.h>
#include "../inc/LaunchPad.h"
#include "../inc/Clock.h"
#include "../inc/UART.h"
#include "../inc/Timer.h"
#include "../inc/Dump.h"  // student's Lab 3
#include <stdio.h>
#include <string.h>
// put both EIDs in the next two lines
const char EID1[] = "TMB3956"; //  ;replace abc123 with your EID
const char EID2[] = "JE28736"; //  ;replace abc123 with your EID
// Hint implement Traffic_Out before creating the struct, make struct match your Traffic_Out

struct state {
  uint32_t output;
  uint32_t dwell;
  uint8_t next[8];
};

typedef struct state state_t;

#define gSouth 0
#define ySouth 1
#define rSouth 2
#define gWalk 3
#define yWalk1 4
#define yWalk2 5
#define yWalk3 6
#define yWalk4 7
#define yWalk5 8
#define yWalk6 9
#define rWalk 10
#define gWest 11
#define yWest 12
#define rWest 13

state_t FSM[14] = {
  {0x4000101, 200, {gSouth, ySouth, gSouth, ySouth, ySouth, ySouth, ySouth, ySouth}},
  {0x4000102, 50, {rSouth, rSouth, rSouth, rSouth, rSouth, rSouth, rSouth, rSouth}},
  {0x4000104, 50, {gWalk, gWest, gSouth, gWest, gWalk, gWalk, gWalk, gWalk}},
  {0xC400104, 200, {gWalk, yWalk1, yWalk1, yWalk1, gWalk, yWalk1, yWalk1, yWalk1}},
  {0x4000104, 20, {yWalk2, yWalk2, yWalk2, yWalk2, yWalk2, yWalk2, yWalk2, yWalk2}},
  {0x104, 20, {yWalk3, yWalk3, yWalk3, yWalk3, yWalk3, yWalk3, yWalk3, yWalk3}},
  {0x4000104, 20, {yWalk4, yWalk4, yWalk4, yWalk4, yWalk4, yWalk4, yWalk4, yWalk4}},
  {0x104, 20, {yWalk5, yWalk5, yWalk5, yWalk5, yWalk5, yWalk5, yWalk5, yWalk5}},
  {0x4000104, 20, {yWalk6, yWalk6, yWalk6, yWalk6, yWalk6, yWalk6, yWalk6, yWalk6}},
  {0x104, 20, {rWalk, rWalk, rWalk, rWalk, rWalk, rWalk, rWalk, rWalk}},
  {0x4000104, 50, {gWest, gWest, gSouth, gWest, gWalk, gWest, gSouth, gWest}},
  {0x4000044, 200, {gWest, gWest, yWest, yWest, yWest, yWest, yWest, yWest}},
  {0x4000084, 50, {rWest, rWest, rWest, rWest, rWest, rWest, rWest, rWest}},
  {0x4000104, 50, {gSouth, gWest, gSouth, gSouth, gWalk, gWalk, gSouth, gSouth}}
};

uint8_t currentState = gSouth;
uint8_t input;

// initialize all 6 LED outputs and 3 switch inputs
// assumes LaunchPad_Init resets and powers A and B
void Traffic_Init(void){ // assumes LaunchPad_Init resets and powers A and B
  //South: Red (02), Yellow (01), Green (00), Sensor (16)
  IOMUX->SECCFG.PINCM[PB2INDEX] = IOMUX->SECCFG.PINCM[PB2INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB1INDEX] = IOMUX->SECCFG.PINCM[PB1INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB0INDEX] = IOMUX->SECCFG.PINCM[PB0INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB16INDEX] = IOMUX->SECCFG.PINCM[PB16INDEX] | 0x40081;
  GPIOB->DOE31_0 = GPIOB->DOE31_0 | 0x7;

  //West: Red (08), Yellow (07), Green (06), Sensor (15)
  IOMUX->SECCFG.PINCM[PB8INDEX] = IOMUX->SECCFG.PINCM[PB8INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB7INDEX] = IOMUX->SECCFG.PINCM[PB7INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB6INDEX] = IOMUX->SECCFG.PINCM[PB6INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB15INDEX] = IOMUX->SECCFG.PINCM[PB15INDEX] | 0x40081;
  GPIOB->DOE31_0 = GPIOB->DOE31_0 | 0x1C0;

  //Walk: Red (26), Green (27), Blue (22), Sensor (17)
  IOMUX->SECCFG.PINCM[PB27INDEX] = IOMUX->SECCFG.PINCM[PB27INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB26INDEX] = IOMUX->SECCFG.PINCM[PB26INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB22INDEX] = IOMUX->SECCFG.PINCM[PB22INDEX] | 0x81;
  IOMUX->SECCFG.PINCM[PB17INDEX] = IOMUX->SECCFG.PINCM[PB17INDEX] | 0x40081;
  GPIOB->DOE31_0 = GPIOB->DOE31_0 | 0xC400000;
  
}

/* Activate LEDs
* Inputs: currentState
* Output: none; sets the correct LEDs
*/

void Traffic_Out(uint8_t currentState){
  GPIOB->DOUT31_0 = ((GPIOB->DOUT31_0 & 0xF3BFFE38) | FSM[currentState].output);
}

/* Read sensors
 * Input: none
 * Output: index of next array
 */
uint32_t Traffic_In(void){
  return (((GPIOB->DIN31_0 & (7<<15))>>15));
}

// use main1 to determine Lab4 assignment
void Lab4Grader(int mode);
void Grader_Init(void);

int main1(void){ // main1
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Lab4Grader(0); // print assignment, no grading
  while(1){
  }
}

// use main2 to debug LED outputs
// at this point in ECE319K you need to be writing your own test functions
// modify this program so it tests your Traffic_Out  function
//Cycles through all used LEDs in DataBuffer
int main2(void){ // main2
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Grader_Init(); // execute this line before your code
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
  Debug_Init();
  if((GPIOB->DOE31_0 & 0x20)==0){
    UART_OutString("access to GPIOB->DOE31_0 should be friendly.\n\r");
  }
  UART_Init();
  UART_OutString("Lab 4, Spring 2025, Step 1. Debug LEDs\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
  UART_OutString("EID2= "); UART_OutString((char*)EID2); UART_OutString("\n\r");
  while(1){
    Traffic_Out(0);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<0));
    Traffic_Out(1);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<1));
    Traffic_Out(2);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<2));
    Traffic_Out(11);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<6));
    Traffic_Out(12);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<7));
    Traffic_Out(13);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<8));
    Traffic_Out(3);
    Debug_Dump(GPIOB->DOUT31_0 & ((1<<27)|(1<<26)|(1<<22)));
    Traffic_Out(3);
    Debug_Dump(GPIOB->DOUT31_0 & (1<<26));
    if((GPIOB->DOUT31_0&0x20) == 0){
      UART_OutString("DOUT not friendly\n\r");
    }
  }
}

// use main3 to debug the three input switches
// at this point in ECE319K you need to be writing your own test functions
// modify this program so it tests your Traffic_In  function
//Prints switch inputs to console, 0x4 is Walk, 0x2 is South, 0x1 is West
int main3(void){ // main3
  uint32_t last=0,now;
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Traffic_Init(); // your Lab 4 initialization
  Debug_Init();   // Lab 3 debugging
  UART_Init();
  __enable_irq(); // UART uses interrupts
  UART_OutString("Lab 4, Spring 2025, Step 2. Debug switches\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
  UART_OutString("EID2= "); UART_OutString((char*)EID2); UART_OutString("\n\r");
  while(1){
    now = Traffic_In(); // Your Lab4 input
    if(now != last){ // change
      UART_OutString("Switch= 0x"); UART_OutUHex(now); UART_OutString("\n\r");
      Debug_Dump(now);
    }
    last = now;
    Clock_Delay(800000); // 10ms, to debounce switch
  }
}

// use main4 to debug using your dump
// proving your machine cycles through all states
//Bits 31-28 is the state, the rest are the outputs to the LEDs, in DataBuffer
int main4(void){// main4
uint32_t input;
  Clock_Init80MHz(0);
  LaunchPad_Init();
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
 // set initial state
  Debug_Init();   // Lab 3 debugging
  UART_Init();
  __enable_irq(); // UART uses interrupts
  UART_OutString("Lab 4, Spring 2025, Step 3. Debug FSM cycle\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
  UART_OutString("EID2= "); UART_OutString((char*)EID2); UART_OutString("\n\r");
// initialize your FSM
  SysTick_Init();   // Initialize SysTick for software waits
  while(1){
      // 1) output depending on state using Traffic_Out
      Traffic_Out(currentState);
      // call your Debug_Dump logging your state number and output
      Debug_Dump(GPIOB->DOUT31_0 & ((1<<27)|(1<<26)|(1<<22)|(1<<8)|(1<<7)|(1<<6)|(1<<2)|(1<<1)|(1<<0)) | (currentState<<28));
      // 2) wait depending on state
      SysTick_Wait10ms(FSM[currentState].dwell);
      // 3) hard code this so input always shows all switches pressed
      input = 7;
      // 4) next depends on state and input
      currentState = FSM[currentState].next[input];
  }
}
// use main5 to grade
int main(void){// main5
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Grader_Init(); // execute this line before your code
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
// initialize your FSM
  SysTick_Init();   // Initialize SysTick for software waits
  // initialize your FSM
  Lab4Grader(1); // activate UART, grader and interrupts
  while(1){
      // 1) output depending on state using Traffic_Out
      Traffic_Out(currentState);
      // call your Debug_Dump logging your state number and output
      // 2) wait depending on state
      SysTick_Wait10ms(FSM[currentState].dwell);
      // 3) input from switches
      input = Traffic_In();
      // 4) next depends on state and input
      currentState = FSM[currentState].next[input];
  }
}

int main6(void){// main6 just runs the FSM forever for testing
  Clock_Init80MHz(0);
  LaunchPad_Init();
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
  SysTick_Init();   // Initialize SysTick for software waits
  while(1){
      // 1) output depending on state using Traffic_Out
      Traffic_Out(currentState);
      // call your Debug_Dump logging your state number and output
      // 2) wait depending on state
      SysTick_Wait10ms(FSM[currentState].dwell);
      // 3) input from switches
      input = Traffic_In();
      // 4) next depends on state and input
      currentState = FSM[currentState].next[input];
  }
}
