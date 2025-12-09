; Ejemplo de zero flag (ZF)
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado (ZF): ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     mov eax,5
;     sub eax, 5      ; Resultado = 0 -> ZF = 1

;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf,13, 10       ; imprimir 0
;     exit
; end start

;Ejemplo 2: Carry Flag (CF)
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado (CF): ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     mov eax, 3
;     sub eax, 5      ; resultado = -2 -> CF = 1

;     mov vRes, eax
    
;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf,13, 10


;     exit
; end start

;Ejemplo 3 : Overflow Flag (OF)

; ADD 127 + 1-> overflow de numero con signo

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado (OF): ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     mov al, 127
;     add al, 1     ; pasa a -128 -> OF = 1

;     movsx eax, al ; extiende AL con signo
;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf,13, 10

;     exit
; end start

;Ejemplo 4 : Sign Flag (SF)

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "Resultado (SF): ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     mov eax, 10
;     sub eax, 20     ; -10 -> SF = 1

;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf,13, 10

;     exit
; end start


;Ejercicio 1: Predecir FLAGS con SUB
; Enunciado:
; mov eax, 10
; sub eax, 10
;Resultado final : 0
;Flags esperadas:
; FLAG  Estado
;  ZF      1
;  SF      0
;  CF      0
;  OF      0

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
;     mov eax, 10
;     sub eax, 10     ; resultado = 0 -> ZF = 1

;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msg
;     print addr buf,13, 10

;     exit
; end start

;Ejercicio 2: Overflow con suma
;Enunciado;
; mov al, 127
; add al, 2
; Resultado final: -127
; FLAGS esperadas
; FLAG  Estado
;  ZF      0
;  SF      1
;  CF      0
;  OF      1

.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc

.data
    msg db "Resultado final: ", 0
    buf db 32 dup(0)
    vRes dd ?
.code
start:
    mov al, 127
    add al, 2     ; overflow-> OF = 1

    movsx eax, al   ; extiende AL como entero con signo
    mov vRes, eax

    invoke dwtoa, vRes, addr buf
    print addr msg
    print addr buf,13, 10

    exit
end start