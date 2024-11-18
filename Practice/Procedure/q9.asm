;9, 10

org 100h
.stack 100h

.data
choice DB 'Y'
msgPrompt DB 0Ah, 0Dh, 'ENTER AN ALGEBRAIC EXPRESSION: $'
msgErrorTooMany DB 0Ah, 0Dh, 'TOO MANY RIGHT BRACKETS$'
msgErrorMismatch DB 0Ah, 0Dh, 'BRACKET MISMATCH'
msgPrompt2 DB 0Ah, 0Dh, 'Try again? $'
msgCorrect DB 0Ah, 0Dh, 'EXPRESSION IS CORRECT$'
msgErrorTooManyLeft DB 0Ah, 0Dh, 'TOO MANY LEFT BRACKETS$'

.code
MAIN PROC
	MAIN_LOOP:
		MOV DX, offset msgPrompt
		MOV AH, 9
		INT 21h
		
		CALL START_PROCESS
		
		MOV DX, offset msgPrompt2
		MOV AH, 9
		INT 21h
		
		MOV AH, 1
		INT 21h
		MOV choice, AL
		
		CMP choice, 'Y'
		JE MAIN_LOOP
		CMP choice, 'y'
		JE MAIN_LOOP
	
	END_MAIN:
		ret
		
MAIN ENDP

START_PROCESS PROC
	MOV AH, 1
	
	PROCESS:
		INT 21h
		CMP AL, 0Ah
		JE CHECK_LEFT
		CMP AL, 0Dh
		JE CHECK_LEFT
		
		CMP AL, '('
		JE PUSH_BRACKETS
		CMP AL, '['
		JE PUSH_BRACKETS
		CMP AL, '{'
		JE PUSH_BRACKETS
		
		CMP AL, ')'
		JE CHECK
		CMP AL, ']'
		JE CHECK
		CMP AL, '}'
		JE CHECK
		JMP PROCESS
		
		PUSH_BRACKETS:
			MOV DL, AL
			AND DH, 0
			PUSH DX
			JMP PROCESS
		
		CHECK:
			CMP SP, 0FFFCh
			JE TOO_MANY
			POP DX
			
			CMP AL, ')'
			JE CHECK_ROUND
			CMP AL, ']'
			JE CHECK_SQUARE
			CMP AL, '}'
			JE CHECK_CURLY
			
		CHECK_ROUND:
			CMP DL, '('
			JNE MISMATCHED
			JMP PROCESS
			
		CHECK_SQUARE:
			CMP DL, '['
			JNE MISMATCHED
			JMP PROCESS
			
		CHECK_CURLY:
			CMP DL, '{'
			JNE MISMATCHED		
			JMP PROCESS
			
		CHECK_LEFT:
			CMP SP, 0FFFCh
			JE CORRECT
			JMP TOO_MANY_LEFT
	
	
	JMP PROCESS
	
	MISMATCHED:
		MOV AH, 9
		MOV DX, offset msgErrorMismatch
		INT 21h
		JMP END_PROCESS
	
	TOO_MANY:
		MOV AH, 9
		MOV DX, offset msgErrorTooMany
		INT 21h
		JMP END_PROCESS
	
	TOO_MANY_LEFT:
		MOV AH, 9
		MOV DX, offset msgErrorTooManyLeft
		INT 21h
		
		CLEAR_STACK:
			POP DX
			CMP SP, 0FFFCh
			JNE CLEAR_STACK
		
		JMP END_PROCESS	
		
	
	
	CORRECT:
		MOV AH, 9
		MOV DX, offset msgCorrect
		INT 21h
		JMP END_PROCESS
	
	END_PROCESS:
		ret
START_PROCESS ENDP