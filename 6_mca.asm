//Q6. Relay Interfacing - ON/OFF Operation
//Write an Embedded C program to interface a relay with the 8051 microcontroller using Port 1. Turn the relay
//ON and OFF alternately with a suitable time delay.


#include <reg51.h>   // Header file for 8051
sbit RELAY = P1^0;   // Relay connected to P1.0
// Simple delay function
void Delay()
{
    unsigned int i, j;
    for(i = 0; i < 100; i++)
    {
        for(j = 0; j < 1000; j++);
    }
}
void main()
{
    while(1)
    {
    }
}
        RELAY = 1;   // Turn Relay ON
        Delay();     // Wait
        RELAY = 0;   // Turn Relay OFF
        Delay();     // Wait
    }
}