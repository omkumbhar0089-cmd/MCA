Q8. Displaying a Fixed Message on LCD (8051)
Write an Embedded C program to interface a 16x2 LCD with the 8051 microcontroller and display the message
"SVPM" on the first line of the LCD.
#include <reg51.h>
sbit RS = P3^2;              // Register Select pin
sbit RW = P3^3;              // Read/Write pin
sbit EN = P3^4;              // Enable pin
#define LCD_DATA_PORT P2     // Data pins on Port 2
void delay_ms(unsigned int ms) {
    unsigned int i, j;
    for (i = 0; i < ms; i++) {
        for (j = 0; j < 1275; j++);   // Adjust for clock frequency
    }
}
void lcd_cmd(unsigned char command) {
    LCD_DATA_PORT = command;
    RS = 0;  RW = 0;         // Command mode, write mode
    EN = 1;
    delay_ms(1);
    EN = 0;
}
void lcd_data(unsigned char dat) {
    LCD_DATA_PORT = dat;
    RS = 1;  RW = 0;         // Data mode, write mode
    EN = 1;
    delay_ms(1);
    EN = 0;
}
void lcd_init() {
    delay_ms(15);            // Power-up delay
    lcd_cmd(0x38);           // 8-bit mode, 2 lines, 5x7 font
    delay_ms(5);
    lcd_cmd(0x0C);           // Display ON, Cursor OFF
    delay_ms(5);
    lcd_cmd(0x06);           // Increment cursor
    delay_ms(5);
    lcd_cmd(0x01);           // Clear display
    delay_ms(5);
}
void lcd_string(unsigned char *str) {
    while (*str != '\0') {
        lcd_data(*str);
        str++;
    }
}
void main() {
    lcd_init();
    lcd_cmd(0x80);           // Beginning of first line
    lcd_string("SVPM");
    while (1);
}