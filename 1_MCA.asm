//Q1. LED Flashing
//Write an Embedded C program to interface LED with Port 1.1 of the 8051 microcontroller and blink LED
//continuously with a suitable time delay.
#include <reg51.h>
sbit LED = P1^1;
void delay(void)
{
    unsigned int i, j;
    for(i = 0; i < 500; i++)
    {
        for(j = 0; j < 1275; j++);
    }
}
void main(void)
{
    while(1)
    {
        LED = 1;
        delay();
        LED = 0;
        delay();
    }
}