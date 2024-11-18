org 100h

.data
;QUESTION 1
var1 dw ?
var2 dw ?
var3 dw ?
var4 dw 0

;QUESTION 2
var5 db 5
     
.code
;QUESTION 1
MOV var1, 4AC8h
MOV var2, 478
MOV var3, 0110_1010_0010_1101b
MOV var4, 'BD'

MOV AX, var1
ADD AX, var2
MOV var1, AX

MOV AX, var3
SUB AX, var1
MOV var3, AX

INC var3
DEC var1

MOV AX, var1
XCHG AX, var4
MOV var1, AX

NEG var3

;QUESTION 2
;MOV AX, var1
;ADD AX, var5
;MOV var1, AX

;MOV AX, var2
;SUB AX, var5
;MOV var2, AX

;MOV AX, var5
;XCHG var3, AX
;MOV var5, AX

NEG var5

ret