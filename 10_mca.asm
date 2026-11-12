Q10. LED Flashing (LPC2148)
Write an Embedded C program to interface a LED with the LPC2148 microcontroller and blink LED
continuously with a suitable time delay.
#include <LPC214X.H>
void delay(unsigned int count)
{
    unsigned int i, j;
    for (i = 0; i < count; i++)
    {
        for (j = 0; j < 5000; j++)
        {
        }
    }
}
int main(void)
{
    PINSEL2 = 0x00000000;
    IO1DIR |= (1 << 16);
    while (1)
    {
        IO1SET = (1 << 16);
        delay(1000);
        IO1CLR = (1 << 16);
        delay(1000);
    }
    return 0;
}