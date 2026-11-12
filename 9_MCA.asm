Q9. Displaying a Fixed Message on LCD (LPC2148)
Write an Embedded C program to interface a 16x2 LCD with the LPC2148 microcontroller and display the
message "SVPM" on the first line of the LCD.
#include <lpc214x.h>
#define LCD_DATA (0xF << 16)   // P0.16 - P0.19
#define RS (1 << 20)           // P0.20
#define EN (1 << 21)           // P0.21
void delay_ms(unsigned int count) {
    unsigned int i, j;
    for(i = 0; i < count; i++) {
        for(j = 0; j < 6000; j++);
    }
}
void LCD_Write(unsigned char val, unsigned char rs) {
    IO0PIN = (IO0PIN & ~LCD_DATA) | ((val & 0xF0) << 12);  // High nibble
    if(rs) IO0SET = RS; else IO0CLR = RS;
    IO0SET = EN;  delay_ms(1);  IO0CLR = EN;  delay_ms(1);
    IO0PIN = (IO0PIN & ~LCD_DATA) | ((val & 0x0F) << 16);  // Low nibble
    if(rs) IO0SET = RS; else IO0CLR = RS;
    IO0SET = EN;  delay_ms(1);  IO0CLR = EN;  delay_ms(2);
}
void LCD_Command(unsigned char cmd) { LCD_Write(cmd, 0); }
void LCD_Char(unsigned char dat)    { LCD_Write(dat, 1); }
void LCD_Init(void) {
    delay_ms(20);
    LCD_Command(0x02);   // 4-bit mode
    LCD_Command(0x28);   // 2 lines, 5x7 matrix
    LCD_Command(0x0C);   // Display ON, Cursor OFF
    LCD_Command(0x06);   // Increment cursor
    LCD_Command(0x01);   // Clear display
    delay_ms(2);
}
void LCD_String(char *str) {
    while(*str)
        LCD_Char(*str++);
}
int main(void) {
    IO0DIR |= (LCD_DATA | RS | EN);
    LCD_Init();
    LCD_Command(0x80);   // Cursor to 1st line
    LCD_String("SVPM");
    while(1) { }
}