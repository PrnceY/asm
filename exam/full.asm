; rotates the whole screen 180 degrees

mov ax, 0b800h
mov ds, ax

xor si, si          ; start of screen
mov di, 3998        ; last character (80 * 25 * 2 - 2)
mov cx, 1000        ; half of 2000 characters

swap_loop:
    mov ax, [si]
    mov bx, [di]
    mov [si], bx
    mov [di], ax

    add si, 2
    sub di, 2
    loop swap_loop

int 20h