#ifndef     __LCD_PUTCHAR_A51__
#define     __LCD_PUTCHAR_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdputchar
                PUBLIC  lcdwrdata
                EXTRN   code(lcdbusy)
//-------------------------------------------------------------------------
                NAME    LCD_PUTCHAR
                    
LCD_PUTCHAR_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdputchar                                         *
/*A:tartalmazza a karaktert                                               *
**************************************************************************/
                RSEG    LCD_PUTCHAR_CODE
                USING   0
lcdwrdata:                    
lcdputchar:
                CALL    lcdbusy
                CLR     LCD_RW
                SETB    LCD_RS
                MOV     LCD_PORT,A
                SETB    LCD_E
                NOP
                CLR     LCD_E
                RET
                END
#endif