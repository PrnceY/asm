mov ah, 9
mov dx, OFFSET MESSAGE
INT 21h

MESSAGE DB 'HELLO', 0dh, 0ah, 'HI$'

