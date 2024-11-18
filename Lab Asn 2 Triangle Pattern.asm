org 100h


.data
PROMPT DB 'Please enter a number between 0 - 9: '
LEN DW $-PROMPT
INPUT_NUMBER DB 0


.code

LEA SI, PROMPT
MOV CX, LEN
SHOW_PROMPT:

	MOV DL, [SI]
	MOV AH, 2
	INT 21h
	
	INC SI

LOOP SHOW_PROMPT


TAKE_NUMBER:

	MOV AH, 1
	INT 21h

	CMP AL, '0' ;retake input until number entered
	JL TAKE_NUMBER
	CMP AL, '9'
	JG TAKE_NUMBER


OR INPUT_NUMBER, AL
AND INPUT_NUMBER, 0Fh ;convert ascii to dec

AND CX, 0
OR CL, INPUT_NUMBER


MOV AH, 2

DISPLAY:
	
	;print newline + carriage return
	MOV DL, 0Ah
	INT 21h
	MOV DL, 0Dh
	INT 21h
	
	;print starting star
	MOV DL, '*'
	INT 21h
	
	
	CMP CL, INPUT_NUMBER ;don't enter inner loop on 1st iteration
	JE AFTER_END_STAR	 ;& don't print ending star


	MOV BL, INPUT_NUMBER
	DEC BL
	INNER:
		
		CMP BL, CL
		JE END_INNER
		
		;print hollow
		MOV DL, '_'
		INT 21h

		DEC BL
		JMP INNER
		
	END_INNER:
		
		;print ending star
		MOV DL, '*'
		INT 21h
		
		AFTER_END_STAR:


LOOP DISPLAY


ret	