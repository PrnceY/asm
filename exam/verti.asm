mov ax, 0b800h
mov es, ax

mov si, 0

start:
    mov bp, 0                ; column offset (0,2,4,...158)
nextcol:
    mov di, bp
    add di, 3840             ; last row (24 * 160)
    mov ax, word ptr es:[di] ; save bottom cell

    push ax
    sub di, 160              ; row 23
    mov cx, 24
rotate:
    mov ax, word ptr es:[di]
    mov word ptr es:[di + 160], ax   ; move cell down one row
    sub di, 160
    loop rotate

    pop ax
    mov word ptr es:[bp], ax ; bottom cell wraps to top

    add bp, 2                ; next column
    cmp bp, 160
    jb nextcol

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
    cmp si, 25               ; 25 rows = one full cycle
    jb start

int 20h