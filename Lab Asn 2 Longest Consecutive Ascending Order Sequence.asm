org 100h

.code

CRET EQU 0Dh
NEWL EQU 0Ah


LEA SI, prompt
MOV CX, pLen

SHOW_PROMPT:

	MOV DL, [SI]
	MOV AH, 2
	INT 21h
	
	INC SI

LOOP SHOW_PROMPT



LEA SI, inputArr
MOV startAddr, SI
AND CX, 0 ;CX holds length of current input sequence


TAKE_INPUT:
	
	MOV AH, 1
	INT 21h
	
	CMP AL, CRET
	JE STOP_INPUT
	
	CMP AL, '0'
	JL TAKE_INPUT
	CMP AL, '9'
	JG TAKE_INPUT
	
	INC CX
	MOV [SI], AL
	CMP AL, [SI-1]
	JL ORDER_BROKEN
	
	INC SI
	JMP TAKE_INPUT
	
	ORDER_BROKEN:
		CMP CX, length
		JG IS_LONGER_SEQ
		
		CMP AL, CRET
		JE STOP_LOOP
		
		MOV CX, 1 ;last input taken is counted for next input sequence
				  ;e.g. 5671 -> '1' is part of next sequence e.g. 567123
		INC SI

		JMP TAKE_INPUT	
	
	IS_LONGER_SEQ:
		DEC CX ;last input taken is not counted for current input sequence
			   ;e.g. 5671 -> '1' is not part of 567
		
		JMP UPDATE_SEQ
		AFTER_UPDATE:
		
		MOV CX, 1
		INC SI
		JMP TAKE_INPUT


STOP_INPUT:
	INC CX
	JMP ORDER_BROKEN ;check if need to update longest sequence

	
STOP_LOOP:

	MOV CX, length
	JCXZ AFTER_LOOP	;if nothing entered (CX is 0), skip display loop



	LEA SI, outMsg
	MOV CX, outLen

	SHOW_OUT_MSG:

		MOV DL, [SI]
		MOV AH, 2
		INT 21h
	
		INC SI

	LOOP SHOW_OUT_MSG



	MOV SI, startAddr
	MOV CX, length
		
	START_DISPLAY:
		MOV DL, [SI]
		
		MOV AH, 2
		INT 21h 
		
		INC SI
		
	LOOP START_DISPLAY
	
AFTER_LOOP:	
	ret


UPDATE_SEQ:
	;Updating startAddr to point to new longest sequence
	
	;e.g. 			       ...0 1 2 3 4 0 1 0 1 2 3 0 1 2 3 4 5 6 7 0
	;current longest seq start^                     ^start of new longest seq
	;----------------------------------------------------------------------
	;SI points after new seq's end
	;	   ...0 1 2 3 4 0 1 0 1 2 3 0 1 2 3 4 5 6 7 0
	;											    ^SI = DX
	MOV DX, SI

	;CX has length of new seq
	;	   ...0 1 2 3 4 0 1 0 1 2 3 0 1 2 3 4 5 6 7 0
	;                               ^DX-CX
	SUB DX, CX
	MOV startAddr, DX
	MOV length, CX
	
	CMP AL, CRET
	JNE AFTER_UPDATE
	
	JMP STOP_LOOP





.data
prompt db 'Enter a string of numbers:',NEWL,CRET
pLen dw $-prompt
outMsg db NEWL,CRET,'The longest consecutive ascending order sequence is:',NEWL,CRET
outLen dw $-outMsg

startAddr dw 0 ;contains start address of longest sequence
length dw 0 ;contains length of longest sequence
inputArr db ? ;contains all input