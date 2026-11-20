; MDAS - single digit numbers only for simplicity
; reads two numbers, does A+B, prints result

; read first number
mov ah, 1
int 21h
sub al, '0'
mov bl, al

; read second number  
mov ah, 1
int 21h
sub al, '0'
mov cl, al

; ---- UNCOMMENT ONE BLOCK ONLY ----

; MULTIPLY
mul cl           ; ax = al * cl
jmp print

; DIVIDE
;mov ah, 0
;div cl           ; al = bl / cl
;mov bl, al
;jmp print

; ADD
;add bl, cl
;jmp print

; SUBTRACT
;sub bl, cl
;jmp print

; ---- END BLOCKS ----

print:
mov ah, 2
mov dl, '='
int 21h

mov dl, al
add dl, '0'
int 21h

int 20h