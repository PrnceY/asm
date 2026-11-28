mov ax, 0b800h
mov es, ax
mov si, 0

start:
    mov bp, 0


nextrow:
    mov di, bp
    mov ax, word ptr es:[di]
    push AX
    add di, 2
    mov cx, 79
; ; "Move Left to Right"
;   nextrow:
;     mov di, bp
;     add di, 158
;     mov ax, word ptr es:[di]
;     push ax
;     sub di, 2
;     mov cx, 79

forward:
    mov ax, word ptr es:[di]
    mov word ptr es:[di - 2], ax
    add di, 2
; forward:
;     mov ax, word ptr es:[di]
;     mov word ptr es:[di + 2], ax
;     sub di, 2

    loop forward

    pop ax

    mov di, BP ;remove this
    add di, 158 ; remove this
    mov word ptr es:[di], ax
    ; mov word ptr es:[bp], ax


    add bp, 160
    cmp bp, 4000
    jb nextrow
    mov dx, 5

delay:
    mov cx, 0ffffh

doit:
    dec cx
    cmp cx, 0
    ja doit

    dec dx
    cmp dx, 0
    ja delay

    inc si
    cmp si, 80
    jb start

    int 21h
