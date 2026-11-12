Q11. Displaying Time Using On-Chip RTC (LPC2148)
Write an Embedded C program to initialize the on-chip RTC of the LPC2148 microcontroller and display the
current time (HH:MM:SS) on a 16x2 LCD.
#include <lpc214x.h>
#define LCD_DATA (0xF << 16)    // P0.16 - P0.19
#define RS (1 << 20)            // P0.20
#define EN (1 << 21)            // P0.21
volatile unsigned char flag = 0;
void rtc_int(void) __irq {
    ILR = 0x01;                 // Clear RTC interrupt flag
    flag = 1;
    VICVectAddr = 0x00000000;   // Acknowledge interrupt
}
void init_rtc(void) {
    ILR = 0x01;
    CCR = 0x13;                 // Reset clock
    CCR = 0x11;                 // Enable clock
    CIIR = 0x01;                // Interrupt every second
    HOUR = 12; MIN = 0; SEC = 0;
    VICIntEnable = (1 << 13); // Enable RTC interrupt
    VICVectCntl0 = (0x20 | 13);
    VICVectAddr0 = (unsigned long)rtc_int;
}
void delay_ms(unsigned int count) {
    unsigned int i, j;
    for(i = 0; i < count; i++)
        for(j = 0; j < 6000; j++);
}
void lcd_write(unsigned char val, unsigned char rs) {
    IO0PIN = (IO0PIN & ~LCD_DATA) | ((val & 0xF0) << 12); // High nibble
    if(rs) IO0SET = RS; else IO0CLR = RS;
    IO0SET = EN; delay_ms(1); IO0CLR = EN; delay_ms(1);
    IO0PIN = (IO0PIN & ~LCD_DATA) | ((val & 0x0F) << 16); // Low nibble
    if(rs) IO0SET = RS; else IO0CLR = RS;
    IO0SET = EN; delay_ms(1); IO0CLR = EN; delay_ms(2);
}
void lcd_command(unsigned char cmd) { lcd_write(cmd, 0); }
void lcd_data(unsigned char dat) { lcd_write(dat, 1); }
void init_lcd(void) {
    IO0DIR |= (LCD_DATA | RS | EN);
    delay_ms(20);
    lcd_command(0x02); lcd_command(0x28);    lcd_command(0x0C);
    lcd_command(0x06); lcd_command(0x01);
    delay_ms(2);
}
void lcd_string(char *str) {
    while(*str)
        lcd_data(*str++);
}
int main(void) {
    init_lcd();
    init_rtc();
    lcd_command(0x80);         // First row, first column
    lcd_string("Time: ");
    while (1) {
        if (flag) {
            flag = 0;
            lcd_command(0x86);   // After "Time: "
            lcd_data((HOUR / 10) + '0'); lcd_data((HOUR % 10) + '0');
            lcd_data(':');
            lcd_data((MIN / 10) + '0');   lcd_data((MIN % 10) + '0');
            lcd_data(':');
            lcd_data((SEC / 10) + '0');   lcd_data((SEC % 10) + '0');
        }
    }
}