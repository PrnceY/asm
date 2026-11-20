; Switch to graphics mode 320x200, 256 colors
mov ax, 0013h
int 10h

mov ax, 0a000h
mov es, ax

; Initialize mouse
mov ax, 0
int 33h

main:
    ; --- check keyboard (non-blocking) ---
    mov ah, 1
    int 16h
    jz mouse_check          ; no key pressed
    mov ah, 0
    int 16h                 ; read key into al
    cmp al, '1'
    je set_red
    cmp al, '2'
    je set_green
    cmp al, 27              ; ESC
    je done
    jmp mouse_check

set_red:
    mov b[color], 4         ; red
    jmp mouse_check

set_green:
    mov b[color], 2         ; green

mouse_check:
    mov ax, 3
    int 33h                 ; bx = buttons, cx = x, dx = y
    test bx, 1              ; left button held?
    jz main

    ; di = y * 320 + x
    shr cx, 1               ; in mode 13h, mouse x is 0-639, so divide by 2
    mov ax, dx
    mov bx, 320
    mul bx                  ; ax = y * 320
    add ax, cx
    mov di, ax

    mov al, [color]
    mov es:[di], al         ; plot pixel
    jmp main

done:
    mov ax, 0003h           ; back to text mode
    int 10h
    int 20h

color db 4                  ; default: red