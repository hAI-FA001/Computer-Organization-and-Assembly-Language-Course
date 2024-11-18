org 100h

.data
myArray DW '0', '1','2','3','4','5','6','7','8','9'
myStr DW 'a','b','c','d','e','f'

myDup DB 2 DUP(30h), 3 DUP(31h), 1 DUP(35h)
twoDNum DB 0, 0, 0, 0, 1
		DB	0, 0, 0, 0, 2
		DB	0, 0, 0, 0, 3
		DB	0, 0, 0, 0, 4
		DB	0, 0, 0, 0, 5
		DB	0, 0, 0, 0, 6
		DB	0, 0, 0, 0, 7


.code



COMMENT @
LEA SI, myArray
MOV AX, offset myArray


MOV AX, [SI]

MOV AX, myArray[SI]
MOV AX, myArray + SI
MOV AX, myArray + [SI]
MOV AX, [myArray + SI]

MOV AX, [SI]
ADD SI, 2
ADD AX, [SI]
@


LEA BX, twoDNum
MOV AL, [BX + (6*5) + 4] ;(row to go - 1) * (no. of col.s) + col. of that row-1


MOV AL, 0
MOV CX, 6*5+4 +1
TOP:
	ADD AL, [BX]
	INC BX
	LOOP TOP

MOV DL, myDup + (6-1)*1




MOV AH, 2
INT 21h

ret