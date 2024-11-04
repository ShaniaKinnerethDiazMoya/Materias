.model small
.stack 64
.data
msg_input1 db "Ingrese el primer d?gito (0-9): $"
msg_input2 db "Ingrese el segundo d?gito (0-9): $"
msg_result db "El resultado es: $"
newline db 0Dh, 0Ah, "$" ; Nueva l?nea para la salida

.code
inicio:
    mov ax, @data      ; Inicializar el segmento de datos
    mov ds, ax

    ; Solicitar el primer n?mero
    mov ah, 09h        ; Funci?n para imprimir cadena
    lea dx, msg_input1 ; Direcci?n del mensaje
    int 21h            ; Llamada a DOS para imprimir

    ; Leer primer d?gito
    mov ah, 01h        ; Funci?n para leer car?cter
    int 21h            ; Llamada a DOS para leer car?cter
    sub al, '0'        ; Convertir car?cter ASCII a valor num?rico
    mov bl, al         ; Almacenar el primer n?mero en BL

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Solicitar el segundo n?mero
    mov ah, 09h
    lea dx, msg_input2
    int 21h

    ; Leer segundo d?gito
    mov ah, 01h
    int 21h
    sub al, '0'        ; Convertir car?cter ASCII a valor num?rico
    mov bh, al         ; Almacenar el segundo n?mero en BH

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Realizar la resta
    mov al, bl         ; Cargar primer n?mero en AL
    sub al, bh         ; Restar segundo n?mero de AL (AL = BL - BH)

    ; Manejar resultado negativo
    cmp al, 0
    jl negativo        ; Si el resultado es negativo, ir a la etiqueta 'negativo'

positivo:
    add al, '0'        ; Convertir resultado a ASCII
    jmp mostrar        ; Ir a mostrar el resultado

negativo:
    ; Convertir a positivo
    neg al             ; Cambia el signo del valor en AL
    add al, '0'        ; Convertir resultado a ASCII

    ; Mostrar signo negativo
    mov dl, '-'        ; Colocar el signo '-' en DL
    mov ah, 02h
    int 21h            ; Imprimir el signo

mostrar:
    ; Mostrar el mensaje de resultado
    mov ah, 09h
    lea dx, msg_result
    int 21h

    ; Imprimir el resultado
    mov dl, al         ; Colocar el resultado en DL
    mov ah, 02h        ; Funci?n para imprimir un car?cter
    int 21h

    ; Fin del programa
    mov ah, 4Ch        ; Terminar el programa
    int 21h
end inicio
