org 100h

.code
   
MOV AX, 8
MOV BX, 9

CMP AX, BX
JG A_GREATER
MOV CX,BX
ret

A_GREATER:
    MOV CX, AX    
   
ret