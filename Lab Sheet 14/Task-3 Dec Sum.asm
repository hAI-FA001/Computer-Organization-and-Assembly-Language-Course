org 100h

.data
num1 DW 0
num2 DW 0
sum DW 0

sumStr DB 'Sum is: '
sumStrSize DW $-sumStr

.code
MAIN proc
	CALL Get_DEC
	;POP num1
	MOV num1, CX
	CALL PRINT_LN
	
	
	CALL Get_DEC
	;POP num2
	MOV num2, CX
	CALL PRINT_LN
	
	MOV AX, num1
	ADD AX, num2
	MOV sum, AX
	
	MOV AH, 2
	LEA SI, sumStr
	MOV CX, sumStrSize
	SHOW_SUM_STR:
		MOV DL, [SI]
		INT 21h
		INC SI
	LOOP SHOW_SUM_STR
	
	;PUSH SUM
	CALL Show_DEC
	
	RET
MAIN endp

PRINT_LN proc
	MOV AH, 2
	
	MOV DL, 0Ah
	INT 21h
	
	MOV DL, 0Dh
	INT 21h
	
	RET
PRINT_LN endp

Get_DEC proc
	AND CX, 0
	
	CRET EQU 0Dh
	NEWL EQU 0Ah
	
	MOV AH, 1
	
	TAKE_IN:
		INT 21h
		CMP AL, NEWL
		JE DONE
		CMP AL, CRET
		JE DONE
		
		AND AL, 0Fh
		MOV BL, AL
		
		MOV AX, 10
		MUL CX
		MOV CX, AX
		AND BH, 0
		ADD CX, BX
		
		MOV AH, 1
	JMP TAKE_IN
	
	DONE:
		;PUSH CX
		RET
Get_DEC endp

Show_DEC proc
	;POP AX
	AND CX, 0
	MOV AX, sum
	
	Sep_Digits:
		MOV DX, 0
		MOV BX, 10
		DIV BX
		
		PUSH DX
		
		INC CX
		CMP AX, 0
		JE Display
	JMP Sep_Digits
		
	Display:
		MOV AH, 2
		POP DX
		OR DL, 30h
		INT 21h
	LOOP Display
	RET
Show_DEC endp

ret