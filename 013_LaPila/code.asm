; ;Ejemplo 1: PUSH/POP basico
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg1 db "POP #1 = " , 0
;     msg2 db "POP #2 = ", 0
;     buf db 32 dup(0)

;     vVal dd ?
; .code
; start:
;     ; push 10, push 20
;     push 10
;     push 20

;     ;pop -> 20
;     pop eax
;     mov vVal, eax
;     invoke dwtoa, vVal, addr buf
;     print addr msg1
;     print addr buf,13,10

;     ;pop -> 10
;     pop eax
;     mov vVal, eax
;     invoke dwtoa, vVal, addr buf
;     print addr msg2
;     print addr buf,13,10

;     exit
; end start

; ;Ejemplo 2: ver cambios de la pila imprimiendo ESP  
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg1 db "ESP Inicial: " , 0
;     msg2 db "ESP despues de PUSH,PUSH: ", 0
;     msg3 db "ESP despues de POP, POP: " , 0
;     buf db 32 dup(0)

;     vTmp dd ?
; .code
; start:
;     ;ESP inicial
;     mov vTmp, ESP
;     invoke dwtoa, vTmp, addr buf
;     print addr msg1
;     print addr buf, 13, 10

;     ; 2 push
;     push 111
;     push 222

;     mov vTmp, ESP
;     invoke dwtoa, vTmp, addr buf
;     print addr msg2
;     print addr buf, 13, 10

;     ; 2 pop
;     pop eax
;     pop eax

;     mov vTmp, ESP
;     invoke dwtoa, vTmp, addr buf
;     print addr msg3
;     print addr buf, 13, 10
;     exit
; end start

;Ejercicio 1: Guardar registros con PUSH/POP
;Objetivo: 
;Poner eax = 50
;Guardar EAX en la pila
;cambiar EAX a 999
;recuperar el valor original desde la pila
;mostrar el valor final de EAX
;resultado esperado: 50
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msg db "EAX final = ", 0
;     msg1 db "EAX Modificado= ",0
;     buf db 32 dup(0)
;     vVal dd ?
; .code
; start:
;    mov eax, 50
;    push eax

;    mov eax,999
;    mov vVal, eax
;    invoke dwtoa, vVal, addr buf
;    print addr msg1
;    print addr buf, 13, 10

;    pop eax

;    mov vVal, eax
;    invoke dwtoa, vVal, addr buf
;    print addr msg
;    print addr buf, 13, 10


;     exit
; end start
;Ejercicio 2: Mini RPN con pila
;Objetivo: Calcular en RPN (Notacion polaca inversa)
;5 3 + 2 *
; esto equivale en notacion normal(infija) a:
; (5 + 3 ) * 2
;Resultado esperado: 16
.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc

.data
   msg db "Resultado RPN = " , 0
   buf db 32 dup(0)
   vRes dd ?
.code
start:
    ; 5 3 +
    push 5
    push 3

    pop ebx         ; b = 3
    pop eax         ; a = 5
    add eax, ebx    ; eax = 8
    push eax        ; push 8

    ; 2
    push 2

    ; *
    pop ebx         ; b = 2
    pop eax         ; a = 8
    mul ebx         ; eax = 16
    push eax        ; push 16

    pop eax
    mov vRes, eax

    invoke dwtoa, vRes, addr buf
    print addr msg
    print addr buf, 13 , 10
    exit
end start