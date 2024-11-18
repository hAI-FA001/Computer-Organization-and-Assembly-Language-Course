org 100h

.code
PRINTLN MACRO
	MOV AH, 2
	MOV DL, 0Dh
	INT 21h
	MOV DL, 0Ah
	INT 21h
ENDM

PRINTSPACE MACRO
	MOV AH, 2
	MOV DL, ' '
	INT 21h
ENDM


MAIN PROC
	NEWL EQU 0Ah
	CRET EQU 0Dh
	
	LEA DI, inputStr
	MOV AH, 1
	AND CX, 0
	GET_INPUT:
		INT 21h
		CMP AL, NEWL
		JE END_GET
		CMP AL, CRET
		JE END_GET
		STOSB
		INC CX
		JMP GET_INPUT
		
		
	END_GET:
		JCXZ NO_INPUT
		
		PUSH CX ;save input len
		CAP_A EQU 'A'
		CAP_Z EQU 'Z'
		
		POP CX
		PUSH CX
		
		MOV AL, CAP_Z
		AND AH, 0
		INC AX
		PUSH AX
		
		LEA DI, inputStr
		LEA SI, buffer
		MOV [SI], AL
		
		FIND_FIRST_CAP:
			MOV BL, [DI]
			CMP BL, ' '
			JE IS_SPACE_F
			
			CMPSB
			JG FOUND_LESS
			
			LEA SI, buffer
			LOOP FIND_FIRST_CAP
			JMP FIN_FIRST
			
			IS_SPACE_F:
				INC DI
			LOOP FIND_FIRST_CAP
			
			FOUND_LESS:
				DEC DI
				
				POP BX
				MOV BX, [DI]
				AND BH, 0
				PUSH BX
				
				INC DI
				
				LEA SI, buffer
				MOV [SI], BL
			LOOP FIND_FIRST_CAP		
		
		FIN_FIRST:
			PRINTLN
			POP DX
			CMP DL, 'Z'
			JG NO_CAP
			MOV AH, 2
			INT 21h
			
			
			POP CX
			PUSH CX
			
			MOV AL, CAP_A
			AND AH, 0
			DEC AX
			PUSH AX
			
			
			LEA DI, inputStr
			LEA SI, buffer
			MOV [SI], AL
			
			FIND_LAST_CAP:
				MOV BL, [DI]
				CMP BL, ' '
				JE IS_SPACE_L
				
				CMPSB
				JL FOUND_GREATER
				
				LEA SI, buffer
				LOOP FIND_LAST_CAP
				JMP FIN_LAST
				
				IS_SPACE_L:
					INC DI
				LOOP FIND_LAST_CAP
				
				
				FOUND_GREATER:
					DEC DI
					
					POP BX
					MOV BX, [DI]
					AND BH, 0
					PUSH BX
					
					INC DI
					
					LEA SI, buffer
					MOV [SI], BL
				LOOP FIND_LAST_CAP
			
			
			FIN_LAST:
				PRINTLN
				POP DX
				
				MOV AH, 2
				INT 21h
			
			
		
		NO_CAP:
			PRINTLN
			LEA SI, inputStr
			POP CX
			REV_IN:
				CMP [SI], ' '
				JE SHOW_CUR_WORD
				CMP CX, 0
				JE SHOW_CUR_WORD
				
				LODSB
				AND AH, 0
				PUSH AX
				
				JCXZ END_PROG
				LOOP REV_IN
				
				SHOW_CUR_WORD:
					MOV AH, 2
					
					PRINTING_WORD:
						CMP SP, 0FFFEh
						JE DONE_PRINTING
						
						POP DX
						INT 21h
						
					JMP PRINTING_WORD
					
					DONE_PRINTING:
						PRINTSPACE
						INC SI
			JCXZ END_PROG
			LOOP REV_IN
		
		NO_INPUT:
		
		END_PROG:
			
	RET
MAIN ENDP	

.data
buffer DB 5 DUP(0)
inputStr DB ?