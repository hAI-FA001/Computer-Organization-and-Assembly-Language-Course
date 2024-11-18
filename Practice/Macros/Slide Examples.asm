org 100h

.code
MOVW MACRO W1, W2
	PUSH W1
	POP W2
ENDM

mPutChar MACRO
	PUSH DX
	
	MOV DX, '*'
	mPutChar2 DL
	
	POP DX
ENDM

mPutChar2 MACRO char
	PUSH AX
	PUSH DX
	
	MOV AH, 2
	MOV DL, char
	INT 21h
	
	POP DX
	POP AX
ENDM

mDisplayStr MACRO string
	PUSH AX
	PUSH DX
	
	MOV AH, 9
	MOV DX, offset string
	INT 21h
	
	POP DX
	POP AX
ENDM

EXCH MACRO W1, W2
	PUSH AX
	
	MOV AX, W1
	XCHG AX, W2
	MOV W1, AX
	
	POP AX
ENDM

mRepeat MACRO char, count
	LOCAL L1
	
	MOV CX, count
	
	L1:
		MOV AH, 2
		MOV DL, char
		INT 21h
	LOOP L1
ENDM	

GET_BIG MACRO W1, W2
	LOCAL EXIT
	
	MOV AX, W1
	
	CMP AX, W2
	JG EXIT
	MOV AX, W2
	
	EXIT:
ENDM

SAVE_REGS MACRO R1, R2, R3
	PUSH R1
	PUSH R2
	PUSH R3
ENDM

RESTORE_REGS MACRO S1, S2, S3
	POP S1
	POP S2
	POP S3
ENDM

COPY MACRO SRC, DEST, LEN
	SAVE_REGS CX, SI, DI
	
	LEA SI, SRC
	LEA DI, DEST
	CLD
	MOV CX, LEN
	REP MOVSB
	
	RESTORE_REGS DI, SI, CX
ENDM

MAIN PROC
	MOVW A, B
	mPutChar
	mPutChar2 Char
	mDisplayStr MyStr
	
	MOV AX, 5
	MOV BX, 0
	EXCH AX, BX
	
	MOV AX, 9
	mRepeat Char, AX
	
	MOV A, AX
	SUB A, 5
	SUB B, 5
	
	GET_BIG A, B
	
	COPY MyStr, MyStr2, MyStrLen
	
	RET
MAIN ENDP

.data
A DW 1
B DW 2

Char DB '#'

MyStr DB 0Ah, 0Dh, 'This is string$'
MyStrLen DW $-MyStr

MyStr2 DB 0Ah, 0Dh, 'This is another String$'