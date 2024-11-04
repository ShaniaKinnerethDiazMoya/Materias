; Programa: Mostrar el n?mero menor
; Ensamblador: TASM/MASM
; Entorno: DOS o DOSBox

.model small
.stack 100h

.data
    mensaje1 db 'Ingrese el primer numero (0-9): $'
    mensaje2 db 0Dh, 0Ah, 'Ingrese el segundo numero (0-9): $'
    mensaje_menor db 0Dh, 0Ah, 'El menor numero es: $'
    numero1 db 0
    numero2 db 0
    resultado db '0', 0Dh, 0Ah, '$'

.code
main:
    mov ax, @data        ; Inicializar segmento de datos
    mov ds, ax

    ; Pedir el primer n?mero
    mov ah, 09h          ; Funci?n 09h para imprimir cadena
    lea dx, mensaje1     ; Cargar el mensaje 1
    int 21h              ; Llamar a DOS para mostrar el mensaje

    ; Capturar el primer n?mero
    mov ah, 01h          ; Funci?n 01h para entrada de un car?cter
    int 21h              ; Llamar a DOS para capturar el n?mero
    sub al, '0'          ; Convertir car?cter ASCII a n?mero
    mov [numero1], al    ; Guardar el primer n?mero

    ; Pedir el segundo n?mero
    mov ah, 09h          ; Funci?n 09h para imprimir cadena
    lea dx, mensaje2     ; Cargar el mensaje 2
    int 21h              ; Llamar a DOS para mostrar el mensaje

    ; Capturar el segundo n?mero
    mov ah, 01h          ; Funci?n 01h para entrada de un car?cter
    int 21h              ; Llamar a DOS para capturar el n?mero
    sub al, '0'          ; Convertir car?cter ASCII a n?mero
    mov [numero2], al    ; Guardar el segundo n?mero

    ; Comparar los dos n?meros
    mov al, [numero1]    ; Cargar el primer n?mero en AL
    cmp al, [numero2]    ; Comparar con el segundo n?mero
    jg segundo_menor     ; Si el primer n?mero es mayor, saltar

    ; Si el primer n?mero es menor o igual
    mov al, [numero1]    ; Cargar el primer n?mero en AL
    jmp mostrar_resultado

segundo_menor:
    ; Si el segundo n?mero es menor
    mov al, [numero2]    ; Cargar el segundo n?mero en AL

mostrar_resultado:
    ; Convertir el n?mero menor de nuevo a ASCII
    add al, '0'          ; Convertir n?mero a car?cter ASCII
    mov [resultado], al  ; Guardar el car?cter en 'resultado'

    ; Mostrar el n?mero menor
    mov ah, 09h          ; Funci?n 09h para imprimir cadena
    lea dx, mensaje_menor; Cargar el mensaje "El menor numero es: "
    int 21h              ; Llamar a DOS para mostrar el mensaje

    ; Mostrar el resultado (n?mero menor)
    lea dx, resultado    ; Cargar el resultado
    int 21h              ; Llamar a DOS para mostrar el n?mero menor

    ; Finalizar el programa
    mov ah, 4Ch          ; Funci?n 4Ch para terminar el programa
    int 21h              ; Llamar a DOS

end main

