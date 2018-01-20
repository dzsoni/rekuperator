#ifndef     __DELAYX__
#define     __DELAYX__

$NOMOD51
$INCLUDE (.\include\AT89x52.H)
$INCLUDE (.\include\definitions.h)
//-------------------------------------------------------------------------
                PUBLIC  delayx1ms
                PUBLIC  delayx10ms
                PUBLIC  delayx20ms
//-------------------------------------------------------------------------
                NAME    DELAY
                    
DELAYX1MS_CODE  SEGMENT   CODE
DELAYX10MS_CODE SEGMENT   CODE
DELAYX20MS_CODE SEGMENT   CODE
/**************************************************************************
/*                       delayx1ms                                        *
/*                  delay x*1ms subrutin                                  *
**************************************************************************/
                RSEG    DELAYX1MS_CODE
                USING   0
delayx1ms:

                RET
/**************************************************************************
/*                       delayx10ms                                       *
/*                  delay x*10ms subrutin                                 *
**************************************************************************/
                RSEG    DELAYX10MS_CODE
                USING   0
delayx10ms:
                RET
/**************************************************************************
/*                       delayx10ms                                       *
/*                  delay x*20ms subrutin                                 *
**************************************************************************/
                RSEG    DELAYX20MS_CODE
                USING   0
delayx20ms:
                RET
                
#endif