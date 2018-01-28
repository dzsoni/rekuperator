#ifndef     __LCD_BUSY_A51__
#define     __LCD_BUSY_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdbusy
//-------------------------------------------------------------------------
                NAME    LCD_BUSY
                    
LCD_BUSY_CODE   SEGMENT   CODE

/**************************************************************************
/*                     lcd_busy                                           *
/*                  Lcd busy check                                        *
**************************************************************************/
                RSEG    LCD_BUSY_CODE
                USING   0   
lcdbusy:
                MOV     LCD_PORT,#00h       //set lcd_datda_port to input
                CLR     LCD_E
                CLR     LCD_RS              //Set LCD for command mode
                SETB    LCD_RW              //read busy flag
                NOP                         //40ns R/W and RS Setup time
                SETB    LCD_E               //E-Line High
                NOP                         //min data output delay time
                JB      LCD_DB7,lcdbusy
lcdbusy1:       
                CLR     LCD_E
                CLR     LCD_RW              //Read
                MOV     LCD_PORT,#0FFh      //set all port to output
                RET
                END
#endif