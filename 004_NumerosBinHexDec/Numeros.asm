;Ejemplo 1: Representaciones numericas

; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg1 db "EAX (decimal 25): ", 0
;     msg2 db "EBX (hex 19h): ", 0
;     msg3 db "ECX (bin 11001b): ", 0
;     buf db 32 dup(0)

;     vEAX dd ?
;     vEBX dd ?
;     vECX dd ?
; .code
; start:
;     ; Cargar conceptualmente los registros
;     mov eax, 25
;     mov ebx, 19h
;     mov ecx, 11001b

;     ; Guardamos SNAPSHOT antes de que las macros los pisen
;     mov vEAX, eax
;     mov vEBX, ebx
;     mov vECX, ecx

;     ; Imprimimos cada uno desde memoria

;     invoke dwtoa, vEAX, addr buf
;     print addr msg1
;     print addr buf, 13, 10

;     invoke dwtoa, vEBX, addr buf
;     print addr msg2
;     print addr buf, 13, 10

;     invoke dwtoa, vECX, addr buf
;     print addr msg3
;     print addr buf, 13, 10

;     exit
; end start

;Ejemplo 2: Mostrar el mismo numero en decimal y hexadecimal

; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msgDec db "Decimal: ",0
;     msgHex db "Hexadecimal: ",0
;     buf db 32 dup(0)
;     vNum dd ? 
; .code
; start:
;     mov eax, 255
;     mov vNum, eax

;     ; ---- Mostramos en decimal ----
;     invoke dwtoa, vNum, addr buf
;     print addr msgDec
;     print addr buf, 13 , 10


;     ; ---- Mostramos en hexadecimal ----
;     print addr msgHex  ; esto pisa EAX
;     mov eax, vNum       ;Restauramos el valor
;     print hex$(eax),13 , 10

;     exit
; end start

; Ejercicio 1: Representaciones equivalentes
;Objetivo: Carga en EAX, EBX, ECX el valor 25, expresando respectivamente en decimal, hexadecimal y en binario
;luego mostralos en pantalla para comprobar que los 3 son iguales
; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg db "Valor equivalente: ", 0
;     buf db 32 dup(0)

;     vEAX dd ?
;     vEBX dd ?
;     vECX dd ?
; .code
; start:
;     ;25 en distintas bases
;     mov eax, 25     ;Decimal
;     mov ebx, 19h    ;Hexadecimal = 25
;     mov ecx, 11001b ;Binario = 25

;     ;snapshots antes de imprimir (evitamos pisar registros)
;     mov vEAX, eax
;     mov vEBX, ebx
;     mov vECX, ecx

;     ;EAX
;     invoke dwtoa, vEAX, addr buf
;     print addr msg
;     print addr buf, 13 ,10

;     ;EBX
;     invoke dwtoa, vEBX, addr buf
;     print addr msg
;     print addr buf, 13 ,10

;     ;EAX
;     invoke dwtoa, vECX, addr buf
;     print addr msg
;     print addr buf, 13 ,10


;     exit
; end start
;Ejercicio 2: Conversion visual
;Objetivo: Carga el numero 255 en un registro  y primero mostralo en decimal, luego en hexadecimal y por ultimo escribi manualmente su representacion en binario
.386
.model flat,stdcall
option casemap:none
include C:\masm32\include\masm32rt.inc

.data
    msg1 db "Decimal: ",0
    msg2 db "Hexadecimal: ", 0
    msg3 db "Binario (manual): 11111111b",0
    buf db 32 dup(0)
    vNum dd ?
.code
start:
    mov eax, 255    ; 255 (DECIMAL) = 0x000000FF
    mov vNum, eax   ;Guardamos copia segura

    ; ---- Decimal ----
    invoke dwtoa, vNum, addr buf
    print addr msg1
    print addr buf, 13, 10

    ; ---- Hexadecimal ----
    print addr msg2     ;OJO : Pisa los registros
    mov eax, vNum       ;Restauramos luego del print
    print hex$(eax), 13, 10

    ;---- Binario manual ----
    print addr msg3, 13 ,10
    
    exit
end start