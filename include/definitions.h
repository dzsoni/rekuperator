#ifndef __definitions_h__
#define __definitions_h__

//--------------------DEFINITIONS------------------------------------------
FOSC            EQU     20000000d   //Fosc=20MHz

DHT_PORT        EQU     P3          //DHT Port

BENT_DHT        EQU     P3_4        //BENTI DHT11 a PORTX.Y l�bon
KINT_DHT        EQU     BENT_DHT+1  //KINTI DHT11
BE_FAN_DHT      EQU     BENT_DHT+2  //DHT a BE ventill�torn�l
KI_FAN_DHT      EQU     BENT_DHT+3  //DHT a KI ventill�torn�l

LCD_DATA_P      EQU     P2          //LCD DATA PORT
LCD_DB0         EQU     P2_0
LCD_DB1         EQU     P2_1
LCD_DB2         EQU     P2_2
LCD_DB3         EQU     P2_3
LCD_DB4         EQU     P2_4
LCD_DB5         EQU     P2_5
LCD_DB6         EQU     P2_6
LCD_DB7         EQU     P2_7

LCD_CTRL_P      EQU     P1          //LCD control pins
LCD_RS          EQU     P1_0        //LCD Register-Select control line
LCD_RW          EQU     P1_1        //LCD Read/Write control line
LCD_E           EQU     P1_2        //LCD Enable control line

/*--------------18 ms ot eloall�t� konstans�rt�k---------------------------
Ha FOSC= 20000000 (20MHz),akkor 0.6 us-on k�nt l�p a sz�ml�l�
1/(FOSC/12)=0.6us 
X18=18000/0.6=30000  biztons�gi r�hagy�ssal 34000 (~20.4ms)
....................................*/
       
       X18          EQU   34000d

/*-------------A bit �rt�k�t eld�nto idotartam-----------------------------
A bit '0' ha 50us-n�l kisebb,'1' ha 50us-n�l nagyobb idot m�rt�nk
50us=50/(1/(FOSC/12))~=83
...................................*/
        BIT_TIME    EQU 83d 

/*--------120us delay constans �rt�ke T1 delayx120us be�ll�t�s�hoz---------
120us=120/(1/(FOSC/12))=200
...................................*/
        DELAYCONS   EQU 200d

//-------------------------------------------------------------------------
#endif