CR EQU 13         ; Define la constante CR (Carriage Return) con el valor 13 en decimal.
LF EQU 10         ; Define la constante LF (Line Feed) con el valor 10 en decimal (tambi?n conocido como salto de l?nea).

DATOS SEGMENT     ; Inicia el segmento de datos, donde se almacenar?n las cadenas de texto a imprimir.
    LINEA1 DB CR,LF,'Shania Kinnereth Diaz Moya', CR,LF,'$' ; Define la primera l?nea de texto para imprimir, con retornos de carro y saltos de l?nea al inicio y final, seguido por el car?cter '$' que indica el fin de la cadena.
    LINEA2 DB CR,LF,'Tecnologico de estudios superiores de Jilotepec', CR,LF,'$' ; Define la segunda l?nea de texto, con formato similar al anterior.
    LINEA3 DB CR,LF,'ING. Sistemas Computacionales', CR,LF,'$' ; Define la tercera l?nea de texto.
    LINEA4 DB CR,LF,'DARKING :(', CR,LF,'$' ; Define la cuarta l?nea de texto.

DATOS ENDS        ; Finaliza el segmento de datos.

PILA SEGMENT STACK ; Define el segmento de pila, que se usa para almacenar datos temporales durante la ejecuci?n del programa.
    DB 64 DUP('PILA') ; Reserva 64 bytes para la pila, inicializados con el valor 'PILA'.
PILA ENDS         ; Finaliza el segmento de pila.

CODIGO SEGMENT    ; Inicia el segmento de c?digo, donde se coloca la l?gica de ejecuci?n del programa.
    LN PROC FAR    ; Define un procedimiento (subrutina) llamado LN que es de tipo FAR, es decir, puede ser llamado desde cualquier segmento de memoria.

    ASSUME CS:CODIGO,DS:DATOS,SS:PILA ; Instruye al ensamblador sobre la asignaci?n de segmentos para los registros CS (C?digo), DS (Datos), y SS (Pila).
    
    MOV AX,DATOS   ; Carga el valor del segmento de datos en el registro AX.
    MOV DS,AX      ; Inicializa el registro DS con el valor en AX, estableciendo el segmento de datos.
    
    LEA DX, LINEA1 ; Carga la direcci?n de la cadena LINEA1 en el registro DX.
    CALL ESCRIBE   ; Llama al procedimiento ESCRIBE para imprimir la cadena cuyo puntero est? en DX.
    
    LEA DX, LINEA2 ; Carga la direcci?n de la cadena LINEA2 en el registro DX.
    CALL ESCRIBE   ; Llama al procedimiento ESCRIBE para imprimir la cadena LINEA2.
    
    LEA DX, LINEA3 ; Carga la direcci?n de la cadena LINEA3 en el registro DX.
    CALL ESCRIBE   ; Llama al procedimiento ESCRIBE para imprimir la cadena LINEA3.
    
    LEA DX, LINEA4 ; Carga la direcci?n de la cadena LINEA4 en el registro DX.
    CALL ESCRIBE   ; Llama al procedimiento ESCRIBE para imprimir la cadena LINEA4.
    
    MOV AX,4C00H   ; Prepara el registro AX con el valor 4C00H, que es el c?digo de interrupci?n para terminar el programa con ?xito.
    INT 21H        ; Llama a la interrupci?n 21H del sistema operativo DOS para finalizar el programa.

    LN ENDP        ; Finaliza el procedimiento LN.

ESCRIBE PROC      ; Define un procedimiento llamado ESCRIBE.
    MOV AH,9       ; Prepara el registro AH con el valor 9, que indica la funci?n de impresi?n de cadenas en la interrupci?n 21H.
    INT 21H        ; Llama a la interrupci?n 21H para imprimir la cadena cuya direcci?n est? en DX.
    RET            ; Retorna del procedimiento ESCRIBE.

ESCRIBE ENDP      ; Finaliza el procedimiento ESCRIBE.

CODIGO ENDS       ; Finaliza el segmento de codigo.

END LN            ; Indica el final del archivo y el punto de entrada del programa, que es el procedimiento LN.
