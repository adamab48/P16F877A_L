#include <p16f877a.inc>
    org 0
    goto setup
    org 4
    goto int
    
int 
    call bank1
    bcf INTCON,1
    call bank0
    movf 0x21,0
    sublw 9
    btfss STATUS,Z
    goto inc
    goto re
inc 
    incf 0x21
    retfie
re
    clrf 0x21
    retfie

setup
    call bank1
    clrf TRISC
    movlw b'10010000'
    movwf INTCON
    bcf OPTION_REG,7
    bcf OPTION_REG,6
    call bank0
    movlw 0x00
    movwf 0x21
    goto loop
loop
    call table
    call bank0
    movwf PORTC
    goto loop
    

table
    movf 0x21,0
    addwf PCL,1
    retlw b'00111111'
    retlw b'00000110'
    retlw b'01011011'
    retlw b'01001111'
    retlw b'01100110'
    retlw b'01101101'
    retlw b'01111101'
    retlw b'00000111'
    retlw b'01111111'
    retlw b'01101111'
    
bank1
    bsf STATUS,5
    bcf	STATUS,6
    return
bank0
    bcf STATUS,5
    bcf	STATUS,6
    return
    end