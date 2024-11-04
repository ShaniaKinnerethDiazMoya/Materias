.model small
.stack 64
.data
msg_input1 db "Ingrese el primer digito (0-9): $"
msg_input2 db "Ingrese el segundo digito (0-9): $"
msg_multiplicacion db "Multiplicacion: $"
msg_division db "Division: $"
msg_modulo db "Modulo: $"
newline db 0Dh, 0Ah, "$" ; Nueva l?nea para la salida
error_div_cero db "Error: Division entre cero no permitida.$"

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

    ; ---- Multiplicaci?n ----
    mov al, bl         ; Cargar primer n?mero en AL
    mul bh             ; Multiplicar AL * BH (resultado en AX)

    ; Mostrar resultado de la multiplicaci?n
    mov ah, 09h
    lea dx, msg_multiplicacion
    int 21h

    ; Convertir el resultado en AL a ASCII y mostrar
    add al, '0'
    mov dl, al         ; Cargar el d?gito en DL
    mov ah, 02h        ; Funci?n para imprimir un car?cter
    int 21h

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; ---- Divisi?n ----
    mov al, bl         ; Cargar primer n?mero en AL
    mov ah, 0          ; Limpiar AH
    mov cl, bh         ; Segundo n?mero en CL

    ; Comprobar si el divisor es 0
    cmp cl, 0
    je div_cero_error

    ; Realizar la divisi?n
    div cl             ; Dividir AX entre CL (cociente en AL, residuo en AH)

    ; Mostrar resultado de la divisi?n
    mov ah, 09h
    lea dx, msg_division
    int 21h

    ; Convertir cociente a ASCII y mostrar
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; ---- M?dulo ----
    mov al, ah         ; AH contiene el residuo (m?dulo)
    add al, '0'        ; Convertir residuo a ASCII

    ; Mostrar resultado del m?dulo
    mov ah, 09h
    lea dx, msg_modulo
    int 21h

    ; Imprimir el residuo
    mov dl, al
    mov ah, 02h
    int 21h

    ; Fin del programa
    jmp fin_programa

div_cero_error:
    ; Mostrar mensaje de error
    mov ah, 09h
    lea dx, error_div_cero
    int 21h

fin_programa:
    mov ah, 4Ch        ; Terminar el programa
    int 21h
end inicio

