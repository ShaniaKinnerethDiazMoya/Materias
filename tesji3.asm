.model small       ; Modelo de memoria small (64 KB para c?digo y datos)
.stack             ; Define la pila
.data              ; Inicio de la secci?n de datos

u db 0             ; Variable para almacenar la unidad (unidades)
d db 0             ; Variable para almacenar la decena
n db 0             ; Variable para almacenar el n?mero completo

mensaje db 10,13,7, "Ingrese un numero: ", "$"  ; Mensaje para pedir un n?mero (con salto de l?nea y campana)
mensaje2 db 10,13,7, "Numero ingresado: ", "$" ; Mensaje para mostrar el n?mero ingresado

.code              ; Inicio de la secci?n de c?digo
main proc          ; Procedimiento principal

mov ax, SEG @data  ; Mueve el segmento de datos al registro AX
mov ds, ax         ; Carga el registro DS con el valor de AX para acceder a los datos

mov ah, 09h        ; Funci?n 09h de DOS para mostrar una cadena
lea dx, mensaje    ; Cargar la direcci?n del mensaje en el registro DX
int 21h            ; Llamada a la interrupci?n 21h para mostrar el mensaje

mov ah, 01h        ; Funci?n 01h de DOS para leer un car?cter desde el teclado
int 21h            ; Llamada a la interrupci?n para leer el primer d?gito
sub al, 30h        ; Convierte el valor ASCII del d?gito a su valor num?rico
mov d, al          ; Almacena el d?gito como decena en la variable 'd'

mov ah, 01h        ; Funci?n 01h para leer otro car?cter
int 21h            ; Llamada a la interrupci?n para leer el segundo d?gito
sub al, 30h        ; Convierte el valor ASCII del d?gito a su valor num?rico
mov u, al          ; Almacena el d?gito como unidad en la variable 'u'

mov al, d          ; Cargar el valor de la decena en AL
mov bl, 10         ; Cargar el valor 10 en BL (para multiplicar por 10)
mul bl             ; Multiplicar AL (decenas) por 10
add al, u          ; Sumar las unidades al resultado (completa el n?mero)
mov n, al          ; Almacenar el n?mero completo en la variable 'n'

mov ah, 09h        ; Funci?n 09h para mostrar otra cadena
lea dx, mensaje2   ; Cargar la direcci?n del mensaje2 en DX
int 21h            ; Mostrar el mensaje

mov al, n          ; Cargar el n?mero completo en AL
AAM                ; Ajuste para el empaquetado BCD (convierte AL a dos d?gitos)
mov bx, ax         ; Mover el resultado de AAM a BX

mov ah, 02h        ; Funci?n 02h de DOS para mostrar un car?cter
mov dl, bh         ; Mover el d?gito de las decenas a DL
add dl, 30h        ; Convertir el valor num?rico a su representaci?n ASCII
int 21h            ; Mostrar el d?gito de las decenas

mov ah, 02h        ; Funci?n 02h para mostrar otro car?cter
mov dl, bl         ; Mover el d?gito de las unidades a DL
add dl, 30h        ; Convertir el valor num?rico a su representaci?n ASCII
int 21h            ; Mostrar el d?gito de las unidades

main endp          ; Fin del procedimiento principal
end main           ; Marca el final del programa
