#ifndef __definitions_h__
#define __definitions_h__

//--------------------DEFINITIONS------------------------------------------
FOSC            EQU    20000000d     //Fosc=20MHz

DHT_PORT        EQU    P3          //DHT Port

BENT_DHT        EQU    P3_4        //BENTI DHT11 a PORTX.Y l�bon
KINT_DHT        EQU    BENT_DHT+1  //KINTI DHT11
BE_FAN_DHT      EQU    BENT_DHT+2  //DHT a BE ventill�torn�l
KI_FAN_DHT      EQU    BENT_DHT+3  //DHT a KI ventill�torn�l



/*--------------18 ms ot eloall�t� konstans�rt�k---------------------------
Ha FOSC= 20000000 (20MHz),akkor 0.6 us-on k�nt l�p a sz�ml�l�
1/(FOSC/12)=0.6us 
X18=18000/0.6=30000  biztons�gi r�hagy�ssal 34000 (~20.4ms)
....................................*/
       
       X18          EQU   34000d

/*-------------A bit �rt�k�t eld�nto idotartam-----------------------------
A bit '0' ha 50us-n�l kisebb,'1' ha 50us-n�l nagyobb idot m�rt�nk
50us=50/0.6~=83
...................................*/
        BIT_TIME    EQU 83d 

//-------------------------------------------------------------------------                             
#endif