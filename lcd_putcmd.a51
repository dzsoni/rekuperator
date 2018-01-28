#ifndef     __LCD_PUTCMD_A51__
#define     __LCD_PUTCMD_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdputcmd
                EXTRN   code(lcdbusy)
//-------------------------------------------------------------------------
                NAME    LCD_PUTCMD
                    
LCD_PUTCMD_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdutcmd                                           *
/*                  put lcd cmd                                           *
/*ACC:tartalmazza a parancsot                                             *
**************************************************************************/
                RSEG    LCD_PUTCMD_CODE
                USING   0   
lcdputcmd:
                CALL    lcdbusy
                CLR     LCD_RW
                CLR     LCD_RS
                MOV     LCD_PORT,A
                SETB    LCD_E
                NOP
                CLR     LCD_E                
                RET
                END
#endif