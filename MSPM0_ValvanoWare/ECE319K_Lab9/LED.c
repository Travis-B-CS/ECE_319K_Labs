/*
 * LED.c
 *
 *  Created on: April 14th, 2025
 *  Author: Travis Beach
 */
#include <ti/devices/msp/msp.h>
#include "../inc/LaunchPad.h"
// LaunchPad.h defines all the indices into the PINCM table

#define GREENLED (1<<19)
#define YELLOWLED (1<<20)
#define REDLED1 (1<<23)
#define REDLED2 (1<<24)

// initialize your LEDs
void LED_Init(void){
    IOMUX->SECCFG.PINCM[PB19INDEX] |= 0x81;
    IOMUX->SECCFG.PINCM[PB20INDEX] |= 0x81;
    IOMUX->SECCFG.PINCM[PB23INDEX] |= 0x81;
    IOMUX->SECCFG.PINCM[PB24INDEX] |= 0x81;
    GPIOB->DOE31_0 |= (GREENLED | YELLOWLED | REDLED1 | REDLED2);
}

// data specifies which LED to turn on
// data is in the form of ABCD (binary bits), A is REDLED2, B is REDLED1, C is YELLOWLED, D is GREENLED
void LED_On(uint32_t data){
    if((data & 1) == 1){
        GPIOB->DOUTSET31_0 = GREENLED;
    }
    if((data & 2) == 2){
        GPIOB->DOUTSET31_0 = YELLOWLED;
    }
    if((data & 4) == 4){
        GPIOB->DOUTSET31_0 = REDLED1;
    }
    if((data & 8) == 8){
        GPIOB->DOUTSET31_0 = REDLED2;
    }
}

// data specifies which LED to turn off
// data is in the form of ABCD (binary bits), A is REDLED2, B is REDLED1, C is YELLOWLED, D is GREENLED
void LED_Off(uint32_t data){
    if((data & 1) == 1){
        GPIOB->DOUTCLR31_0 = GREENLED;
    }
    if((data & 2) == 2){
        GPIOB->DOUTCLR31_0 = YELLOWLED;
    }
    if((data & 4) == 4){
        GPIOB->DOUTCLR31_0 = REDLED1;
    }
    if((data & 8) == 8){
        GPIOB->DOUTCLR31_0 = REDLED2;
    }
    // use DOUTCLR31_0 register so it does not interfere with other GPIO

}

// data specifies which LED to toggle
// data is in the form of ABCD (binary bits), A is REDLED2, B is REDLED1, C is YELLOWLED, D is GREENLED
void LED_Toggle(uint32_t data){
    if((data & 1) == 1){
        GPIOB->DOUTTGL31_0 = GREENLED;
    }
    if((data & 2) == 2){
        GPIOB->DOUTTGL31_0 = YELLOWLED;
    }
    if((data & 4) == 4){
        GPIOB->DOUTTGL31_0 = REDLED1;
    }
    if((data & 8) == 8){
        GPIOB->DOUTTGL31_0 = REDLED2;
    }
    // use DOUTTGL31_0 register so it does not interfere with other GPIO
 
}
