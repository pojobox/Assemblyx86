;Ejemplo 1: Copiar una cadena(MOVSB)
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     src db "Hola Assembly",0
;     dst db 32 dup(0)
; .code
; start:
;     cld     ; direccion hacia adelante
;     lea esi, src
;     lea edi, dst

; copy_loop:
;     movsb
;     cmp byte ptr [esi-1], 0
;     jne copy_loop

;     print addr dst, 13, 10
;     exit
; end start

;Ejemplo 2: Contar caracteres con LODSB

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Cantidad de caracteres: ",0
;     txt db "Assembly x86", 0
;     buf db 32 dup(0)
;     count dd 0
;     vCnt dd ?
; .code
; start:
;     cld     ; direccion hacia adelante
;     lea esi, txt
;     mov ecx,0
    

; count_loop:
;     lodsb
;     cmp al, 0
;     je end_count
;     inc ecx
;     jmp count_loop

; end_count:
;     mov count , ecx
;     mov vCnt, ecx

;     invoke dwtoa, vCnt, addr buf
;     print addr msg
;     print addr buf,13 , 10
;     exit
; end start

;Ejercicio 1: Buscar un caracter (SCASB)
;Objetivo: Buscar si el caracter 'a' existe dentro de una cadena.

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     txt db "pepito", 0
;     msgOK db "Caracter encontrado!", 13, 10, 0
;     msgNO db "Caracter NO encontrado.", 13, 10, 0
; .code
; start:
;     cld     ; direccion hacia adelante
;     lea edi, txt
;     mov al, 'a'
    
; search_loop:
;     scasb
;     je found
;     cmp byte ptr [edi-1], 0
;     jne search_loop

;     print addr msgNO
;     jmp end_prog

; found:
;     print addr msgOK

; end_prog:
;     exit
; end start
;Ejercicio 2: Concatenar cadenas (LODSB + STOSB)
;Objetivo: Concatenar dos cadenas en una tercera.
.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc

.data
    a db "Hola ", 0
    b db "Assembly",0
    outBuf db 64 dup(0)
.code
start:
    cld     ; direccion hacia adelante
    
    ;Copiar A -> OutBuf
    lea esi, a
    lea edi, outBuf

copy_a:
    lodsb       ; AL= [ESI], ESI++
    stosb       ; [EDI] = AL, EDI ++
    test al, al ; AL == 0?
    jne copy_a
    dec edi     ; retrocede 1 para pisar el 0 final de A

    ;Copiamos B -> continua en outBuf
    lea esi, b

copy_b:
    lodsb
    stosb
    test al, al
    jne copy_b

    ;Imprimimos el resultado (string armado en memoria)
    invoke StdOut, addr outBuf
    print chr$(13,10)

    
    exit
end start