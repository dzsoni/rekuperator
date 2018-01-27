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
                MOV     LCD_DATA_P,#00h     //set lcd_datda_port to input
                CLR     LCD_RS              //Set LCD for command mode
                SETB    LCD_RW              //read busy flag
                NOP                         //40ns R/W and RS Setup time
                SETB    LCD_E               //E-Line High
                NOP                         //min data output delay time
                
                
                
                
                
/*  
                              ;}

            banksel     LCD_CTRL                ;set  bank 0
            bcf         LCD_CTRL,LCD_RS         ;Set LCD for command mode
            bsf         LCD_CTRL,LCD_RW         ;Setup to read busy flag
            nop                                 ;40ns R/W and RS Setup time
            bsf         LCD_CTRL,LCD_E          ;LCD E-line High
            LCDdelay    r_td                    ;min data output delay time
            banksel     LCD_DATA_PORT
      

            btfss       LCD_DATA_PORT,LCD_DB7   ;Check Busy flag, High = Busy



            goto        lcdbusy1
            bcf         LCD_CTRL,LCD_E          ;LCD E-line Low
            LCDdelay    r_tc                    ;min E cycle Time 
            bsf         LCD_CTRL,LCD_E          ;LCD E-line High
            LCDdelay    r_tw                    ;E Pulse Width       
            bcf         LCD_CTRL,LCD_E          ;LCD E-line LOW
                                                ;eliminate the RAM address
            goto        lcdbusy
lcdbusy1
            bcf         LCD_CTRL,LCD_E          ;LCD E-line Low
            LCDdelay    r_tc                    ;min E cycle Time 
            bsf         LCD_CTRL,LCD_E          ;LCD E-line High

            LCDdelay    r_tw                    ;min E Pulse Width 
                                    
            bcf         LCD_CTRL,LCD_E          ;LCD E-line LOW
                                                ;eliminate the RAM address
            bcf         LCD_CTRL,LCD_RW         ;read
            banksel     LCD_DATA_TRIS           ;Select Register page 1
            
            ifdef       LCD4bitmode             ;{
            movlw       0xff^((1<<LCD_DB7)|(1<<LCD_DB6)|(1<<LCD_DB5)|(1<<LCD_DB4))
                                                ;set PORT for output
            andwf       LCD_DATA_TRIS,f
            endif                               ;}

            ifdef       LCD8bitmode             ;{set all PORT output
            movlw       0x0
            movwf       LCD_DATATRIS
            endif                               ;}

            banksel      LCD_DATA_PORT          ;Select Register page 0
            movlw        d'1'
            fcall        x_delay500u
            return













*/

                RET       
                END
#endif