Q2. Binary Up-Counter
Write an Embedded C program to interface 8 LEDs with Port 1 of the 8051 microcontroller and display an 8-bit
binary up-counter from 00H to FFH continuously with a suitable time delay.
#include <reg51.h>
void delay(void)
{
    unsigned int i, j;
    for(i = 0; i < 200; i++)
    {
        for(j = 0; j < 1275; j++);
    }
}
void main(void)
{
    unsigned int count;
    while(1)
    {
        for(count = 0; count <= 255; count++)
        {
            P1 = count;
            delay();
        }
    }
}