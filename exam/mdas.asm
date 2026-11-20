; MDAS with input: pick ONE operation below

mov dx, offset p1
call ask
mov w[n1], ax
mov dx, offset p2
call ask
mov w[n2], ax

; ===== choose ONE operation =====

; --- MULTIPLY (active) ---
; mov ax, w[n1]
; mul w[n2]
; mov dx, offset m1

; --- DIVIDE ---
mov ax, w[n1]
xor dx, dx
div w[n2]
mov dx, offset m2


; --- ADD ---
; mov ax, w[n1]
; add ax, w[n2]
; mov dx, offset m3

; --- SUBTRACT ---
; mov ax, w[n1]
; sub ax, w[n2]
; mov dx, offset m4

; ================================

call show
int 20h

; ask: dx = prompt, returns number in ax
ask:
    mov ah, 9
    int 21h
    call read_num
    ret

; reads digits until Enter, returns number in ax
read_num:
    xor bx, bx
rn1:
    mov ah, 1
    int 21h
    cmp al, 13
    je rn2
    sub al, '0'
    mov ah, 0
    mov cx, ax
    mov ax, bx
    mov dx, 10
    mul dx
    add ax, cx
    mov bx, ax
    jmp rn1
rn2:
    mov dx, offset nl
    mov ah, 9
    int 21h
    mov ax, bx
    ret

; show: dx = message, ax = number to print
show:
    push ax
    mov ah, 9
    int 21h
    pop ax
    call print_num
    mov dx, offset nl
    mov ah, 9
    int 21h
    ret

; prints ax as decimal
print_num:
    mov bx, 10
    xor cx, cx
pn1:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne pn1
pn2:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop pn2
    ret

p1 db 'Enter first number: $'
p2 db 'Enter second number: $'
m1 db 'Product: $'
m2 db 'Quotient: $'
m3 db 'Sum: $'
m4 db 'Difference: $'
nl db 13, 10, '$'

n1 dw 0
n2 dw 0