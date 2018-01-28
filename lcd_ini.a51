#ifndef     __LCD_INI_A51__
#define     __LCD_INI_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdini
                EXTRN   CODE(delayx120us_ini)
                EXTRN   CODE(lcdbusy)
                EXTRN   CODE(lcdputcmd)
                EXTRN   CODE(lcdputchar)
                EXTRN   CODE(lcdclear)
                EXTRN   CODE(lcdhome)
                EXTRN   CODE(lcdscga)
                EXTRN   CODE(homero)
                EXTRN   DATA(DBYTE0)
                EXTRN   DATA(DBYTE1)
                EXTRN   DATA(DBYTE2)
                EXTRN   DATA(DBYTE3)
//-------------------------------------------------------------------------
                NAME    LCD_INI
                    
LCD_INI_CODE    SEGMENT   CODE

/**************************************************************************
/*                       lcd_ini                                          *
/*                  Lcd inicialization                                    *
**************************************************************************/
                RSEG    LCD_INI_CODE
                USING   0   
lcdini:            
                CLR     LCD_RS               //instruction
                CLR     LCD_RW               //write
                CLR     LCD_E                //E disable
      
                //-----set to 8 bit interface-----------
                MOV     LCD_PORT,00110000b //8bit interface 
                SETB    LCD_E
                NOP
                CLR     LCD_E
                //hold LCD_DATA >5ms
                //5ms=41.6667*120us~=42
                //42dec=0000002Ah
                SETB    EA
                MOV     DBYTE0,#2Ah
                MOV     DBYTE1,#00h
                MOV     DBYTE2,#00h
                MOV     DBYTE3,#00h
                CALL    delayx120us_ini
loop1:          JB      TR1,loop1                   //wait 5ms

                SETB    LCD_E
                NOP
                CLR     LCD_E
                
                MOV     DBYTE0,#2Ah
                CALL    delayx120us_ini             //wait 5ms
loop2:          JB      TR1,loop2                

                SETB    LCD_E
                NOP
                CLR     LCD_E    
                
                MOV     LCD_PORT,00111000b     //8bit , 2lines, 5x8 font 
                call    lcdbusy
                MOV     A,#00h                 //Display off
                CALL    lcdputcmd
                CALL    lcdclear               //Display clear
                MOV     A,00000110b            //INCREMENT, no entire shift
                CALL    lcdputcmd
                CALL    lcdhome
                MOV     A,#08H                  //disp on, Cursor, off, no blink
                CALL    lcdputcmd
           
             //--------Upload custom chars to CGRAM---------
                MOV     A,#00h                  //Char adddress= 00H
                CALL    lcdscga
                MOV     DPTR,#homero
                CLR     A
                MOV     R2,A
                
loop3:          MOVC    A,@A+DPTR
                CALL    lcdputchar
                INC     R2
                MOV     A,R2
                CJNE    A,#8,loop3
                RET
        END
#endif