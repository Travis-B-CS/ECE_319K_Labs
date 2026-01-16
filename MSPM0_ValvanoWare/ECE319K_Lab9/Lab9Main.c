// Lab9Main.c
// Runs on MSPM0G3507
// Lab 9 ECE319K
// Travis Beach
// Last Modified: 04/14/2025


#include <stdio.h>
#include <stdint.h>
#include <ti/devices/msp/msp.h>
#include "../inc/ST7735.h"
#include "../inc/Clock.h"
#include "../inc/LaunchPad.h"
#include "../inc/TExaS.h"
#include "../inc/Timer.h"
#include "../inc/ADC1.h"
#include "../inc/ADC.h"
#include "../inc/EdgeTriggered.h"
#include "../inc/DAC5.h"
#include "../inc/Arabic.h"
#include "SmallFont.h"
#include "LED.h"
#include "Switch.h"
#include "Sound.h"
#include "images/images.h"

// ****note to ECE319K students****
// the data sheet says the ADC does not work when clock is 80 MHz
// however, the ADC seems to work on my boards at 80 MHz
// I suggest you try 80MHz, but if it doesn't work, switch to 40MHz
void PLL_Init(void){ // set phase lock loop (PLL)
  // Clock_Init40MHz(); // run this line for 40MHz
  Clock_Init80MHz(0);   // run this line for 80MHz
}

Arabic_t ArabicAlphabet[]={
alif,ayh,baa,daad,daal,dhaa,dhaal,faa,ghayh,haa,ha,jeem,kaaf,khaa,laam,meem,noon,qaaf,raa,saad,seen,sheen,ta,thaa,twe,waaw,yaa,zaa,space,dot,null
};
Arabic_t Hello[]={alif,baa,ha,raa,meem,null}; // hello
Arabic_t WeAreHonoredByYourPresence[]={alif,noon,waaw,ta,faa,raa,sheen,null}; // we are honored by your presence
int main0(void){ // main 0, demonstrate Arabic output
  Clock_Init80MHz(0);
  LaunchPad_Init();
  ST7735_InitR(INITR_REDTAB);
  ST7735_FillScreen(ST7735_WHITE);
  Arabic_SetCursor(0,15);
  Arabic_OutString(Hello);
  Arabic_SetCursor(0,31);
  Arabic_OutString(WeAreHonoredByYourPresence);
  Arabic_SetCursor(0,63);
  Arabic_OutString(ArabicAlphabet);
  while(1){
  }
}
uint32_t M=1;
uint32_t Random32(void){
  M = 1664525*M+1013904223;
  return M;
}
uint32_t Random(uint32_t n){
  return (Random32()>>16)%n;
}

struct movingRectangle {
  int posX;
  int posY;
  int oldX;
  int oldY;
  int32_t velocityX;
  int32_t velocityY;
  int width;
  int height;
  int color;
};

typedef struct movingRectangle Rec_t;

Rec_t ball = {59, 75, 0, 0, 3, 3, 10, 10, ST7735_WHITE};

Rec_t paddle1 = {48, 0, 0, 0, 0, 0, 32, 8, ST7735_WHITE};
Rec_t paddle2 = {48, 152, 0, 0, 0, 0, 32, 8, ST7735_WHITE};

uint32_t joystickData, slidepotData, convertedJoystickData, convertedSlidepotData, endFlag, spanishFlag, englishFlag, redrawFlag;

uint32_t timeCNT = 0;
uint32_t pauseFlag = 0;

uint32_t player1Score = 0;
uint32_t player2Score = 0;
int32_t hitCNT = 10;
const int32_t sinTable[22] = {0, 7, 15, 22, 29, 37, 43, 50, 56, 62, 68, 73, 78, 83, 87, 90, 93, 95, 97, 98, 99, 100};
const int32_t cosTable[22] = {100, 99, 98, 97, 95, 93, 90, 87, 83, 78, 73, 68, 62, 56, 50, 43, 37, 29, 22, 15, 7, 0};
int32_t  velocityIndex;
int32_t  directionX = 1;

void updateBallPositions(void){
  ball.oldX = ball.posX;
  ball.oldY = ball.posY;
  ball.posX += (ball.velocityX);
  ball.posY += (ball.velocityY);
  if(ball.posX >= (128 - ball.width)){
    ball.velocityX *= -1;
    Sound_Bounce();
    ball.posX -= 7;
  }
  if(ball.posX <= 0){
    ball.velocityX *= -1;
    Sound_Bounce();
    ball.posX += 7;
  }
  if(ball.posY >= (160 - ball.height) || (ball.posY + ball.height + paddle2.height >=160 && (ball.posX + ball.width >= paddle2.posX && ball.posX <= paddle2.posX + paddle2.width))){
    if(ball.posX + ball.width >= paddle2.posX && ball.posX <= paddle2.posX + paddle2.width){
      hitCNT++;
      Sound_Bounce();
      ball.posY -= 7;
      velocityIndex = ((ball.posX + (ball.width/2)) - (paddle2.posX + (paddle2.width/2)));
      if(velocityIndex < 0){
        velocityIndex *= -1;
        directionX = -1;
      } else {
        directionX = 1;
      }
      ball.velocityX = (5 * ((sinTable[velocityIndex])) * (hitCNT) * directionX)/1000;
      ball.velocityY = (-5 * ((cosTable[velocityIndex])) * (hitCNT))/1000;
      if(ball.velocityY == 0){
        ball.velocityY = -1;
      }
    } else {
      ball.velocityY = -3;
      if(ball.velocityX < 1){
        ball.velocityX = -3;
      }
      else{
        ball.velocityX = 3;
      }
      Sound_Score();
      player1Score++;
      ball.posX = (128-ball.width)/2;
      ball.posY = (160-ball.height)/2;
      hitCNT = 10;
    }
  }
  if(ball.posY <= 0 || (ball.posY - paddle1.height <= 0 && (ball.posX + ball.width >= paddle1.posX && ball.posX <= paddle1.posX + paddle1.width))){
    if(ball.posX + ball.width >= paddle1.posX && ball.posX <= paddle1.posX + paddle1.width){
      hitCNT++;
      Sound_Bounce();
      ball.posY += 7;
      velocityIndex = ((ball.posX + (ball.width/2)) - (paddle1.posX + (paddle1.width/2)));
      if(velocityIndex < 0){
        velocityIndex *= -1;
        directionX = -1;
      } else {
        directionX = 1;
      }
      ball.velocityX = (5 * ((sinTable[velocityIndex])) * (hitCNT) * directionX)/1000;
      ball.velocityY = (5 * ((cosTable[velocityIndex])) * (hitCNT))/1000;
      if(ball.velocityY == 0){
        ball.velocityY = 1;
      }
    } else {
      ball.velocityY = 3;
      if(ball.velocityX < 1){
        ball.velocityX = -3;
      }
      else{
        ball.velocityX = 3;
      }
      Sound_Score();
      player2Score++;
      ball.posX = (128-ball.width)/2;
      ball.posY = (160-ball.height)/2;
      hitCNT = 10;
    }
  }
}

void updatePaddlesPositions(void){
  paddle1.oldX = paddle1.posX;
  paddle1.oldY = paddle1.posY;
  paddle2.oldX = paddle2.posX;
  paddle2.oldY = paddle2.posY;
  ADC_InDual(ADC1,&joystickData,&slidepotData);
  joystickData = 4095 - joystickData; //Otherwise joystick is inverted
  convertedSlidepotData = Convert(slidepotData);
  convertedJoystickData = Convert(joystickData);
  paddle1.posX = convertedJoystickData - paddle1.width/2;
  paddle2.posX = convertedSlidepotData - paddle2.width/2;
}

void languageSelect(void){
  for(int i = 0; i < 100; i++){
    int langInput = Switch_In();
    if ((langInput & ((1<<4)|(1<<2))) != 0) {
      englishFlag = 1;
      break;
    }
    else if((langInput & ((1<<6)|(1<<1))) != 0){
      spanishFlag = 1;
      break;
    }
    i = 0;
  }
}

void outputStartingScreen(void){
  ST7735_SetCursor(0, 0);
  printf("PONG\n\nPress RIGHT or A\nfor English\n\nPresione LEFT o Y\npara Espa\xA4ol\n");
}

void outputInstructions(void){
  ST7735_FillScreen(ST7735_BLACK);
  ST7735_SetCursor(0, 0);
  if (englishFlag == 1) {
  printf("Player 1 use\njoystick (horizontal\nonly)\n\nPlayer 2 use\nslidepot\n\nFirst to 5\npoints wins\n\nGood Luck!");
  Clock_Delay1ms(8000); //wait 8 secs
  }
  else if (spanishFlag == 1) {
  printf("El jugador 1 usa\nel joystick (solo\nhorizontal)\n\nEl jugador 2\nusa slidepot\n\nEl primero que\nllegue a 5\npuntos gana\n\nBuena suerte!");
  Clock_Delay1ms(8000); //wait 8 secs
  }
}

void clearOldSprites(void){
  ST7735_FillRect(ball.oldX, ball.oldY, ball.width, ball.height, 0);
  ST7735_FillRect(paddle1.oldX, paddle1.oldY, paddle1.width, paddle1.height, 0);
  ST7735_FillRect(paddle2.oldX, paddle2.oldY, paddle2.width, paddle2.height, 0);
}

void drawNewSprites(void){
  ST7735_FillRect(paddle1.posX, paddle1.posY, paddle1.width, paddle1.height, paddle1.color);
  ST7735_FillRect(paddle2.posX, paddle2.posY, paddle2.width, paddle2.height, paddle2.color);
  ST7735_FillRect(ball.posX, ball.posY, ball.width, ball.height, ball.color);
}


//Edge Triggered Interrupts set up for Play/Pause with built in S2 PB21
void GROUP1_IRQHandler(void){
  if(endFlag == 0){
    LED_Toggle(15); // toggle all LEDS
    if(pauseFlag == 0){
     TimerG12_IntArm(1,2); //Stops Timer
     pauseFlag = 1;
     Clock_Delay1ms(100);
     /*ST7735_FillScreen(ST7735_BLACK);
     ST7735_SetCursor(0, 0);
     if(englishFlag==1){
        printf("PAUSED\n");
        printf("Player 1 Score = %d\n\nPlayer 2 Score = %d", player1Score, player2Score);
      }
      else if(spanishFlag==1){
        printf("PAUSA\n");
        printf("Puntuacion del\njugador 1 = %d\n\nPuntuacion del\njugador 2 = %d", player1Score, player2Score);
      }*/
    }
    else if(pauseFlag == 1){
      /*ST7735_FillScreen(ST7735_BLACK);
      ST7735_SetCursor(0, 0);*/
      TimerG12_IntArm(80000000/30,2); //Restarts Timer
      pauseFlag = 0;
    }
   }
   GPIOB->CPU_INT.ICLR = (1<<21);   // clear bit 21
}

// games  engine runs at 30Hz
void TIMG12_IRQHandler(void){uint32_t pos,msg;
  if((TIMG12->CPU_INT.IIDX) == 1){ // this will acknowledge
    GPIOB->DOUTTGL31_0 = GREEN; // toggle PB27 (minimally intrusive debugging)
    GPIOB->DOUTTGL31_0 = GREEN; // toggle PB27 (minimally intrusive debugging)
// game engine goes here
    // 1) sample slide pot
    // 2) read input switches
    // 3) move sprites
    // 4) start sounds
    // 5) set semaphore
    // NO LCD OUTPUT IN INTERRUPT SERVICE ROUTINES
    timeCNT++;
    if((timeCNT % 3) == 0){
    //~10Hz
    timeCNT++;
    updateBallPositions();
    updatePaddlesPositions();
    redrawFlag = 1;
    }
    if(player1Score == 5 || player2Score == 5){
      endFlag = 1;
    }
    GPIOB->DOUTTGL31_0 = GREEN; // toggle PB27 (minimally intrusive debugging)
  }
}
uint8_t TExaS_LaunchPadLogicPB27PB26(void){
  return (0x80|((GPIOB->DOUT31_0>>26)&0x03));
}

typedef enum {English, Spanish, Portuguese, French} Language_t;
Language_t myLanguage=English;
typedef enum {HELLO, GOODBYE, LANGUAGE} phrase_t;
const char Hello_English[] ="Hello";
const char Hello_Spanish[] ="\xADHola!";
const char Hello_Portuguese[] = "Ol\xA0";
const char Hello_French[] ="All\x83";
const char Goodbye_English[]="Goodbye";
const char Goodbye_Spanish[]="Adi\xA2s";
const char Goodbye_Portuguese[] = "Tchau";
const char Goodbye_French[] = "Au revoir";
const char Language_English[]="English";
const char Language_Spanish[]="Espa\xA4ol";
const char Language_Portuguese[]="Portugu\x88s";
const char Language_French[]="Fran\x87" "ais";
const char *Phrases[3][4]={
  {Hello_English,Hello_Spanish,Hello_Portuguese,Hello_French},
  {Goodbye_English,Goodbye_Spanish,Goodbye_Portuguese,Goodbye_French},
  {Language_English,Language_Spanish,Language_Portuguese,Language_French}
};
// use main1 to observe special characters
int main1(void){ // main1
    char l;
  __disable_irq();
  PLL_Init(); // set bus speed
  LaunchPad_Init();
  ST7735_InitPrintf();
  ST7735_FillScreen(0x0000);            // set screen to black
  for(phrase_t myPhrase=HELLO; myPhrase<= GOODBYE; myPhrase++){
    for(Language_t myL=English; myL<= French; myL++){
         ST7735_OutString((char *)Phrases[LANGUAGE][myL]);
      ST7735_OutChar(' ');
         ST7735_OutString((char *)Phrases[myPhrase][myL]);
      ST7735_OutChar(13);
    }
  }
  Clock_Delay1ms(3000);
  ST7735_FillScreen(0x0000);       // set screen to black
  l = 128;
  while(1){
    Clock_Delay1ms(2000);
    for(int j=0; j < 3; j++){
      for(int i=0;i<16;i++){
        ST7735_SetCursor(7*j+0,i);
        ST7735_OutUDec(l);
        ST7735_OutChar(' ');
        ST7735_OutChar(' ');
        ST7735_SetCursor(7*j+4,i);
        ST7735_OutChar(l);
        l++;
      }
    }
  }
}

// use main2 to observe graphics
int main2(void){ // main2
  __disable_irq();
  PLL_Init(); // set bus speed
  LaunchPad_Init();
  ST7735_InitPrintf();
    //note: if you colors are weird, see different options for
    // ST7735_InitR(INITR_REDTAB); inside ST7735_InitPrintf()
  ST7735_FillScreen(ST7735_BLACK);
  ST7735_DrawBitmap(22, 159, PlayerShip0, 18,8); // player ship bottom
  ST7735_DrawBitmap(53, 151, Bunker0, 18,5);
  ST7735_DrawBitmap(42, 159, PlayerShip1, 18,8); // player ship bottom
  ST7735_DrawBitmap(62, 159, PlayerShip2, 18,8); // player ship bottom
  ST7735_DrawBitmap(82, 159, PlayerShip3, 18,8); // player ship bottom
  ST7735_DrawBitmap(0, 9, SmallEnemy10pointA, 16,10);
  ST7735_DrawBitmap(20,9, SmallEnemy10pointB, 16,10);
  ST7735_DrawBitmap(40, 9, SmallEnemy20pointA, 16,10);
  ST7735_DrawBitmap(60, 9, SmallEnemy20pointB, 16,10);
  ST7735_DrawBitmap(80, 9, SmallEnemy30pointA, 16,10);

  for(uint32_t t=500;t>0;t=t-5){
    SmallFont_OutVertical(t,104,6); // top left
    Clock_Delay1ms(50);              // delay 50 msec
  }
  ST7735_FillScreen(0x0000);   // set screen to black
  ST7735_SetCursor(1, 1);
  ST7735_OutString("GAME OVER");
  ST7735_SetCursor(1, 2);
  ST7735_OutString("Nice try,");
  ST7735_SetCursor(1, 3);
  ST7735_OutString("Earthling!");
  ST7735_SetCursor(2, 4);
  ST7735_OutUDec(1234);
  while(1){
  }
}

// use main3 to test switches and LEDs
int main3(void){ // main3
  __disable_irq();
  PLL_Init(); // set bus speed
  LaunchPad_Init();
  Switch_Init(); // initialize switches
  LED_Init(); // initialize LED
  int testGreen, testYellow, testRed1, testRed2;
  testGreen = 1;
  testYellow = 2;
  testRed1 = 4;
  testRed2 = 8;
  int testSwitches;
  LED_On(testGreen);
  LED_On(testYellow);
  LED_On(testRed1);
  LED_On(testRed2);
  LED_Off(testGreen);
  LED_Off(testYellow);
  LED_Off(testRed1);
  LED_Off(testRed2);
  LED_Toggle(testGreen);
  LED_Toggle(testYellow);
  LED_Toggle(testRed1);
  LED_Toggle(testRed2);
  LED_Toggle(testGreen);
  LED_Toggle(testYellow);
  LED_Toggle(testRed1);
  LED_Toggle(testRed2);
  testSwitches = Switch_In();
  while(1){
    LED_Toggle(testGreen);
    Clock_Delay1ms(100);
    LED_Toggle(testYellow);
    Clock_Delay1ms(100);
    LED_Toggle(testRed1);
    Clock_Delay1ms(100);
    LED_Toggle(testRed2);
    Clock_Delay1ms(100);
    //The above delay cycle makes a nice loking flashing strip    
  }
}

// use main4 to test sound outputs
int main4(void){ uint32_t last=0,now;
  __disable_irq();
  PLL_Init(); // set bus speed
  LaunchPad_Init();
  Switch_Init(); // initialize switches
  LED_Init(); // initialize LED
  Sound_Init();  // initialize sound
  TExaS_Init(ADC0,6,0); // ADC1 channel 6 is PB20, TExaS scope
  __enable_irq();
  while(1){
    now = Switch_In(); // one of your buttons
    if((last == 0)&&(now == 1)){
      Sound_Bounce(); // call one of your sounds
    }
    if((last == 0)&&(now == 2)){
      Sound_Score(); // call one of your sounds
    }
    if((last == 0)&&(now == 4)){
      Sound_End(); // call one of your sounds
    }
    if((last == 0)&&(now == 8)){
      Sound_Fastinvader1(); // call one of your sounds
    }
    last = 0;
    // modify this to test all your sounds
  }
}


// ALL ST7735 OUTPUT MUST OCCUR IN MAIN
int main(void){ // final main
  __disable_irq();
  PLL_Init(); // set bus speed
  LaunchPad_Init();
  ST7735_InitPrintf();
    //note: if you colors are weird, see different options for
    // ST7735_InitR(INITR_REDTAB); inside ST7735_InitPrintf()
  ST7735_FillScreen(ST7735_BLACK);
  Switch_Init(); // initialize switches
  LED_Init();    // initialize LED
  Sound_Init();  // initialize sound
  TExaS_Init(0,0,&TExaS_LaunchPadLogicPB27PB26); // PB27 and PB26
  ADC_InitDual(ADC1,1,5,ADCVREF_VDDA);
  EdgeTriggered_Init();
  outputStartingScreen();
  languageSelect();
  outputInstructions();
  ST7735_FillScreen(ST7735_BLACK);
  TimerG12_IntArm(80000000/30,2); // initialize interrupts on TimerG12 at 30 Hz
  __enable_irq();
  while(1){
    if(redrawFlag == 1){
      //update display at ~10Hz
      redrawFlag = 0;
      clearOldSprites();
      drawNewSprites();
    }
    if(endFlag == 1){
      //Game is over output scores/sounds/LEDs
      TimerG12_IntArm(1,2); //Stops Timer
      Sound_End();
      ST7735_FillScreen(ST7735_BLACK);
      ST7735_SetCursor(0, 0);
      if(englishFlag==1){
        printf("Player 1 Score = %d\n\nPlayer 2 Score = %d", player1Score, player2Score);
      }
      else if(spanishFlag==1){
        printf("Puntuacion del\njugador 1 = %d\n\nPuntuacion del\njugador 2 = %d", player1Score, player2Score);
      }
      while(1){
        //Game is over cycle LEDs
        LED_Toggle(1);
        Clock_Delay1ms(100);
        LED_Toggle(2);
        Clock_Delay1ms(100);
        LED_Toggle(4);
        Clock_Delay1ms(100);
        LED_Toggle(8);
        Clock_Delay1ms(100);
      }
    }
  }
}