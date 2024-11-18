org 100h

.stack 100h

.code
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX
	XOR AX, AX
	
	;MOVSB, STOSB, LODSB, SCASB, CMPSB
	
	LEA SI, s2
	LEA DI, s1
	
	MOV CX, s2len
	
	;REP MOVSB
	
	
	
	
	
	SRCH EQU 'p'
	
	MOV AL, SRCH
	LEA DI, s1
	MOV CX, s1len
	SEARCH:
		SCASB
		JZ FOUND
	LOOP SEARCH
	JNE NOT_FOUND
	FOUND:
		MOV AX, s1len
		SUB AX, CX
		JMP STORE
		
	NOT_FOUND:
		MOV AX, -1
		JMP STORE
		
	
	
	
	
	STORE:
		LEA DI, s1
		MOV AH, 1
		GET_:
			INT 21h
			CMP AL, 0Dh
			JE GET_STOP
			STOSB
			JMP GET_
		GET_STOP:
			MOV AL, '$'
			STOSB
			
			CALL PRINTLN
			
			MOV AH, 9
			MOV DX, offset s1
			INT 21h	
	
	
	
	
	
	COMPARE:
		LEA SI, s1
		LEA DI, s2
		MOV CX, s2len
		START_CMP:
			CMPSB
			JL S1_LESS
			JG S1_GREATER
		LOOP START_CMP
			MOV AX, 0
			RET
			
			S1_LESS:
				MOV AX, 1
				RET
				
			S1_GREATER:
				MOV AX, 2
				RET
	
	RET
MAIN ENDP

PRINTLN PROC
	MOV AH, 2
	MOV DL, 0Ah
	INT 21h
	MOV DL, 0Dh
	INT 21h
	
	RET
PRINTLN ENDP





.data
s1 db 'to copy into'
s1len dw $-s1
s2 db 'to be copied'
s2len dw $-s2


