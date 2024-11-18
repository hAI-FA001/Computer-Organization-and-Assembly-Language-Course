org 100h

.code

MOV AH, 1
INT 21h

MOV BL, AL

MOV DL, 10
MOV AH, 2
INT 21h

MOV CX, 0
MOV CL, BL

CMP CX, 'A'
JGE ABOVE_A_UP
JMP IS_OTHER

ABOVE_A_UP:
    CMP CX, 'Z'
    JLE IS_UPPER
    CMP CX, 'a'
    JGE ABOVE_A_LO
    JMP IS_OTHER

ABOVE_A_LO:
    CMP CX, 'z'
    JLE IS_LOWER
    JMP IS_OTHER

IS_LOWER:
    MOV DL, 'L'
    JMP DISPLAY
    
IS_UPPER:
    MOV DL, 'U'
    JMP DISPLAY
        
IS_OTHER:
    MOV DL, 'O'
    JMP DISPLAY
    
DISPLAY:
    MOV AH, 2
    INT 21h    