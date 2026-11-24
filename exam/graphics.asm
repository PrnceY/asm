; Draw with the mouse in VGA graphics mode.
; Press 1 for red, 2 for green. Hold left button to draw.
; Press ESC to exit. Requires a DOS mouse driver.
        ORG 100


        XOR AX,AX
        INT 33
        CMP AX,0FFFF
        JNE NO_MOUSE


        MOV AX,13
        INT 10


        MOV AX,7
        MOV CX,0
        MOV DX,639
        INT 33
        MOV AX,8
        MOV CX,0
        MOV DX,199
        INT 33


        MOV BYTE PTR [COLOR],4
        MOV AX,1
        INT 33


MAIN:
        MOV AH,1
        INT 16
        JZ MOUSE
        MOV AH,0
        INT 16
        CMP AL,27
        JE QUIT
        CMP AL,'1'
        JNE GREEN
        MOV BYTE PTR [COLOR],4
        JMP MOUSE
GREEN:
        CMP AL,'2'
        JNE MOUSE
        MOV BYTE PTR [COLOR],2


MOUSE:
        MOV AX,3
        INT 33
        TEST BX,1
        JZ MAIN
        SHR CX,1
        MOV AH,0C
        MOV AL,[COLOR]
        MOV BH,0
        INT 10
        JMP MAIN


QUIT:
        MOV AX,2
        INT 33
        MOV AX,3
        INT 10
        MOV AX,4C00
        INT 21


NO_MOUSE:
        MOV AH,9
        MOV DX,OFFSET ERRMSG
        INT 21
        MOV AX,4C01
        INT 21


COLOR DB 4
ERRMSG DB 'Mouse driver not found.$'