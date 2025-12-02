;Ejemplo 1: Multiplicacion Simple: 12 * 9 y mostrar el resultado
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado: ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:

;     mov eax, 12
;     mov ebx, 9
;     mul ebx     ; eax = 108

;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf, 13, 10


;     exit
; end start

;Ejemplo 2: Division Simple: 250 / 16 y mostrar el cociente y el resto
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg1 db "Cociente: ", 0
;     msg2 db "Resto: ", 0
;     buf db 32 dup(0)
;     vCoc dd ?
;     vRes dd ?
; .code
; start:

;     mov eax, 250
;     mov edx, 0  ;necesario para dividir
;     mov ebx, 16    

;     div ebx        ; eax = 15, edx = 10

;     mov vCoc, eax
;     mov vRes, edx

;     invoke dwtoa, vCoc, addr buf
;     print addr msg1
;     print addr buf, 13, 10

;     invoke dwtoa, vRes, addr buf
;     print addr msg2
;     print addr buf, 13, 10

;     exit
; end start

;Ejercicio 1: Multiplicacion encadenada.
;Objetivo: Cargar: EAX =7
; Multiplicarlo por 6
; Luego multiplicarlo por 3
; Mostrar el resultado
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado final: ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     ;EAX = 7
;     mov eax, 7

;     ;EAX = EAX * 6 -> 7 * 6 = 42
;     mov ebx,6
;     mul ebx         ; EDX:EAX = EAX * EBX (resultado = EAX)
  
;     ;EAX = EAX * 3 -> 42 * 3 = 126
;     mov ebx,3
;     mul ebx         ; EDX:EAX = EAX * EBX (resultado = EAX)

;     ; Guardamos resultado en memoria
;     mov vRes, eax
    
;     ;Convertimos a texto y lo imprimimos
;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf, 13, 10

;     exit
; end start

;Ejercicio 2: Division con resto
; Objetivo: Dividir 144 / 12
; Mostrar: Cociente y resto

.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc

.data
    msg1 db "Cociente: ", 0
    msg2 db "Resto: ", 0
    buf db 32 dup(0)
    vCoc dd ?
    vRes dd ?
.code
start:

    mov eax, 144
    mov edx, 0      ;necesario para dividir
    mov ebx, 12    

    div ebx         ; eax = 12, edx = 0

    ; Guardamos en memoria
    mov vCoc, eax
    mov vRes, edx

    ;Convertimos a texto e imprimimos
    invoke dwtoa, vCoc, addr buf
    print addr msg1
    print addr buf, 13, 10

    invoke dwtoa, vRes, addr buf
    print addr msg2
    print addr buf, 13, 10

    exit
end start