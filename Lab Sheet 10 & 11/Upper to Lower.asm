org 100h

.code

MOV AH, 1
INT 21h

OR AL, 60h

MOV DL, AL
MOV AH, 2
INT 21h

ret