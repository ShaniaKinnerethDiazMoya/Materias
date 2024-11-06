.model small
.stack 64
.data
    msg_input1 db "Ingrese el primer numero (00-99): $"
    msg_input2 db "Ingrese el segundo numero (01-99): $"
    msg_division db "Cociente: $"
    msg_error db "No se puede dividir por cero.$"
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

    ; ---- Divisi?n ----
    mov al, bl         ; Cargar primer n?mero en AL
    mov bl, bh         ; Cargar segundo n?mero en BL

    cmp bl, 0          ; Verificar si el segundo n?mero es cero
    je mostrar_error   ; Si es cero, mostrar error y salir

    xor ah, ah         ; Limpiar AH para la divisi?n
    div bl             ; Dividir AL / BL (cociente en AL, residuo en AH)

    ; Mostrar resultado de la divisi?n (cociente)
    mov ah, 09h
    lea dx, msg_division
    int 21h
    call imprimir_numero
    jmp fin_programa

mostrar_error:
    ; Mostrar mensaje de error si el divisor es cero
    mov ah, 09h
    lea dx, msg_error
    int 21h
    jmp fin_programa

fin_programa:
    ; Terminar el programa
    mov ah, 4Ch        ; Funci?n para salir del programa
    int 21h

; Subrutina para imprimir un n?mero de hasta dos d?gitos en ASCII
imprimir_numero:
    ; Convertir AL (0-99) en caracteres ASCII
    mov cx, ax         ; Guardar AX en CX para imprimir cada d?gito

    ; Primer d?gito (decenas)
    mov bx, 10
    xor dx, dx         ; Limpiar DX
    div bx             ; Dividir AL entre 10
    add al, '0'        ; Convertir a ASCII
    mov dl, al
    mov ah, 02h
    int 21h            ; Imprimir primer d?gito

    ; Segundo d?gito (unidades)
    mov al, ah         ; Transferir residuo a AL
    add al, '0'        ; Convertir a ASCII
    mov dl, al
    mov ah, 02h
    int 21h            ; Imprimir segundo d?gito

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
end inicio
