#ifndef     __START_A51__
#define     __START_A51__
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
                EXTRN   CODE(delayx120us_ini)
                EXTRN   CODE(delayx120us_int)    
                EXTRN   CODE(delayx120us_off)
                EXTRN   DATA(DBYTE0)
                EXTRN   DATA(DBYTE1)
                EXTRN   DATA(DBYTE2)
                EXTRN   DATA(DBYTE3)        
//-------------------------------------------------------------------------
//                Kód és adat szegmensek definiálása
//-------------------------------------------------------------------------
                NAME    START

C_C51STARTUP    SEGMENT   CODE
STACK           SEGMENT   IDATA
VARS            SEGMENT   DATA
FLAGS           SEGMENT   DATA BITADDRESSABLE
//...........................................
                RSEG            STACK
                DS      16      //STACK mérete
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
INS_VALIDVAL    BIT             BITS.0          //Érvényesek-e a benti adatok
OUT_VALIDVAL    BIT             INS_VALIDVAL+1  //Érvényesek-e a kiniti adatok
BE_FAN_VALIDVAL BIT             INS_VALIDVAL+2
KI_FAN_VALIDVAL BIT             INS_VALIDVAL+3    
//--------------------------------------------------------------------------
//              RESET VEKTOR   
//--------------------------------------------------------------------------
                CSEG    AT      0H             //program  start pont

STARTUP:        LJMP    STARTUP1
//...........Timer0 interrupt vector
                CSEG    AT      0bH
T0IE_VECT:      LJMP    wdtt0_int
//...........Timer1 interrupt vector
                CSEG    AT      1bH
T1IE_VECT:      LJMP    delayx120us_int
//--------------------------------------------------------------------------
                RSEG    C_C51STARTUP
                USING   0

STARTUP1:       MOV     SP,#STACK-1 //Stack pointer beállítasa


                CLR     RS0             //Select Bank0
                CLR     RS1
                                
                CLR     INS_VALIDVAL    //nem érvényes adatok a belso szenzortól
                CLR     OUT_VALIDVAL    //nem érvényes adatok a külso szenzortól
                CLR     BE_FAN_VALIDVAL
                CLR     KI_FAN_VALIDVAL
                
                //wait-> 1s=8333.333*120us~=8334
                //8334dec=0000208Eh
                SETB    EA
                MOV     DBYTE0,#8Eh
                MOV     DBYTE1,#20h
                MOV     DBYTE2,#00h
                MOV     DBYTE3,#00h
                CALL    delayx120us_ini
loop1:          JB      TR1,loop1       //wait 1s             
 //........................               
readdhts:                
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
                
                //wait-> 5s=41666.66667*120us~=41667
                //41667dec=0000A2C3h
                MOV     DBYTE0,#0C3h
                MOV     DBYTE1,#0A2h
                MOV     DBYTE2,#00h
                MOV     DBYTE3,#00h
                CALL    delayx120us_ini
loop2:          JB      TR1,loop2       //wait 5s         
                JMP     readdhts
                END
#endif