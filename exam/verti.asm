; mirrors the screen top to bottom

mov ax, 0b800h
mov ds, ax
mov es, ax

cld
xor si, si          ; source: row 0
mov di, 3840        ; destination: row 24 (24 * 160)
mov bx, 12          ; 12 rows to copy

row_loop:
    mov cx, 80      ; 80 characters per row
    rep movsw       ; copy one whole row
    sub di, 320     ; go back up to the previous row
    dec bx
    jnz row_loop

int 20h