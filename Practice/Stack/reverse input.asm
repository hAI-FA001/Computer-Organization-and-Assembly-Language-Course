org 100h

.STACK 100h

.data
Msg DB 'Enter a string terminated by carriage return: $'
Count DW 0

.code

MOV AH, 9
MOV DX, offset Msg
INT 21h

NEWL EQU 0Ah
CRET EQU 0Dh

MOV AH, 1
GET:
	INT 21h
	
	CMP AL, NEWL
	JE DONE
	CMP AL, CRET
	JE DONE
	
	XOR BX, BX
	MOV BL, AL
	PUSH BX
	INC Count
	
JMP GET

DONE:
MOV AH, 2

MOV DL, NEWL
INT 21h
MOV DL, CRET
INT 21h

MOV CX, Count
REV:
	POP DX
	INT 21h
LOOP REV


ret
