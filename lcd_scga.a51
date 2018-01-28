#ifndef     __LCD_SCGA_A51__
#define     __LCD_SCGA_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  lcdscga
                EXTRN   code(lcdputcmd)
//-------------------------------------------------------------------------
                NAME    LCD_SCGA
                    
LCD_SCGA_CODE SEGMENT   CODE

/**************************************************************************
/*                     lcdscga                                            *
/*           Set the  Character-Generator-RAM address                     *
/* 'A' contains the address                                               *
**************************************************************************/
                RSEG    LCD_SCGA_CODE
                USING   0   
lcdscga:
                ANL     A,#3fH
                ORL     A,#40H
                CALL    lcdputcmd
                RET
                END
#endif