.model small
.stack 100h
.data
    mensaje db 'Conteo descendente:', 0Dh, 0Ah, '$'
    numero db '0', 0Dh, 0Ah, '$'

.code
main:
    mov ax, @data        ; Inicializar segmento de datos
    mov ds, ax

    ; Mostrar el mensaje inicial
    mov ah, 09h          ; Funci?n 09h para imprimir cadena
    lea dx, mensaje      ; Cargar la direcci?n del mensaje
    int 21h              ; Llamar a la interrupci?n de DOS

    ; Configurar el contador
    mov cx, 10           ; Cargar 10 en CX (para contar de 9 a 0)
    mov al, '9'          ; Cargar '9' en AL (primer n?mero a imprimir)

loop_conteo:
    mov numero, al       ; Guardar el n?mero actual en la variable 'numero'
    
    ; Mostrar el n?mero
    mov ah, 09h          ; Funci?n 09h para imprimir cadena
    lea dx, numero       ; Cargar la direcci?n del n?mero
    int 21h              ; Llamar a la interrupci?n de DOS
    
    ; Disminuir el valor de AL (el car?cter ASCII del n?mero)
    dec al               ; Restar 1 al valor del car?cter
    
    ; Llamar a la instrucci?n loop
    loop loop_conteo     ; Decrementa CX y repite el bucle si CX no es 0

    ; Salir del programa
    mov ah, 4Ch          ; Funci?n 4Ch para terminar el programa
    int 21h              ; Llamar a la interrupci?n de DOS

end main

