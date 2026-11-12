Q3. BCD Counter
Write an Embedded C program to interface 4 LEDs with the 8051 microcontroller and display decimal numbers
from 0 to 9 in BCD format. Repeat the counting continuously.
#include <reg51.h>
void delay(void)
{
    unsigned int i, j;
    for(i = 0; i < 500; i++)
        for(j = 0; j < 100; j++);
}
void main(void)
{
    unsigned char digit;
    unsigned char bcd;
    while(1)
    {
        for(digit = 0; digit <= 9; digit++)
        {
            bcd = digit;
            P1 = bcd;
            delay();
        }
    }
}