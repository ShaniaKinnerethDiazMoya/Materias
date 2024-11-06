.model small
.stack 64
.data
    msg_input1 db "Ingrese el primer numero (00-99): $"
    msg_input2 db "Ingrese el segundo numero (00-99): $"
    msg_suma db "Suma: $"
    newline db 0Dh, 0Ah, "$"    ; Nueva l?nea

.code
inicio:
    mov ax, @data      ; Inicializar el segmento de datos
    mov ds, ax

    ; Solicitar el primer n?mero
    mov ah, 09h        ; Funci?n para imprimir cadena
    lea dx, msg_input1 ; Direcci?n del mensaje
    int 21h            ; Llamada a DOS para imprimir

    ; Leer primer n?mero de dos d?gitos
    mov ah, 01h        ; Funci?n para leer car?cter
    int 21h            ; Leer primer d?gito
    sub al, '0'        ; Convertir ASCII a valor num?rico
    mov bl, al         ; Guardar primer d?gito en BL
    mov ah, 01h
    int 21h            ; Leer segundo d?gito
    sub al, '0'
    mov bh, al         ; Guardar segundo d?gito en BH
    mov al, bl
    mov bl, 10
    mul bl             ; Multiplicar el primer d?gito por 10
    add al, bh         ; Sumar el segundo d?gito
    mov bl, al         ; Guardar el primer n?mero completo en BL

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; Solicitar el segundo n?mero
    mov ah, 09h
    lea dx, msg_input2
    int 21h

    ; Leer segundo n?mero de dos d?gitos
    mov ah, 01h
    int 21h            ; Leer primer d?gito
    sub al, '0'
    mov bh, al         ; Guardar primer d?gito en BH
    mov ah, 01h
    int 21h            ; Leer segundo d?gito
    sub al, '0'
    mov dl, al         ; Guardar segundo d?gito en DL
    mov al, bh
    mov bh, 10
    mul bh             ; Multiplicar el primer d?gito por 10
    add al, dl         ; Sumar el segundo d?gito
    mov bh, al         ; Guardar el segundo n?mero completo en BH

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h

    ; ---- Suma ----
    mov al, bl         ; Cargar primer n?mero en AL
    add al, bh         ; Sumar AL + BH (resultado en AL)
    mov ah, 0          ; Limpiar AH para el uso en la conversi?n de salida

    ; Mostrar resultado de la suma
    mov ah, 09h
    lea dx, msg_suma
    int 21h
    call imprimir_numero

    ; Terminar el programa
    mov ah, 4Ch        ; Funci?n para salir del programa
    int 21h

; Subrutina para imprimir un n?mero de dos d?gitos en ASCII
imprimir_numero:
    ; Convertir AL (0-199) en dos caracteres ASCII
    mov ah, 0          ; Limpiar AH para dividir
    mov bl, 10
    div bl             ; Dividir AL entre 10 (cociente en AL, residuo en AH)
    add al, '0'        ; Convertir cociente a ASCII
    mov dl, al
    mov ah, 02h        ; Imprimir primer d?gito
    int 21h
    mov al, ah         ; El residuo est? en AH
    add al, '0'        ; Convertir residuo a ASCII
    mov dl, al
    mov ah, 02h        ; Imprimir segundo d?gito
    int 21h
    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
end inicio




