.model small
.stack
.data

u db 0
d db 0
n db 0

mensaje db 10,13,7, "Ingrese un numero: ", "$"

mensaje1 db 10,13,7, "Ingrese un numero: ", "$"

mensaje2 db 10,13,7, "Numero ingresado: ", "$"

.code
main proc 
mov ax, SEG @data
mov ds,ax

mov ah, 09h
lea dx,mensaje
int 21h

mov ah,01h
int 21h
sub al,30h
mov d,al

mov ah,01h
int 21h
sub al,30h
mov u,al

mov al,d
mov bl,10
mul bl
add al,u
mov n,al
mov ah, 09h
lea dx, mensaje2
int 21h

mov al,n
AAM
mov bx,ax
mov ah,02h
mov dl, bh
add dl,30h
int 21h
mov ah,02h
mov dl,bl
add dl,30h
int 21h

main endp

end main