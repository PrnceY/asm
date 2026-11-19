; unsure of output, ask help


mov ax, 0b800h
mov es, ax
mov ds, ax

mov si, 0
mov di, 24 * 160
mov cx, 12

row_loop:
    push cx
    push si
    push di
    mov cx, 80

    col_loop:
        mov ax, [si]
        mov bx, [di]
        mov [di], ax
        mov [si], bx
        add si, 2
        add di, 2
        loop col_loop

    pop di
    pop si
    add si, 160
    sub di, 160
    pop cx
    loop row_loop

int 20h