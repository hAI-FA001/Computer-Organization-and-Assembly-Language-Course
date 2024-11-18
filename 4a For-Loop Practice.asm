org 100h

.code

MOV AX, 0   
MOV CX, 8

TOP:
    INC AX
    DEC CX
    CMP CX, 0
    JE DONE
    JMP TOP
    
DONE:       
    ret
