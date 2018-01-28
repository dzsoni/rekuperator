#ifndef     __BINTOBCD_A51__
#define     __BINTOBCD_A51__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  bintobcd
//-------------------------------------------------------------------------
                NAME    BINTOBCD
                    
BINTOBCD_CODE   SEGMENT   CODE

/**************************************************************************
/*                    bintobcd                                            *
/*Binary (8bit) to packed BCD (0 to 99).                                  *
/*Routine converts certain binary numbers to pBCD.                        *
/*                                                                        *
/*Usage:                                                                  *
/*MOV        A,#32d    //A=binary number                                  *
/*CALL       bintobcd                                                     *
/*Return with packed BCD in A                                             *
**************************************************************************/
                RSEG    BINTOBCD_CODE
                USING   0
$REGUSE         bintobcd(R1,R2,A,B)
    
bintobcd:
                MOV     R1,#00D             //Clear R1   
                MOV     R2,#00D             //Clear R2 
        
                MOV     B,#10D
                DIV     AB	                //Divide bin by 10
                MOV     R1,B                //Save the first digit in R1        
                MOV     R2,A                //save 10ths to R2 

                MOV     A,R2                //pack into A
                SWAP    A
                ORL     A,R1               
                RET
                END
#endif
