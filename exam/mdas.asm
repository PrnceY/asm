; Simple MDAS calculator using two single-digit numbers.
; Enter number, operator (+ - * /), then number.
        ORG 100

        MOV AH,9
        MOV DX,OFFSET MSG1
        INT 21
        MOV AH,1
        INT 21
        SUB AL,'0'
        MOV BL,AL


        MOV AH,9
        MOV DX,OFFSET MSG2
        INT 21
        MOV AH,1
        INT 21
        MOV BH,AL


        MOV AH,9
        MOV DX,OFFSET MSG3
        INT 21
        MOV AH,1
        INT 21
        SUB AL,'0'
        MOV CL,AL


        MOV AL,BL
        CMP BH,'+'
        JE ADD_NUM
        CMP BH,'-'
        JE SUB_NUM
        CMP BH,'*'
        JE MUL_NUM
        CMP BH,'/'
        JE DIV_NUM
        JMP EXIT


ADD_NUM:
        ADD AL,CL
        JMP SHOW
SUB_NUM:
        CMP AL,CL
        JB NEGATIVE
        SUB AL,CL
        JMP SHOW
MUL_NUM:
        MUL CL
        JMP SHOW
DIV_NUM:
        CMP CL,0
        JE ZERO_DIV
        XOR AH,AH
        DIV CL
        JMP SHOW


SHOW:
        XOR AH,AH
        MOV BL,10
        DIV BL
        MOV BH,AH
        CMP AL,0
        JE ONE_DIGIT
        ADD AL,'0'
        MOV DL,AL
        MOV AH,2
        INT 21
ONE_DIGIT:
        MOV DL,BH
        ADD DL,'0'
        MOV AH,2
        INT 21
        JMP EXIT


NEGATIVE:
        MOV AH,9
        MOV DX,OFFSET NEGMSG
        INT 21
        JMP EXIT
ZERO_DIV:
        MOV AH,9
        MOV DX,OFFSET ZMSG
        INT 21


EXIT:
        MOV AH,9
        MOV DX,OFFSET ENDMSG
        INT 21
        MOV AX,4C00
        INT 21


MSG1 DB 'First digit (0-9): $'
MSG2 DB 13,10,'Operator (+ - * /): $'
MSG3 DB 13,10,'Second digit (0-9): $'
NEGMSG DB 13,10,'Negative result not supported.$'
ZMSG DB 13,10,'Cannot divide by zero.$'
ENDMSG DB 13,10,'$'