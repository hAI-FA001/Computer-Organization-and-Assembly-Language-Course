org 100h

.data
fibArr db 12 DUP(0)

len = $-fibArr
.code
MOV CX, len
MOV AL, 1
LEA BX, fibArr-1
LEA SI, fibArr-1

TOP:
	INC BX
	MOV [BX], AL
	CMP SI, offset fibArr
	JL AFTER_ADD
	ADD AL, [SI]
	AFTER_ADD:
		INC SI

LOOP TOP

ret