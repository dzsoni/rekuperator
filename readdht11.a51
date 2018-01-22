#ifndef     __READDHT11_A51__
#define     __READDHT11_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  readdht11
                EXTRN   DATA(INS_H_HI)
                EXTRN   BIT(INS_VALIDVAL)                 
//-------------------------------------------------------------------------
                NAME    READDH11
                    
READDH11CODE    SEGMENT   CODE

/**************************************************************************
/*                       readddh11                                        *
//*************************************************************************
  Adott porton l�voo DHT11 adatainak beolvas�sa
  A= a beolvasand� DHT port bitc�me

  Visszat�r�s Carry bit �ll�t�s�val
  C=1 sikeres beolvas�s
  C=0 sikertelen beolvas�s
-------------------------------------------------------------------------*/
                RSEG    READDH11CODE
                USING   0
readdht11:
                CLR     RS0                 //Select Bank0
                CLR     RS1
              //MOV     R2,#8               //8 bitet l�ptet�nk be
                MOV     R3,#5               //5 byteba
                MOV     R4,A                //R4=A (port bit c�me)

                CLR     TR2                 //Timer2 off
                //Timer2 output disable,  up/down counter disable
                MOV     T2MOD,#00H
                
                MOV     TH2,#HIGH((0FFFFH - X18)+1)
                MOV     TL2,#LOW ((0FFFFH - X18)+1)
                
                CLR     TF2                 //Clear Timer2 overflow flag
                CLR     ET2                 //Disable T2 interrupt
                CLR     RCLK                //MODE: 16bit auto reload
                CLR     TCLK                //
                CLR     EXEN2               //External events disabled
                CLR     C_T2                //Select Timer operation
                //..........................
                
         //R0-t be�ll�t, hogy  a DHT-hoz tartoz� memoriateruletre mutasson
                CLR     C                   //Carry=0
                SUBB    A,#BENT_DHT         
                MOV     B,#5
                MUL     AB                  //A=A*5
                ADD     A,#INS_H_HI         //A=A+INS_H_HI
                MOV     R0,A                //R0 a DHThoz tartozo puffer 
                                            //ter�letre mutat
                              
                MOV     A,R4
                ANL     A,#00001111b
                MOV     R4,A                //R4=DHT port bit sz�ma            
                
                //DHT port mask eloallitas
                INC     R4
                CLR     A
                SETB    C
label1:         RLC     A     
                DJNZ    R4,label1
                MOV     R4,A                //R4=DHT port mask
                
                               
                //minimum 18 ms-os low level elo�ll�t�sa Timer2-vel
                
                 
                CPL     A                   //Invert PORT mask
                ANL     DHT_PORT,A          //'0'-ra h�zzuk a DHT l�bat
                
                SETB    TR2                 //Start Timer2
loop18ms:       JNB     TF2,loop18ms        //loop am�g T2 overflowbit=0 (20ms)
                CPL     A
                ORL     DHT_PORT,A          //1 logikai level DHT-ra (input)
                
loop24us:       MOV     A,DHT_PORT
                ANL     A,R4
                JNZ     loop24us            //v�r a v�laszra (0-ra h�z)(24-40us)

                CLR     TR2                 //stop Timer2
                CLR     TF2                 //Clear overflow T2
                
loop80us1:     //DHT11 80us-ig leh�zza 0-ra
                MOV     A,DHT_PORT
                ANL     A,R4
                JZ      loop80us1
loop80us2:      //DHT11 80us-ig felh�zza 1-re
                MOV     A,DHT_PORT
                ANL     A,R4
                JNZ     loop80us2

                //....50us-os low level->bit eleje innen
bitstart1:      MOV     R2,#8               //R2 reload
bitstart2:      MOV     TH2,#0H             //Timer2 sz�ml�l� null�z    
                MOV     TL2,#0H
                
loopbithead:    //50 us -os bit eleje r�sz
                MOV     A,DHT_PORT
                ANL     A,R4
                JZ      loopbithead
                
                SETB    TR2                 //T2 ind�t
loopbit:        MOV     A,DHT_PORT          //m�r�s
                ANL     A,R4
                JNZ     loopbit
                //.... bit v�ge
                CLR     TR2                 //T2 le�ll�t    
                CLR     C                   //Clear Carry
                MOV     A,TL2
                SUBB    A,#LOW BIT_TIME
                
                MOV     A,TH2
                SUBB    A,#HIGH BIT_TIME
                                            
                CPL     C                   //carry=NOT Carry
                                            //IF Carry=0 ,akkor '0' a bit
                                            
                //Puffer ter�letre ki�rja a carry bitet
                MOV     A,@R0               //A-ba �ltli az aktu�lis puffer byteot
                RLC     A                   //Carry bit kil�ptet balra A-ba
                MOV     @R0,A               //visszai�r

                
                DJNZ    R2,bitstart2        //R2=R2-1; if r2<>0 jump bitstart2
                INC     R0                  //k�vetkezo bytera mutat
                DJNZ    R3,bitstart1        //mind az 5 byte k�sz?
                //K�sz.
                MOV     B,@R0               //B=Checksum
                DEC     R0
                //J�-e a beolvasott adat?
                CLR     A
                ADD     A,@R0
                DEC     R0
                ADDC    A,@R0
                DEC     R0
                ADDC    A,@R0
                DEC     R0
                ADDC    A,@R0
                
                CJNE    A,B,notvalid
                SETB    C
                RET
notvalid:       CLR     C
                RET        
                END
#endif                    