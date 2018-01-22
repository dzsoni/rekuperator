#ifndef     __LCD_BUSY_A51__
#define     __LCD_BUSY_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcd_BUSY
//-------------------------------------------------------------------------
                NAME    LCD_BUSY
                    
LCD_BUSY_CODE   SEGMENT   CODE

/**************************************************************************
/*                     lcd_busy                                           *
/*                  Lcd busy check                                        *
**************************************************************************/
                RSEG    LCD_BUSY_CODE
                USING   0   
lcd_busy:            
                RET       
                END
#endif