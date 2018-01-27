#ifndef     __DELAYX__
#define     __DELAYX__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  delayx120us_ini
                PUBLIC  delayx120us_int
                PUBLIC  delayx120us_off
                PUBLIC  DBYTE0
                PUBLIC  DBYTE1
                PUBLIC  DBYTE2
                PUBLIC  DBYTE3
//-------------------------------------------------------------------------
                NAME    DELAYX
                    
DELAYX_INI_CODE SEGMENT   CODE
DELAYX_INT_CODE SEGMENT   CODE
DELAYX_OFF_CODE SEGMENT   CODE
DELAY_VAR       SEGMENT   DATA
//.............................
                RSEG      DELAY_VAR
DBYTE0:         DS          1
DBYTE1:         DS          1
DBYTE2:         DS          1
DBYTE3:         DS          1
/**************************************************************************
/*                       delayx200us                                      *
/*                  delay x*200us subrutin                                *
/*                                                                        *
/*Használata:                                                             *
/*CONST=x/200us                                                           *
/*DBYTE1-DBYTE4 feltöltése CONST -értékével                               *
/*Rutin meghívása, majd ET1 figyelése, ha ET1=0 vagy TR1 =0 letelt az ido *
/*pl:                                                                     *
/*    MOV     DBYTE0,#BYTE0 CONST                                         *
/*    MOV     DBYTE1,#BYTE1 CONST                                         *
/*    MOV     DBYTE2,#BYTE2 CONST                                         *
/*    MOV     DBYTE3,#BYTE3 CONST                                         *
/*    CALL    delayx120us_ini                                             *
/*lp: JB      ET1,lp                                                      *
**************************************************************************/
                RSEG    DELAYX_INI_CODE
                USING   0
delayx120us_ini:
                CLR     TR1         //Timer1 stop
                MOV     A,TMOD
                ANL     A,#T0_MASK_ //T0-t nem bántjuk
                ORL     A,#T1_M1_   //Gate0=0,C/T0=0,M11=1,M01=0
                MOV     TMOD,A      //8bit auto reload (mod2)
                
                                    //számláló beállítása
                MOV     TH1,#(100h-DELAYCONS)
                MOV     TL1,#(100h-DELAYCONS)
                
                MOV     R0,#DBYTE0
                CJNE    @R0,#00,out3
                INC     R0
                CJNE    @R0,#00,out3
                INC     R0
                CJNE    @R0,#00,out3
                INC     R0
                CJNE    @R0,#00,out3
                RET                  //visszatérünk mert 0*120us kérés volt 
                
out3:
                MOV     R0,#DBYTE0
                DEC     DBYTE0
                CJNE    @R0,#0FFH,out4
                DEC     DBYTE1
                INC     R0
                CJNE    @R0,#0FFH,out4
                DEC     DBYTE2
                INC     R0
                CJNE    @R0,#0FFH,out4
                DEC     DBYTE3
                
out4:               
                CLR     TF1         //T1 overflow clear
                SETB    ET1         //T1 interrupt enable
                SETB    TR1         //Run T1
                RET
/**************************************************************************
/*                       delayx120us_int                                  *
/*               delayx120us interrupt rutin                              *
**************************************************************************/
                RSEG    DELAYX_INT_CODE
                USING   2
delayx120us_int:
                PUSH    ACC
                PUSH    PSW
                
                SETB    RS1
                CLR     RS0     //Bank2
                
                MOV     R0,#DBYTE0
                CJNE    @R0,#00,out2
                INC     R0
                CJNE    @R0,#00,out2
                INC     R0
                CJNE    @R0,#00,out2
                INC     R0
                CJNE    @R0,#00,out2
                
                CLR     ET1
                CLR     TR1
                JMP     out
                
out2:
                MOV     R0,#DBYTE0
                DEC     DBYTE0
                CJNE    @R0,#0FFH,out
                DEC     DBYTE1
                INC     R0
                CJNE    @R0,#0FFH,out
                DEC     DBYTE2
                INC     R0
                CJNE    @R0,#0FFH,out
                DEC     DBYTE3
out:                
                POP     PSW
                POP     ACC
                RETI
/**************************************************************************
/*                       delayx120us_off                                  *
/*               delayx120us Timer1 off                                   *
**************************************************************************/               
                RSEG    DELAYX_OFF_CODE
                USING   0
delayx120us_off:
                CLR     ET1
                CLR     TR1
                RET
                END
#endif