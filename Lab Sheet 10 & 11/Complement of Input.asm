org 100h

.data
inpStr DB 'Please give your input: '
inpStrSize DW $-inpStr
outStr DB 0Ah, 0Dh, 'Complement of input is: '
outStrSize DW $-outStr

.code

MOV CX, inpStrSize
LEA SI, inpStr

MOV AH, 2

PROMPT:
	MOV DL, [SI]
	INT 21h
	INC SI
LOOP PROMPT


MOV AH, 1
INT 21h

NOT AL
MOV BL, AL


MOV CX, outStrSize
LEA SI, outStr

MOV AH, 2

OUTPUT:
	MOV DL, [SI]
	INT 21h
	INC SI
LOOP OUTPUT


MOV DL, BL
INT 21h

ret