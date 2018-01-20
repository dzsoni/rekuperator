#ifndef     __WDT_T0_A51__
#define     __WDT_T0_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  wdtt0_int
                PUBLIC  wdtt0_ini
                PUBLIC  wdtt0_off
//-------------------------------------------------------------------------
                NAME    WDT_T0
                    
WDT_T0_CODE     SEGMENT   CODE
WDT_T0_INI      SEGMENT   CODE
WDT_TO_OFF      SEGMENT   CODE
/**************************************************************************
/*                       wdtt0_int                                        *
/*                  Watch Dog Timer_T0- interrupt rutin                   *
**************************************************************************/
                RSEG    WDT_T0_CODE
                USING   1
wdtt0_int:
                CLR     TR0     //stop Timer 0
                CLR     ET0     //disable Timer0 interrupt
                
                DEC     SP
                DEC     SP
                CLR     C       //jelezzük, hogy a DHT data nem jó
                RETI

/**************************************************************************
/*                       wdtt0_ini                                        *
/*             Watch Dog Timer_T0  inicializálás                          *
**************************************************************************/
                RSEG    WDT_T0_INI
                USING   0
wdtt0_ini:
                CLR     TR0         //Timer0 stop
                MOV     A,TMOD
                ANL     A,#T1_MASK_
                ORL     A,#T0_M0_   //Gate0=0,C/T0=0,M10=0,M00=1
                MOV     TMOD,A
                
                MOV     TH0,0       //Számláló törlése
                MOV     TL0,0
                
                CLR     TF0         //T0 overflow clear
                SETB    ET0         //T0 interrupt enable
                SETB    TR0         //Run T0
                RET
/**************************************************************************
/*                       wdtt0_off                                        *
/*             Watch Dog Timer_T0  lekapcs                                *
**************************************************************************/
                RSEG    WDT_TO_OFF
                USING   0
wdtt0_off:
                CLR     TR0         //Timer0 stop
                CLR     ET0         //T0 interrupt disable
                RET
                END
#endif