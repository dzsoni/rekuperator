#ifndef     __PRDHTTOLCD_A51__
#define     __PRDHTTOLCD_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  prDHTtoLCD
                EXTRN   code(lcdputchar)
                EXTRN   code(lcdhome)
                EXTRN   code(lcdsdda)
                EXTRN   code(bintolcd)
                EXTRN   code(bintobcd)
                EXTRN   data(INS_H_HI)    
                EXTRN   bit(INS_VALIDVAL)                 
//-------------------------------------------------------------------------
                NAME    PRDHTTOLCD
                    
PRDHTTOLCD_CODE SEGMENT   CODE

/**************************************************************************
/*                     prDHTtoLCD                                         *
/*               Print DHT datas to LCD                                   *
/*                                                                        *
**************************************************************************/
                RSEG    PRDHTTOLCD_CODE
                USING   0   
prDHTtoLCD:
                MOV     A,LCD_LINE0         //set cursor position
                CALL    lcdsdda
                
                
hom1:           MOV     A,#00h              //homéro
                CALL    lcdputchar
                MOV     A,#'1'
                CALL    lcdputchar
                MOV     A,#':'
                JNB     INS_VALIDVAL,qm1
                MOV     A,INS_H_HI+2        //temp HI
                CALL    bintolcd
                MOV     A,#'.'
                CAll    lcdputchar
                MOV     A,INS_H_HI+3        //temp decimal
                CALL    bintobcd
                ANL     A,#00001111b
                ADD     A,#30H
                CALL    lcdputchar
                JMP     hom2
qm1:            CALL    errDHT

hom2:           
                MOV     A,#LCD_LINE0+10d
                CALL    lcdsdda
                MOV     A,#00h              //homéro
                CALL    lcdputchar
                MOV     A,#'2'
                CALL    lcdputchar
                MOV     A,#':'
                JNB     INS_VALIDVAL+1,qm2
                MOV     A,INS_H_HI+5+2        //temp HI
                CALL    bintolcd
                MOV     A,#'.'
                CAll    lcdputchar
                MOV     A,INS_H_HI+5+3        //temp decimal
                CALL    bintobcd
                ANL     A,#00001111b
                ADD     A,#30H
                CALL    lcdputchar
                JMP     hum1
qm2:            CALL    errDHT
                
hum1:           MOV     A,#LCD_LINE1
                CALL    lcdsdda
                MOV     A,#'H'
                CALL    lcdputchar
                MOV     A,#'1'
                CALL    lcdputchar
                MOV     A,#':'
                JNB     INS_VALIDVAL,qm3
                MOV     A,INS_H_HI            //Humidity HI
                CALL    bintolcd
                MOV     A,#'.'
                CAll    lcdputchar
                MOV     A,INS_H_HI+1          //humidity decimal
                CALL    bintobcd
                ANL     A,#00001111b
                ADD     A,#30H
                CALL    lcdputchar
                JMP     hum2
qm3:            CALL    errDHT

hum2:           MOV     A,#LCD_LINE1+10d
                CALL    lcdsdda
                MOV     A,#'H'
                CALL    lcdputchar
                MOV     A,#'2'
                CALL    lcdputchar
                MOV     A,#':'
                JNB     INS_VALIDVAL+1,qm4
                MOV     A,INS_H_HI+5          //Humidity HI
                CALL    bintolcd
                MOV     A,#'.'
                CAll    lcdputchar
                MOV     A,INS_H_HI+5+1        //humidity decimal
                CALL    bintobcd
                ANL     A,#00001111b
                ADD     A,#30H
                CALL    lcdputchar
                JMP     vege
qm4:            CALL    errDHT
vege:                
                RET
                
errDHT:         MOV     A,#'?'
                CALL    lcdputchar
                MOV     A,#'?'
                CALL    lcdputchar
                MOV     A,#'.'
                CALL    lcdputchar
                MOV     A,#'?'
                CALL    lcdputchar
                RET
                END
#endif