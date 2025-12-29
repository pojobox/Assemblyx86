
;Ejemplo 1: Suma con parametros por registros
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgRes db "Resultado (A + B): ", 0
;     buf db 32 dup(0)

;     A dd 20
;     B dd 30
;     vRes dd ?
; .code
; start:
;     mov eax, A
;     mov ebx, B

;     call sumar

;     mov vRes, eax
;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     exit

; ; -------------Subrutina----------------
; sumar:
;     push ebx
;     add eax, ebx
;     pop ebx
;     ret

; end start

;Ejemplo 2: Subrutina RESTA (Parametros por pila)

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgRes db "Resultado (A - B): ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     push 10
;     push 40
;     call restar_pila

;     mov vRes, eax
;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     exit

; ; -------------Subrutina----------------
; restar_pila:
;     push ebp
;     mov ebp, esp

;     mov eax, [ebp + 8] ; A
;     sub eax, [ebp + 12] ; A - B

;     pop ebp
;     ret 8       ;Limpia parametros

; end start


;Ejercicio 1: Subrutina MULTIPLICAR (por registros)
;Objetivo: Multiplicar 6 x 7 usando una subrutina con parametros por registros.
;Resultado esperado: 42

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgRes db "Resultado: ", 0
;     buf db 32 dup(0)
;     vRes dd ?
; .code
; start:
;     mov eax, 6
;     mov ebx, 7

;     call multiplicar

;     mov vRes, eax
;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     exit

; ; -------------Subrutina----------------
; multiplicar:
;     push ebx
;     mul ebx
;     pop ebx
;     ret

; end start



;Ejercicio 2: Subrutina SUMA (por pila)
;Objetivo: Sumar 25 + 15 usando parmetros por pila.
;Resultado esperado: 40

.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc


.data
    msgRes db "Resultado: ", 0
    buf db 32 dup(0)
    vRes dd ?
.code
start:
   push 15
   push 25
   call sumar_pila

    mov vRes, eax
    invoke dwtoa, vRes, addr buf
    print addr msgRes
    print addr buf, 13, 10

    exit

; -------------Subrutina----------------
sumar_pila:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    add eax, [ebp + 12]

    pop ebp
    ret 8
    
end start
