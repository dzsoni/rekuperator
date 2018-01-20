#ifndef     __LCD_INI_A51__
#define     __LCD_INI_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcd_ini

//-------------------------------------------------------------------------
                NAME    LCD_INI
                    
LCD_INI_CODE    SEGMENT   CODE

/**************************************************************************
/*                       lcd_ini                                          *
/*                  Lcd inicialization                                    *
**************************************************************************/
                RSEG    LCD_INI_CODE
                USING   0   
lcd_ini:

      banksel     LCD_DATA_TRIS
      bcf         LCD_DATA_TRIS,LCD_DB4
      bcf         LCD_DATA_TRIS,LCD_DB5
      bcf         LCD_DATA_TRIS,LCD_DB6
      bcf         LCD_DATA_TRIS,LCD_DB7         ;LCD DATAlines set to out
      banksel     LCD_CTRL_TRIS
      bcf         LCD_CTRL_TRIS,LCD_RS
      bcf         LCD_CTRL_TRIS,LCD_RW
      bcf         LCD_CTRL_TRIS,LCD_E           ;set LCD controll lines 
                                                ;to output 
      banksel     LCD_CTRL
            
      bcf         LCD_CTRL,LCD_RS               ;instruction
      bcf         LCD_CTRL,LCD_RW               ;write
      bcf         LCD_CTRL,LCD_E                ;disable
      
      movlw            .250
      fcall            x_delay500u

 ;-----change to 8 bit interface-----------
      banksel     LCD_CTRL                ;{     
      bcf         LCD_CTRL, LCD_RW        ;read
      bcf         LCD_CTRL, LCD_RS        ;command
      if (LCD_DB4 ==4)
      movlw            b'00110000'        ;8bit interface pin4-7
    else
      movlw            b'00000011'        ;8bit interface pin0-3
   endif
      fcall            portnible          ;send to LCD

      movlw       .1                      ;wait
      fcall       x_delay500u

      bcf         LCD_CTRL, LCD_RW        ;read
      bcf         LCD_CTRL, LCD_RS        ;command
      if (LCD_DB4 ==4)
      movlw            b'00110000'        ;8bit interface pin4-7
    else
      movlw            b'00000011'        ;8bit interface pin0-3
   endif
      fcall            portnible          ;send to LCD

      movlw       .1                      ;wait
      fcall       x_delay500u
                                          ;}
;----change to 4 bit interface------------
                                          ;{            
   if (LCD_DB4 ==4)
      movlw            b'00100000'        ;4bit interface pin4-7
    else
      movlw            b'00000010'        ;
   endif   

      bcf         LCD_CTRL, LCD_RW        ;read
      bcf         LCD_CTRL, LCD_RS        ;command
      fcall       portnible               ;send to LCD

      movlw       .1                      ;wait
      fcall       x_delay500u
      
      if (LCD_DB4 ==4)
      movlw            b'00100000'        ;4bit interface pin0-3
    else
      movlw            b'00000010'        ;
   endif   

      bcf         LCD_CTRL, LCD_RW        ;read
      bcf         LCD_CTRL, LCD_RS        ;command
      fcall       portnible               ;send to LCD
                                          ;}
;------------------------------------------
      movlw       .1                      ;min 39us wait
      fcall       x_delay500u
      
      if (LCD_DB4 ==4)
      movlw            b'10000000'        ;2 line mode display off pin4-7
    else
      movlw            b'00001000'         
   endif

      bcf              LCD_CTRL, LCD_RW     ;read
      bcf              LCD_CTRL, LCD_RS     ;command
      fcall            portnible            ;send to LCD
      
      movlw            .1                   ;min 39us wait
      fcall            x_delay500u

      movlw            b'00001100'        ; disp.on, curs.off, no-blink
      fcall            lcdputcmd
            
      fcall            lcdclear           ; clear display

      movlw            b'00000110'        ; INCREMENT, no entire shift
      fcall            lcdputcmd

      fcall            lcdhome
       return                              ;}
       */
        END
#endif