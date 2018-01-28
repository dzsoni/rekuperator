#ifndef     __LCD_SDDA_A51__
#define     __LCD_SDDA_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdsdda
                EXTRN   code(lcdputcmd)
//-------------------------------------------------------------------------
                NAME    LCD_SDDA
                    
LCD_SDDA_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdsdda                                            *
/*           Set the  Data-RAM address                                    *
/* 'A' contains the address                                               *
**************************************************************************/
                RSEG    LCD_SDDA_CODE
                USING   0   
lcdsdda:
                ORL     A,#80H
                CALL    lcdputcmd
                RET
                END
#endif