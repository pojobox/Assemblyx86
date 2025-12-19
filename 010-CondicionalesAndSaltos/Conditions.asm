;Ejemplo 1 - IF / ELSE
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc

; .data
;     msgA db "A = ", 0
;     msgB db "B = ", 0
;     msgGE db "IF: A >= B" , 13, 10, 0
;     msgLT db "ELSE: A < B",13, 10, 0
;     buf db 32 dup(0)

;     A dd 25
;     B dd 15

; .code
; start:
;     ; Mostrar A
;     invoke dwtoa, A, addr buf
;     print addr msgA
;     print addr buf, 13, 10

;     ; Mostrar B
;     invoke dwtoa, B, addr buf
;     print addr msgB
;     print addr buf, 13, 10

;     ; IF (A >= B)
;     mov eax, A
;     cmp eax, B
;     jl else_part        ; Si A < B -> ELSE

;     ; THEN
;     print addr msgGE
;     jmp end_if

; else_part:
;     print addr msgLT

; end_if:
;     exit
; end start


;Ejemplo 2  - WHILE
; .386
; .model flat,stdcall
; option casemap:none
; include \masm32\include/masm32rt.inc

; .data
;     msgHdr db "WHILE i < 5", 13, 10, 0
;     msgI db "i = ", 0
;     buf db 32 dup(0)

;     i dd 0
;     vI dd ?

; .code
; start:
;     print addr msgHdr

; while_start:
;     mov eax, i
;     cmp eax, 5
;     jge while_end   ; si i >= 5 -> termina

;     ; imprimirmos i
;     mov vI, eax
;     invoke dwtoa, vI, addr buf
;     print addr msgI
;     print addr buf, 13, 10

;     ; inc i = i++
;     mov eax, i
;     inc eax
;     mov i, eax

;     jmp while_start

; while_end:
;     exit
; end start

; Ejemplo 3 - FOR

; .386
; .model flat,stdcall
; option casemap:none
; include \masm32\include/masm32rt.inc

; .data
;     msgRes db "Suma 1..5 = ", 0
;     buf db 32 dup(0)

;     sum dd 0
;     i dd 1
;     vSum dd ? 
; .code
; start:
; for_start:
;     mov eax, i
;     cmp eax, 5
;     jg for_end

;     ; sum += i
;     mov eax, sum
;     add eax, i
;     mov sum, eax

;     ; i++
;     mov eax, i
;     inc eax
;     mov i, eax

;     jmp for_start

; for_end:
;     mov eax, sum
;     mov vSum, eax

;     invoke dwtoa, vSum, addr buf
;     print addr msgRes
;     print addr buf,13 ,10

;     exit 
; end start

;Ejercicio 1: IF/ ELSE con igualdad
;Enunciado: Si X == Y  imprimir "IGUALES", si no "DISTINTOS".
; .386
; .model flat,stdcall
; option casemap:none
; include \masm32\include/masm32rt.inc

; .data
;     msgEq db "IGUALES",13,10, 0
;     msgNe db "DISTINTOS",13,10, 0
    
;     X dd 8
;     Y dd 15
   
; .code
; start:
;     mov eax, X
;     cmp eax, Y
;     jne not_equal

;     print addr msgEq
;     jmp end_if

; not_equal:
;     print addr msgNe

; end_if:
;     exit 
; end start
;Ejercicio 2: WHILE decreciente
;Enunciado: Arrancar en 5 y contar hasta 1.

.386
.model flat,stdcall
option casemap:none
include \masm32\include/masm32rt.inc

.data
    msg db "Valor = ", 0
    buf db 32 dup(0)

    i dd 5
    vI dd ?

.code
start:
loop_start:
    mov eax, i
    cmp eax, 0
    jle loop_end

    mov vI, eax
    invoke dwtoa, vI, addr buf
    print addr msg
    print addr buf,13, 10

    dec i
    jmp loop_start

loop_end:
    exit 
end start