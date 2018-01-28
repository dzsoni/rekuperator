#ifndef     __LCD_CLEAR_A51__
#define     __LCD_CLEAR_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdclear
                EXTRN   code(lcdputcmd)
//-------------------------------------------------------------------------
                NAME    LCD_CLEAR
                    
LCD_CLEAR_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdclear                                           *
/*                  Clear the LCD                                         *
**************************************************************************/
                RSEG    LCD_CLEAR_CODE
                USING   0   
lcdclear:
                MOV     A,#01H
                CALL    lcdputcmd                             
                RET
                END
#endif