.model small
.stack 64
.data
    msg_input1 db "Ingrese el primer numero (00-99): $"
    msg_input2 db "Ingrese el segundo numero (00-99): $"
    msg_producto db "Producto: $"
    msg_error db "Resultado mayor a 255. Error.$"
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

    ; ---- Multiplicaci?n ----
    mov al, bl         ; Cargar primer n?mero en AL
    mov bl, bh         ; Cargar segundo n?mero en BL
    mul bl             ; Multiplicar AL * BL (resultado en AX)

    ; Verificar si el resultado es mayor que 255
    cmp ah, 0          ; Si AH no es 0, el resultado es mayor que 255
    jne mostrar_error

    ; Mostrar resultado de la multiplicaci?n
    mov ah, 09h
    lea dx, msg_producto
    int 21h
    call imprimir_numero
    jmp fin_programa

mostrar_error:
    ; Mostrar mensaje de error si el resultado es mayor a 255
    mov ah, 09h
    lea dx, msg_error
    int 21h
    jmp fin_programa

fin_programa:
    ; Terminar el programa
    mov ah, 4Ch        ; Funci?n para salir del programa
    int 21h

; Subrutina para imprimir un n?mero de hasta tres d?gitos en ASCII
imprimir_numero:
    ; Convertir AX (0-255) en caracteres ASCII
    mov cx, ax         ; Guardar AX en CX para imprimir cada d?gito

    ; Primer d?gito (centenas)
    mov bx, 100
    xor dx, dx         ; Limpiar DX
    div bx             ; AX / 100
    add al, '0'        ; Convertir a ASCII
    mov dl, al
    mov ah, 02h
    int 21h            ; Imprimir primer d?gito

    ; Segundo d?gito (decenas)
    mov ax, dx         ; Transferir el residuo a AX
    mov bx, 10
    xor dx, dx         ; Limpiar DX
    div bx             ; Dividir por 10 para obtener decenas
    add al, '0'        ; Convertir a ASCII
    mov dl, al
    mov ah, 02h
    int 21h            ; Imprimir segundo d?gito

    ; Tercer d?gito (unidades)
    add ah, '0'        ; Convertir a ASCII
    mov dl, ah
    mov ah, 02h
    int 21h            ; Imprimir ?ltimo d?gito

    ; Nueva l?nea
    mov ah, 09h
    lea dx, newline
    int 21h
    ret
end inicio



