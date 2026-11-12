Q4. Hexadecimal Counter
Write an Embedded C program to interface 4 LEDs with the 8051 microcontroller and display ASCII numbers
from 0 to FH continuously with a suitable time delay.
#include <reg51.h>
void delay()
{
    int i, j;
    for(i = 0; i < 1000; i++)
        for(j = 0; j < 1000; j++);
}
void main()
{
    while(1)
    {
        P1 = 0x41;   // ASCII value for 'A' (Binary: 0100 0001)
        delay();
        P1 = 0x42;   // ASCII value for 'B' (Binary: 0100 0010)
        delay();
    }
}