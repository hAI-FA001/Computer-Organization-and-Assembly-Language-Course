org 100h


.data
VAR1 DW 0A7h

.code

MOV AX, VAR1
MOV CX, 0

MY_LOOP:
    CMP AX, 0
    JE DONE
    DEC AX
    INC CX
    JMP MY_LOOP

DONE:
    ret
