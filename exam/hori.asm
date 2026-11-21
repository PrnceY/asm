; flips the screen horizontally

mov ax, 0b800h  ; fixed address
mov ds, AX      ; read
mov es, AX      ; write

xor bx, BX  
mov cx, 25

rw_loop:
    push CX

    mov si, BX
    mov di, BX
    add di, 160

    mov cx, 40

col_loop:
    mov ax, [si]
    mov [di], ax

    add si, 2
    sub di, 2
    loop col_loop

    add bx, 160
    pop CX
    loop rw_loop

int 20h
