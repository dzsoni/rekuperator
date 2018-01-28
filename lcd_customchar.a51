#ifndef     __LCD_CUSTOMCHAR_A51__
#define     __LCD_CUSTOMCHAR_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  homero
//-------------------------------------------------------------------------
                NAME    LCD_CUSTOM_CHAR
                    
LCD_CUSTOM_CHAR SEGMENT   CODE
//-------------------------------------------------------------------------
                RSEG    LCD_CUSTOM_CHAR
                USING   0
homero:
      DB    00001110B
      DB    00001010B
      DB    00001010B
      DB    00001110B
      DB    00001110B
      DB    00011111B
      DB    00001110B
      DB    00000000B
                  
                END
#endif