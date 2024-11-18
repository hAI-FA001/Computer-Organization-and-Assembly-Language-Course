org 100h

.stack 100h

.code
MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	AND AX, 0
	
	CALL GET_INPUT
	
	CALL FIND_CAP
	
	DEC isFindFirst
	CALL FIND_CAP
	
	CALL DISPLAY_CAP
	
	CALL REV_INPUT
	
	RET
MAIN ENDP

GET_INPUT PROC
	MOV AH, 9
	MOV DX, offset enterStr
	INT 21h
	
	LEA SI, input
	MOV AH, 1
	
	GET_LOOP:
		INT 21h
		CMP AL, 0Dh
		JE DONE_GET
		
		;accept only alphabets and spaces
		CMP AL, ' '
		JE IS_ALPHA
		CMP AL, 'A'
		JL GET_LOOP
		CMP AL, 'z'
		JG GET_LOOP
		CMP AL, 'Z'
		JLE IS_ALPHA
		CMP AL, 'a'
		JGE IS_ALPHA
		
		JMP GET_LOOP
		
		IS_ALPHA:
			MOV [SI], AL
			INC SI
			INC inpLen
		
	JMP GET_LOOP
	
	DONE_GET:
		RET
GET_INPUT ENDP	

FIND_CAP PROC
	POP BX
	
	LEA SI, input
	AND CH, 0
	MOV CL, inpLen
	
	CMP isFindFirst, 1
	JE PUSH_LESS
	AND AX, 0
	MOV AL, 0 ;push smallest value
	PUSH AX   ;which acts as default value
	JMP FIND_CAP_LOOP
	
	PUSH_LESS:
		AND AX, 0
		MOV AL, 0FFh ;push greatest value
		PUSH AX      ;which acts as default value
		JMP FIND_CAP_LOOP
	
	FIND_CAP_LOOP:
		MOV AL, [SI]
		CMP AL, ' '
		JE END_OF_FIND
		CMP AL, 'a'
		JGE END_OF_FIND
		
		POP DX
		
		CMP isFindFirst, 1
		JE CHECK_LESS
		JMP CHECK_GREATER

		
		CHECK_LESS:
			CMP AL, DL
			JB FOUND
			PUSH DX
			JMP END_OF_FIND

		CHECK_GREATER:
			CMP AL, DL
			JA FOUND
			PUSH DX
			JMP END_OF_FIND
		
		FOUND:
			PUSH AX
			JMP END_OF_FIND
		
		END_OF_FIND:
			INC SI
			
	LOOP FIND_CAP_LOOP
	
	;confirm capital found
	;by comparing with default value (0 and FF)
	POP AX
	CMP AX, 0
	JE END_FIND_CAP
	CMP AX, 0FFh
	JE END_FIND_CAP
	PUSH AX
	
	END_FIND_CAP:
		PUSH BX
		RET
		
FIND_CAP ENDP	

DISPLAY_CAP PROC
	POP BX
	
	CMP SP, 0FFFEh
	JE NO_CAP
	
	
	POP CX
	;if only one capital
	;then push it two times
	;to print it as both first and last capital
	CMP SP, 0FFFEh
	JNE TWO_CAP
	PUSH CX

	TWO_CAP:
	PUSH CX
	
	;swap contents of stack
	;so that SP points to first capital
	POP CX
	POP DX
	PUSH CX
	PUSH DX
	
	MOV AH, 9
	MOV DX, offset firstC
	INT 21h
	
	MOV AH, 2
	POP DX
	INT 21h
	
	MOV AH, 9
	MOV DX, offset lastC
	INT 21h
	
	MOV AH, 2
	POP DX
	INT 21h
	
	PUSH BX
	
	RET
	
	NO_CAP:
		MOV AH, 9
		MOV DX, offset noC
		INT 21h
		PUSH BX
		
	RET
DISPLAY_CAP ENDP

REV_INPUT PROC
	MOV AH, 9
	MOV DX, offset revStr
	INT 21h
	
	MOV AH, 2
	AND BX, 0
	AND CX, 0
	MOV CL, inpLen
	LEA SI, input
	
	REV_PUSH:
		;show word after reading space
		CMP [SI], ' '
		JE REV_SHOW
		
		
		AND DX, 0
		MOV DL, [SI]
		PUSH DX
		INC BX
		
		;show word if last iteration
		CMP CX, 1
		JE REV_SHOW
		
		JMP END_OF_REV_LOOP
		
		REV_SHOW:
			MOV DL, ' '
			INT 21h
			;pop word from stack
			;to display in reverse
			REV_POP:
				CMP BX, 0
				JE END_OF_REV_LOOP
				POP DX
				INT 21h
				DEC BX
			JMP REV_POP
		JMP END_OF_REV_LOOP	
		
		
		END_OF_REV_LOOP:
			INC SI
		
	LOOP REV_PUSH
	
	RET
REV_INPUT ENDP	

.data
enterStr DB 'Enter: $'
firstC DB 0Ah, 0Dh, 'First Capital: $'
lastC DB 0Ah, 0Dh, 'Last Capital: $'
noC DB 0Ah, 0Dh, 'No Capital Letters$'
revStr DB 0Ah, 0Dh, 'Reverse: $'
isFindFirst DB 1
inpLen DB 0
input DB ?
