/*
 * Switch.c
 *
 *  Created on: April 14th, 2025
 *      Author: Travis Beach
 */
#include <ti/devices/msp/msp.h>
#include "../inc/LaunchPad.h"
// LaunchPad.h defines all the indices into the PINCM table

//On Port A:
#define UP (1<<28)
#define LEFT (1<<27)
#define DOWN (1<<26)
#define RIGHT (1<<25)

//On Port B:
#define B (1<<17)
#define A (1<<16)
#define Y (1<<13)
#define X (1<<12)


void Switch_Init(void){
  IOMUX->SECCFG.PINCM[PB17INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PB16INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PB13INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PB12INDEX] |= 0x40081;

  IOMUX->SECCFG.PINCM[PA28INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PA27INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PA26INDEX] |= 0x40081;
  IOMUX->SECCFG.PINCM[PA25INDEX] |= 0x40081;
 
}
// return current state of switches
//Returns format of ABCDEFGH (in binary) where A is UP, B is LEFT, C is DOWN, D is RIGHT, E is B, F is A, G is Y, H is X
uint32_t Switch_In(void){
  int PBIn = 0;
  int PAIn = 0;
  int PBMask = (B | A | Y | X);
  int PAMask = (UP | LEFT | DOWN | RIGHT);
  PBIn = (((GPIOB -> DIN31_0) & PBMask)>>12);
  PBIn = ((PBIn & (3<<4))>>2) | (PBIn & 3);
  PAIn = (((GPIOA -> DIN31_0) & PAMask)>>21);
  return PBIn | PAIn; // replace this line
}
