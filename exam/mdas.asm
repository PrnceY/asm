        ORG 100h

START:
        MOV AH,9
        MOV DX,OFFSET MSG1
        INT 21h
        CALL READNUM
        MOV DI,AX          ; store first number in BX

        MOV AH,9
        MOV DX,OFFSET MSG2
        INT 21h
        MOV AH,1
        INT 21h
        XOR AH,AH
        MOV SI,AX           ; store operator in SI

        MOV AH,9
        MOV DX,OFFSET MSG3
        INT 21h
        CALL READNUM
        MOV CX,AX          ; store second number in CX

        MOV AX,DI
        CMP SI,'+'
        JE ADD_NUM
        CMP SI,'-'
        JE SUB_NUM
        CMP SI,'*'
        JE MUL_NUM
        CMP SI,'/'
        JE DIV_NUM
        JMP EXIT

ADD_NUM:
        ADD AX,CX
        JMP SHOW
SUB_NUM:
        CMP AX,CX
        JB NEGATIVE
        SUB AX,CX
        JMP SHOW
MUL_NUM:
        PUSH CX
        MUL CX
        POP CX
        JMP SHOW
DIV_NUM:
        CMP CX,0
        JE ZERO_DIV
        XOR DX,DX
        DIV CX
        JMP SHOW

SHOW:
        PUSH AX
        MOV AH,9
        MOV DX,OFFSET RESMSG
        INT 21h
        POP AX
        MOV BX,10
        XOR CX,CX
        XOR DX,DX
PUSH_LOOP:
        XOR DX,DX
        DIV BX
        PUSH DX
        INC CX
        CMP AX,0
        JNE PUSH_LOOP
POP_LOOP:
        POP DX
        ADD DL,'0'
        MOV AH,2
        INT 21h
        DEC CX
        JNZ POP_LOOP
        JMP EXIT

NEGATIVE:
        MOV AH,9
        MOV DX,OFFSET NEGMSG
        INT 21h
        JMP EXIT
ZERO_DIV:
        MOV AH,9
        MOV DX,OFFSET ZMSG
        INT 21h

EXIT:
        MOV AH,9
        MOV DX,OFFSET ENDMSG
        INT 21h
        MOV AH,4Ch
        MOV AL,0
        INT 21h

; --- READNUM: reads digits until Enter, returns number in AX ---
READNUM:
        XOR AX,AX
RLOOP:
        PUSH AX
        MOV AH,1
        INT 21h
        CMP AL,13
        JE RDONE
        SUB AL,'0'
        XOR AH,AH
        MOV BX,AX
        POP AX
        PUSH BX
        MOV BX,10
        MUL BX
        POP BX
        ADD AX,BX
        JMP RLOOP
RDONE:
        POP AX
        RET

MSG1    DB 'First number: $'
MSG2    DB 13,10,'Operator (+ - * /): $'
MSG3    DB 13,10,'Second number: $'
NEGMSG  DB 13,10,'Negative result not supported.$'
ZMSG    DB 13,10,'Cannot divide by zero.$'
ENDMSG  DB 13,10,'$'
RESMSG  DB 13,10,'Result: $'
;test