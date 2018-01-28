#ifndef     __LCD_HOME_A51__
#define     __LCD_HOME_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdhome
                EXTRN   code(lcdputcmd)
//-------------------------------------------------------------------------
                NAME    LCD_HOME
                    
LCD_HOME_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdhome                                            *
/* DDRAM adrees is set 00H and rerturn cursor to its original position if *
/*shifted                                                                 *
**************************************************************************/
                RSEG    LCD_HOME_CODE
                USING   0   
lcdhome:
                MOV     A,#02H
                CALL    lcdputcmd                             
                RET
                END
#endif