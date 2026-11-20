; rotates the whole screen
; work on this too

mov ax, 0b800h
mov es, ax
mov ds, ax

mov si, 160        ; start reading from row 1
mov di, 0          ; start writing to row 0
mov cx, 24 * 80    ; 24 rows worth of words to copy

copy_loop:
    mov ax, [si]
    mov [di], ax
    add si, 2
    add di, 2
    loop copy_loop

; clear last row
mov di, 24 * 160
mov cx, 80
mov ax, 0720h      ; space + gray color
clear_loop:
    mov [di], ax
    add di, 2
    loop clear_loop

int 20h