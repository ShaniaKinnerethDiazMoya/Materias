; Programa: Conteo Descendente de 99 a 1
; Ensamblador: TASM/MASM
; Entorno: DOS o DOSBox

.model small
.stack 100h

.data
    mensaje db 'Conteo descendente:', 0Dh, 0Ah, '$'
    numero db '00', 0Dh, 0Ah, '$'  ; Variable para almacenar el n?mero a imprimir

.code
main:
    mov ax, @data        ; Inicializar segmento de datos
    mov ds, ax

    ; Mostrar el mensaje inicial
    mov ah, 09h          ; Funci?n 09h de DOS para imprimir cadena
    lea dx, mensaje      ; Cargar la direcci?n del mensaje en DX
    int 21h              ; Llamar a la interrupci?n de DOS

    ; Configurar el contador
    mov cx, 99           ; N?mero de iteraciones (99 a 1)
    mov bx, 99           ; Valor inicial del contador (99)
    mov si, 10           ; Divisor para obtener decenas y unidades

loop_conteo_descendente:
    ; Dividir BX entre 10 para obtener decenas y unidades
    mov ax, bx           ; Mover el valor de BX a AX
    xor dx, dx           ; Limpiar DX antes de la divisi?n
    div si               ; AX / 10 => AL = decenas, DL = unidades

    ; Convertir las decenas a ASCII si es necesario
    cmp al, 0            ; Verificar si hay decenas
    je sin_decenas_descendente
    add al, '0'          ; Convertir decenas a car?cter ASCII
    mov [numero], al     ; Almacenar el car?cter de decenas en 'numero'
    jmp convertir_unidades_descendente

sin_decenas_descendente:
    mov byte ptr [numero], ' '  ; Si no hay decenas, poner un espacio

convertir_unidades_descendente:
    add dl, '0'          ; Convertir unidades a car?cter ASCII
    mov [numero+1], dl   ; Almacenar el car?cter de unidades en 'numero'

    ; Mostrar el n?mero
    mov ah, 09h          ; Funci?n 09h de DOS para imprimir cadena
    lea dx, numero       ; Cargar la direcci?n de 'numero' en DX
    int 21h              ; Llamar a la interrupci?n de DOS

    ; Decrementar el contador
    dec bx               ; Decrementar BX para el siguiente n?mero

    ; Decrementar CX y repetir si no es cero
    loop loop_conteo_descendente

    ; Finalizar el programa
    mov ah, 4Ch          ; Funci?n 4Ch de DOS para terminar el programa
    int 21h              ; Llamar a la interrupci?n de DOS

end main
