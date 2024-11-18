org 100h

SUM DW 0

.code

;MOV AX, 0
MOV BX, 1

MY_LOOP:
    ADD SUM, BX
    ADD BX, 3
    CMP BX, 148
    JG END
    JMP MY_LOOP
    
END:
    ret