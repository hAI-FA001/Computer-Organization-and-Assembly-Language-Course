org 100h

.code
NUMBER EQU 1101_1100b

MOV AL, NUMBER
MOV BL, 0
MOV CX, 8

REV:
	
	SHR AL, 1
	RCL BL, 1

LOOP REV

MOV AL, BL

ret