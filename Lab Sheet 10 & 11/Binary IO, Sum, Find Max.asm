org 100h

.data
num1 DB 0
num2 DB 0
sum  DB 0

sumStr DB 0Dh, 0Ah, 'Sum: '
sumStrSize DW $-sumStr
maxStr DB 0Dh, 0Ah, 'Max: '
maxStrSize DW $-maxStr


.code
MOV CX, 8
MOV AH, 1

FIRST:
	INT 21h
	CMP AL, '0'
	JE ZERO1
	
	ROL num1, 1
	OR num1, 1
	JMP AFTER_Z1
	
	ZERO1:
		ROL num1, 1
	AFTER_Z1:
	
LOOP FIRST

MOV AH, 2
MOV DL, 0Dh
INT 21h
MOV DL, 0Ah
INT 21h

MOV AH, 1

MOV CX, 8
SECOND:
	INT 21h
	CMP AL, '0'
	JE ZERO2
	
	ROL num2, 1
	OR num2, 1
	JMP AFTER_Z2
	
	ZERO2:
		ROL num2, 1
	AFTER_Z2:
	
LOOP SECOND


MOV AL, num1
ADD AL, num2
MOV sum, AL

MOV AH, 2
MOV CX, sumStrSize
LEA SI, sumStr

DISP_SUM:
	MOV DL, [SI]
	INT 21h
	INC SI
LOOP DISP_SUM


MOV BL, sum
MOV CX, 8

SHOW_SUM:
	ROL BL, 1
	JC OUT_ONE
	MOV DL, '0'
	JMP AFTER_OUT
	
	OUT_ONE:
		MOV DL, '1'
	
	AFTER_OUT:
		INT 21h
LOOP SHOW_SUM


MOV CX, maxStrSize
LEA SI, maxStr

DISP_MAX:
	MOV DL, [SI]
	INT 21h
	INC SI
LOOP DISP_MAX

MOV BL, num1
CMP BL, num2
JB NUM2_G
JMP SHOW_MAX


NUM2_G:
	MOV BL, num2

MOV CX, 8
SHOW_MAX:
	ROL BL, 1
	JC M_OUT_ONE
	MOV DL, '0'
	JMP M_AFTER_OUT
	
	M_OUT_ONE:
		MOV DL, '1'
	
	M_AFTER_OUT:
		INT 21h
LOOP SHOW_MAX

ret