/* main.c
 * your name
 * date
 */

#include <ti/devices/msp/msp.h>
/*
;***** Integration subroutine *********************
;Determines the integral of elements in a variable-length array
;Assumes the points in the array were measured 0.1 sec apart
;Each element of the array is a 16-bit signed number
;The array has a termination code of -32768
;The -32768 is not a data point in the array
;Input:   R0 has a pointer to the array of 16-bit numbers
;Output:  return R0 is returned as the integral of data elements in the array 
;The integral is the sum of all data points divided by 10
;First calculate the sum, and then divide the sum by 10
;Do not worry about overflow during the additions
;Invariables: You must not permanently modify registers R4 to R11, and LR
;Error conditions: none
;Test cases
;Array4 DCW 35,144,25,36,-32768              ;I = (35+144+25+36)/10 = 24
;Array5 DCW 9,13,-4,-5,100,-2000,7000,-32768 ;I = (9+13-4-5+100-2000+7000)/10 = 511
;Array6 DCW 20000,25000,25000,30000,20000,25000,25000,30000,20000,25000,25000,30000,20000,25000,25000,30000,-32768                  ;I = 40000
;Array7 DCW -20000,-25000,-25000,-30000,-20000,-25000,-25000,-30000,-20000,-25000,-25000,-30000,-20000,-25000,-25000,-30000,-32768  ;I = -40000
;Array8 DCW -32768                           ;I = 0
*/

int16_t Arr1[5] = {35,144,25,36,-32768};
int16_t Arr2[8] = {9,13,-4,-5,100,-2000,7000,-32768};

int32_t Integration(const int16_t *buffer){
    int integ = 0;
    while(*buffer != -32768){
        integ += *buffer;
        buffer++;
    }
    integ = integ / 10;
    return integ;   // replace this line
}    


int main(void){
  int x = Integration(Arr1);
  int y = Integration(Arr2);
  while(1){

  }
}


