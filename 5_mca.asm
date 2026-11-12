Q5. Non-Multiplexed 7-Segment Display
Write an Embedded C program to interface non-multiplexed common-cathode 7-segment displays with the
8051 microcontroller and display decimal numbers from 0 to F continuously with a suitable time delay.
#include <reg51.h>
void delay(void)
{
    unsigned int i, j;
    for(i = 0; i < 100; i++)
        for(j = 0; j < 1275; j++);
}
void main(void)
{
    unsigned char seg[16] = {
        0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07,
        0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71
    };
    unsigned char x;
    P1 = 0x00;
    while(1)
    {
        for(x = 0; x < 16; x++)
        {
            P1 = seg[x];
            delay();
        }
    }
}