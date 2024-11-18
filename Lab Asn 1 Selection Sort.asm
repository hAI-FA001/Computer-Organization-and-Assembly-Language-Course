org 100h

.data
DATA db 7,5,3,9,1 ,10, 20, 8, 4, 6, 2
N dw 11

.code

MOV CX, N
DEC CX ;loop n-1 times
LEA SI, DATA

OUTER:

	MOV BX, 1
	MOV AX, 0
	MOV DL, [SI]
	
	INNER:

		CMP DL, [SI + BX]
		
		JNL AFTER_GREATER
		MOV AX, BX
		MOV DL, [SI + BX]
		
		AFTER_GREATER:
			INC BX
			CMP BX, CX
			JLE INNER
			
	DEC BX
	XCHG DL, [SI + BX]
	MOV BX, AX
	XCHG [SI + BX], DL
	
LOOP OUTER

ret