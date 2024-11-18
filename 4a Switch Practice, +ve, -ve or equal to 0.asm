org 100h

.code

MOV AX, -100

CMP AX, 0
JG A_POS
JL A_LES
MOV BX, 0
ret

A_POS:
    MOV BX, 1
    ret
A_LES:
    MOV BX, -1    
    ret
