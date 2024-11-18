org 100h

.stack 100h

.data
prompt DB 'Enter String: $'
revStr DB 'Reversed String: $'
convStr DB 'Converted String (Capital Letters): $'
consStr DB 'Total Number of Consonants: $'

len DB 0
input DB ?

.code
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	
	MOV AH, 9
	MOV DX, offset prompt
	INT 21h
	
	LEA SI, input
	MOV AH, 1
	GET:
		INT 21h
		CMP AL, 0Dh
		JE DONE_GET
		
		MOV [SI], AL
		INC SI
		INC len
		
	JMP GET
	
	DONE_GET:
		CALL PRINTLN
		CALL REV
		
		CALL PRINTLN
		CALL SM_CAP
		
		CALL PRINTLN
		CALL COUNT_CONS
	
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

REV PROC
	LEA SI, input
	AND CX, 0
	MOV CL, len
	
	REV_PUSH:
		MOV AL, [SI]
		AND AH, 0
		INC SI
		PUSH AX
	LOOP REV_PUSH
	
	MOV AH, 9
	MOV DX, offset revStr
	INT 21h
	
	AND CX, 0
	MOV CL, len
	MOV AH, 2
	REV_POP:
		POP DX
		INT 21h
	LOOP REV_POP
	
	
	RET
REV ENDP


SM_CAP PROC
	MOV AH, 9
	MOV DX, offset convStr
	INT 21h
	
	MOV AH, 2
	LEA SI, input
	AND CX, 0
	MOV CL, len
	
	SM_CAP_LOOP:
		MOV DL, [SI]
		INC SI
		CMP DL, 'a'
		JGE IS_SM
		JMP END_OF_LOOP_SM
		
		IS_SM:
			AND DH, 0
			SUB DL, 20h
			INT 21h
			
		END_OF_LOOP_SM:
		
	LOOP SM_CAP_LOOP
	
	
	RET
SM_CAP ENDP

COUNT_CONS PROC
	LEA SI, input
	AND CX, 0
	MOV CL, len
	
	PUSH_CONS_LOOP:
		AND AX, 0
		MOV AL, [SI]
		CMP AL, 'a'
		JGE CONS_SM
		JMP CONS_CHECK
		
		CONS_SM:
			AND AL, 4Fh
			JMP CONS_CHECK
		
		CONS_CHECK:
			CMP AL, 'A'
			JE AFTER_CHECK
			CMP AL, 'E'
			JE AFTER_CHECK
			CMP AL, 'I'
			JE AFTER_CHECK
			CMP AL, 'O'
			JE AFTER_CHECK
			CMP AL, 'U'
			JE AFTER_CHECK
			CMP AL, ' '
			JE AFTER_CHECK
			
			PUSH AX
			
		AFTER_CHECK:
			INC SI
		
	LOOP PUSH_CONS_LOOP
	
	MOV BX, 0
	COUNT_CONS_LOOP:
		CMP SP, 0FFFCh
		JE STACK_EMPTY
		POP AX
		INC BX
	JMP COUNT_CONS_LOOP	
	
	STACK_EMPTY:
		MOV AH, 9
		MOV DX, offset consStr
		INT 21h
		
		MOV AH, 2
		MOV DL, BL
		OR DL, 30h
		INT 21h
	
	RET
COUNT_CONS ENDP	