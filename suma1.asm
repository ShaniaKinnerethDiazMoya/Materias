.model small      ; Modelo de memoria small (64 KB para c?digo y datos)
.stack            ; Define la pila
.data             ; Inicio de la secci?n de datos

num1 db 0         ; Variable para almacenar el primer n?mero ingresado
num2 db 0         ; Variable para almacenar el segundo n?mero ingresado
num3 db 0         ; Variable para almacenar el resultado de la suma

mensaje db 10,13,7, "Primer numero", "$"  ; Mensaje para solicitar el primer n?mero (con salto de l?nea y campana)
mensaje2 db 10,13,7, "Segundo numero", "$" ; Mensaje para solicitar el segundo n?mero
mensaje3 db 10,13,7, "La suma es", "$"    ; Mensaje para mostrar el resultado de la suma

.code             ; Inicio de la secci?n de c?digo
main proc         ; Procedimiento principal

mov ax, SEG @data ; Carga el segmento de datos en AX
mov ds, ax        ; Mueve el valor de AX a DS para acceder a las variables en el segmento de datos

mov ah, 09h       ; Funci?n 09h de DOS para mostrar una cadena
lea dx, mensaje   ; Cargar la direcci?n del mensaje en DX
int 21h           ; Interrupci?n 21h para mostrar el mensaje "Primer numero"

mov ah, 01h       ; Funci?n 01h de DOS para leer un car?cter desde el teclado
int 21h           ; Llamada a la interrupci?n para capturar el primer d?gito
sub al, 30h       ; Convierte el valor ASCII del d?gito ingresado a su valor num?rico
mov num1, al      ; Almacena el primer n?mero en la variable num1

mov ah, 09h       ; Funci?n 09h de DOS para mostrar una cadena
lea dx, mensaje2  ; Cargar la direcci?n del mensaje2 en DX
int 21h           ; Interrupci?n 21h para mostrar el mensaje "Segundo numero"

mov ah, 01h       ; Funci?n 01h para leer otro car?cter desde el teclado
int 21h           ; Llamada a la interrupci?n para capturar el segundo d?gito
sub al, 30h       ; Convierte el valor ASCII del d?gito ingresado a su valor num?rico
mov num2, al      ; Almacena el segundo n?mero en la variable num2

mov al, num1      ; Cargar el primer n?mero (num1) en el registro AL
add al, num2      ; Sumar el segundo n?mero (num2) al valor en AL
add al, 30h       ; Convertir el resultado num?rico a su valor ASCII
mov num3, al      ; Almacenar el resultado de la suma en la variable num3

mov ah, 09h       ; Funci?n 09h para mostrar una cadena
lea dx, mensaje3  ; Cargar la direcci?n del mensaje3 en DX
int 21h           ; Interrupci?n 21h para mostrar el mensaje "La suma es"

mov ah, 02h       ; Funci?n 02h de DOS para mostrar un solo car?cter
mov dl, num3      ; Cargar el resultado (num3) en DL
int 21h           ; Interrupci?n 21h para mostrar el resultado de la suma

mov ax, 4c00h     ; Finaliza el programa correctamente
int 21h           ; Llamada a la interrupci?n para terminar el programa

main endp         ; Fin del procedimiento principal
end main          ; Marca el final del programa
