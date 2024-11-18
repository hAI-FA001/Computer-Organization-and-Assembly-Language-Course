org 100h

.data
nums DB 2 DUP(0)
isNegative DB 0

minStr DB 'Minimum is: '
minStrSize DW $-minStr

.code

MAIN PROC
	MOV CX, 2
	LEA SI, nums
	GET_IN:
		CALL GET_DEC
		INC SI
		CALL PRINT_LN
	LOOP GET_IN
	
	CALL PRINT_LN
	
	LEA SI, minStr
	MOV AH, 2
	MOV CX, minStrSize
	Show_MinStr:
		MOV DL, [SI]
		INT 21h
		INC SI
	LOOP Show_MinStr
	
	AND DX, 0
	MOV AL, nums
	CMP AL, nums+1
	JL num1_Less
	MOV DL, nums+1
	CALL SHOW_LESS
	RET
	
	num1_Less:
		MOV DL, nums
		CALL SHOW_LESS
	
	RET	
MAIN ENDP

PRINT_LN PROC
	MOV AH, 2
	MOV DL, 0Ah
	INT 21h
	MOV DL, 0Dh
	INT 21h
	RET
PRINT_LN ENDP

GET_DEC PROC
	
	TAKE_IN:
		MOV AH, 1
		INT 21h
		
		CMP AL, '-'
		JE IS_NEG
		CMP AL, 0Ah
		JE DONE
		CMP AL, 0Dh
		JE DONE
		
		AND AL, 0Fh
		MOV BL, AL
		
		AND AX, 0
		MOV AL, [SI]
		MOV DL, 10
		MUL DL
		ADD AL, BL
		MOV [SI], AL
		JMP TAKE_IN
		
		IS_NEG:
			MOV isNegative, 1
	JMP TAKE_IN
	
	DONE:
		CMP isNegative, 1
		JE NEGATE
		
		RET
		
		NEGATE:
			MOV isNegative, 0
			NEG [SI]
	RET
GET_DEC ENDP

SHOW_LESS PROC
	CMP DL, 0
	JGE AFTER_NEGATE
	NEG DL
	MOV CL, DL
	
	MOV AH, 2
	MOV DL, '-'
	INT 21h
	
	MOV DL, CL
	
	AFTER_NEGATE:
		MOV CX, 0
		MOV AX, 0
		MOV AL, DL
		
		SEP_DIGITS:
			MOV BX, 10
			DIV BL
			
			MOV BL, AH
			PUSH BX
			
			INC CX
			AND AH, 0
			CMP AX, 0
			JE DISPLAY
		JMP SEP_DIGITS

		DISPLAY:
			MOV AH, 2
			POP DX
			OR DL, 30h
			INT 21h
		LOOP DISPLAY
	
	RET
SHOW_LESS ENDP