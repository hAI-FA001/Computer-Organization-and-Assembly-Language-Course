org 100h

.code
LEA SI, myArr


START:

	MOV AH, 1
	INT 21h
	
	MOV [SI], AL
	INC SI
	
	CMP AL, ' '
	JNE START

DEC SI
MOV CX, SI
SUB CX, offset myArr

LEA SI, myArr

COUNT:
	MOV AL, [SI]
	
	CMP AL, 'a'
	JE IS_VOWEL
	CMP AL, 'A'
	JE IS_VOWEL
	CMP AL, 'e'
	JE IS_VOWEL
	CMP AL, 'E'
	JE IS_VOWEL
	CMP AL, 'i'
	JE IS_VOWEL
	CMP AL, 'I'
	JE IS_VOWEL
	CMP AL, 'o'
	JE IS_VOWEL
	CMP AL, 'O'
	JE IS_VOWEL
	CMP AL, 'u'
	JE IS_VOWEL
	CMP AL, 'U'
	JE IS_VOWEL
	
	JMP AFTER_VOWEL
	
	IS_VOWEL:
		INC vowelCount
	AFTER_VOWEL:
		INC SI

LOOP COUNT

ret


.data
vowelCount DB 0
myArr DB ?