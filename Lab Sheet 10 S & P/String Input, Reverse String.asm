org 100h

.stack 100h

.data
Count db 0
Prompt db '? $'

.code
MAIN PROC
	
MOV AH, 9
MOV DX, offset Prompt
INT 21h

MOV AH, 1
GET:
	INT 21h
	CMP AL, 0Ah
	JE End_
	CMP AL, 0Dh
	JE End_
	
	INC Count
	MOV DL, AL
	AND DH, 0
	PUSH DX

JMP GET

END_:
MOV AH, 2

MOV DL, 0Ah
INT 21h
MOV DL, 0Dh
INT 21h

AND CX, 0
MOV CL, count
DISPLAY:
	POP DX
	INT 21h
LOOP DISPLAY

RET

MAIN ENDP