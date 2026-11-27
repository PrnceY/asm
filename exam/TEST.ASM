prompt db 'Please enter 1 or 2:', 13D, 10D,'$'
Song1 db 'Heaven knows'
Song2 db 'Blue Sky is in pain', 13d, 10d,'$'

ASK:
mov dx, offset prompt
mov ah, 09h
int 21h

GET: 
