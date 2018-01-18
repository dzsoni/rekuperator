$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)      
//-------------------------------------------------------------------------
                PUBLIC  STARTUP
                PUBLIC  INS_H_HI
                PUBLIC  INS_VALIDVAL
                EXTRN   CODE(readdht11)
                EXTRN   CODE(wdtt0_int)
                EXTRN   CODE(wdtt0_ini)
                EXTRN   CODE(wdtt0_off)
//-------------------------------------------------------------------------
//                K�d �s adat szegmensek defini�l�sa
//-------------------------------------------------------------------------
                NAME    START

C_C51STARTUP    SEGMENT   CODE
STACK           SEGMENT   IDATA
VARS            SEGMENT   DATA
FLAGS           SEGMENT   DATA BITADDRESSABLE
//...........................................
                RSEG            STACK
                DS      16      //STACK m�rete
//...
                RSEG            VARS
INS_H_HI:       DS              1       //Inside humidity integer
INS_H_LO:       DS              1       //Inside humidity decimal
INS_T_HI:       DS              1       //Inside Temperature integer
INS_T_LO:       DS              1       //Inside Temperature fractional
INS_CHKSUM:     DS              1       //Inside Cheksum

OUT_H_HI:       DS              1       //Outside humidity integer
OUT_H_LO:       DS              1       //Outside humidity decimal
OUT_T_HI:       DS              1       //Outside Temperature integer
OUT_T_LO:       DS              1       //Outside Temperature fractional
OUT_CHKSUM:     DS              1       //Outside Cheksum
        
BE_FAN_H_HI:    DS              1       //BE Fan humidity integer
BE_FAN_H_LO:    DS              1       //BE FAN humidity decimal
BE_FAN_T_HI:    DS              1       //BE FAN Temperature integer
BE_FAN_T_LO:    DS              1       //BE FAN Temperature decimal
BE_FAN_CHKSUM:  DS              1       //BE_FAN Checksum
        
KI_FAN_HUM_HI:  DS              1       //KI Fan humidity integer
KI_FAN_HUM_LO:  DS              1       //KI FAN humidity decimal
KI_FAN_TEMP_HI: DS              1       //KI FAN Temperature integer
KI_FAN_TEMP_LO: DS              1       //KI FAN Temperature decimal
KI_CHKSUM:      DS              1       //KI_FAN Checksum
        
//...
                RSEG            FLAGS
BITS:           DS              1
INS_VALIDVAL    BIT             BITS.0          //�rv�nyesek-e a benti adatok
OUT_VALIDVAL    BIT             INS_VALIDVAL+1  //�rv�nyesek-e a kiniti adatok
BE_FAN_VALIDVAL BIT             INS_VALIDVAL+2
KI_FAN_VALIDVAL BIT             INS_VALIDVAL+3    
//--------------------------------------------------------------------------
//              RESET VEKTOR   
//--------------------------------------------------------------------------
                CSEG    AT      0               //program  start pont

STARTUP:        LJMP    STARTUP1
//...........Timer0 interrupt vector
                CSEG    AT      0bH
T0IE_VECT:      LJMP    wdtt0_int
//--------------------------------------------------------------------------
                RSEG    C_C51STARTUP
                USING   0

STARTUP1:       MOV     SP,#STACK-1 //Stack pointer be�ll�tasa


                CLR     RS0             //Select Bank0
                CLR     RS1
                                
                CLR     INS_VALIDVAL    //nem �rv�nyes adatok a belso szenzort�l
                CLR     OUT_VALIDVAL    //nem �rv�nyes adatok a k�lso szenzort�l
                CLR     BE_FAN_VALIDVAL
                CLR     KI_FAN_VALIDVAL
                
                SETB    EA
                CALL    wdtt0_ini 
                
                                        //Read BENT_DHT
                MOV     A,#BENT_DHT     
                CALL    readdht11
                JC      label1
                CLR     INS_VALIDVAL
                JMP     label2
label1:         SETB    INS_VALIDVAL       

label2:         CALL     wdtt0_ini    
                                        //Read KINT_DHT
                MOV     A,#KINT_DHT     
                CALL    readdht11
                JC      label3
                CLR     OUT_VALIDVAL
                JMP     label4
label3:         SETB    OUT_VALIDVAL       

label4:         CALL     wdtt0_ini                        
                                        //Read BE_FAN_DHT
                MOV     A,#BE_FAN_DHT     
                CALL    readdht11
                JC      label5
                CLR     BE_FAN_VALIDVAL 
                JMP     label6
label5:         SETB    BE_FAN_VALIDVAL 

label6:         CALL    wdtt0_ini 
                                        //Read KI_FAN_DHT
                MOV     A,#KI_FAN_DHT     
                CALL    readdht11
                JC      label7
                CLR     KI_FAN_VALIDVAL
                JMP     label8
label7:         SETB    KI_FAN_VALIDVAL 
label8:
                CALL    wdtt0_off
                CLR     EA
                
INFLOOP:        JMP     INFLOOP         //infinity loop (SJMP INFLOOP)
                END