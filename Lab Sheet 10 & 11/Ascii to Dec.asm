org 100h

.code

MOV AH, 1
INT 21h

AND AL, 000Fh

ret