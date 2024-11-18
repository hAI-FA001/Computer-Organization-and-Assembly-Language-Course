org 100h

.data
DATA db 7,5,3,9,1 ,10, 20, 8, 4, 6, 2
len = $-DATA


.code
MOV DH, len
SUB DH, 2

MOV AL, len
MOV CL, 0
MOV SI, offset DATA

OUTER: ;loop 0 to N-2

	DEC AL
		
	MOV BX, 1
	
	INNER:
	
		MOV DL, [SI+BX]
		CMP DL, [SI+BX-1]
		JNL AFTER_SWAP
		XCHG DL, [SI+BX-1]
		XCHG [SI+BX], DL
		
		AFTER_SWAP:
			INC BX
			CMP BL, AL
			JLE INNER
	
	
	INC CL
	CMP CL, DH
	JLE OUTER
	
ret