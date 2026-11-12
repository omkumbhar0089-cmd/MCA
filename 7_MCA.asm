Q7. Buzzer Interfacing - Beep Operation
Write an Embedded C program to interface a buzzer with the 8051 microcontroller. Generate a continuous
ON/OFF beep sound with a suitable time delay.
#include <reg51.h>
sbit BUZZER = P1^1;
void delay(unsigned int time)
{
    unsigned int i, j;
    for(i = 0; i < time; i++)
        for(j = 0; j < 120; j++);
}
void main(void)
{
    while(1)
    {
        BUZZER = 1;
        delay(1000);
        BUZZER = 0;
        delay(1000);
    }
}