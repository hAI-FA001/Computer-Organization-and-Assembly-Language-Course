org 100h

.code

MOV AX, 41
MOV BX, 5
MOV CX, 0

MY_LOOP:
    CMP AX, BX
    JL DONE
    SUB AX, BX
    INC CX
    JMP MY_LOOP


DONE:
    ret