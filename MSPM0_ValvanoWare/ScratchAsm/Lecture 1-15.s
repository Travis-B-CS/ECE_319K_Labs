/*
Travis Beach
1/15/25
*/

// One line comments start with a double slash
/* To make comments spanning multiple lines start with a slash star and end with a star slash*/

// Global Variables are stored in RAM
       .data
       .align 2      // all declared entities are 2^2 aligned
Score: .byte 95
       .align
Xvalues: .long 234567, -123456, -65, 125, 0       // array is separated by commas, I used 0 as a sentinel
       .align
Sum:   .short -1025
       .align
value: .long 0x1E240        // this is decimal 123456 in hex
Result: .space 2

//Constants and Code are stored in ROM
       .text
       .thumb
       .align 2
Vowels: .byte 'a', 'e', 'i', 'o', 'u'      //this array has an implicit sentinel I know there are only 5 vowels so I didn't use one
       .align
Filter: .short 1096, 2025, 4245, -1  //now my sentinel is an explicit -1, they are free to be chosen implicitly or explicitly, also don't need a .align because 8 bytes which is a multiple of 4 bytes
Name:  .ascii "John Doe" //.ascii makes a null-termingated ascii string (Dr. Y had us use .string but that caused errors)

       .global main
main: 
       // Typically setup here

       //Code to Increment Score by 2
       LDR R0, =Score       //Loads address of Score
       LDRB R1, [R0]        //LDRB to only load 8 bits, LDR is 32 bits
       ADDS R1, R1, #2      //Adds 2 to Score
       STRB R1, [R0]        //Stores Score in orginal location

       //Decrement Xvalues[2] by 1
       LDR R0, =Xvalues
       LDR R1, [R0, #8]     //We want second element so offset of 8
       SUBS R1, R1, #1
       STR R1, [R0, #8] 
loop:  
       // Functionality of Embedded System is here in loop
       B loop

       .end