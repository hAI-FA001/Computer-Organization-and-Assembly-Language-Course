org 100h

.data
input DB 0
prompt DB 'Enter a decimal number: '
promptLen DW $-prompt


.code
CRET EQU 0Dh
NEWL EQU 0Ah

MOV AH, 2
LEA SI, prompt
MOV CX, promptLen
PROMPT_OUT:
	MOV DL, [SI]
	INT 21h
	INC SI
LOOP PROMPT_OUT

AND AL, 0
MOV AH, 1
GET_DEC:
	INT 21h
	CMP AL, CRET
	JE DONE
	
	AND AL, 0Fh
	MOV BL, AL
	MOV AL, 10
	MUL input
	MOV input, AL
	ADD input, BL
	
	MOV AH, 1
JMP GET_DEC

DONE:

ret