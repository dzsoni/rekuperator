#ifndef     __BINTOLCD_A51__
#define     __BINTOLCD_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  bintolcd
                EXTRN   code(bintobcd)
                EXTRN   code(lcdputchar)
//-------------------------------------------------------------------------
                NAME    BINTOLCD
                    
BINTOLCD_CODE   SEGMENT   CODE

/**************************************************************************
/*                    bintolcd                                            *
/*Print a binary number to LCD                                            *
/*Binary numer must be betwwen  0-99                                      *
/*Usage:                                                                  *
/*MOV        A,#32d    //A=binary number                                  *
/*CALL       bintolcd                                                     *
**************************************************************************/
                RSEG    BINTOLCD_CODE
                USING   0
$REGUSE         bintolcd(A,B)
bintolcd:
                CALL    bintobcd            //convert to packed BCD
                MOV     B,A
                ANL     A,#11110000b
                SWAP    A
                ADD     A,#30H
                CALL    lcdputchar

                MOV     A,B
                ANL     A,#00001111b
                ADD     A,#30H
                CALL    lcdputchar
                RET
                END
#endif
