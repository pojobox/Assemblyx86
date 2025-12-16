;Calculadora - SUMA (A + B) 
; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgTitle db " === SUMA (A + B) === ",13, 10, 0
;     msgA     db "Ingrese A: ", 0
;     msgB     db "Ingrese B: ", 0
;     msgRes   db "Resultado (decimal): ", 0
;     msgHex   db "Resultado (Hex): ", 0

;     inA db 64 dup(0)
;     inB db 64 dup(0)
;     buf db 64 dup(0)

;     A dd ?
;     B dd ?
;     vRes dd ?

; .code
; start:
;     print addr msgTitle

;     print addr msgA
;     invoke StdIn, addr inA, 63
;     invoke atodw, addr inA
;     mov A, eax

;     print addr msgB
;     invoke StdIn, addr inB, 63
;     invoke atodw, addr inB
;     mov B, eax

;     mov eax, A
;     add eax, B
;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     print addr msgHex
;     mov eax,vRes
;     print hex$(eax), 13, 10

;     exit
; end start


; Resta (A - B)

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgTitle db " === RESTA (A - B) === ",13, 10, 0
;     msgA     db "Ingrese A: ", 0
;     msgB     db "Ingrese B: ", 0
;     msgRes   db "Resultado (decimal): ", 0
;     msgHex   db "Resultado (Hex): ", 0

;     inA db 64 dup(0)
;     inB db 64 dup(0)
;     buf db 64 dup(0)

;     A dd ?
;     B dd ?
;     vRes dd ?

; .code
; start:
;     print addr msgTitle

;     print addr msgA
;     invoke StdIn, addr inA, 63
;     invoke atodw, addr inA
;     mov A, eax

;     print addr msgB
;     invoke StdIn, addr inB, 63
;     invoke atodw, addr inB
;     mov B, eax

;     mov eax, A
;     sub eax, B
;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     print addr msgHex
;     mov eax,vRes
;     print hex$(eax), 13, 10

;     exit
; end start

; Multiplicacion: (A * B)

; .386
; .model flat, stdcall
; option casemap:none
; include \masm32\include\masm32rt.inc


; .data
;     msgTitle db " === MULTIPLICACION (A * B) === ",13, 10, 0
;     msgA     db "Ingrese A: ", 0
;     msgB     db "Ingrese B: ", 0
;     msgRes   db "Resultado (decimal): ", 0
;     msgHex   db "Resultado (Hex): ", 0

;     inA db 64 dup(0)
;     inB db 64 dup(0)
;     buf db 64 dup(0)

;     A dd ?
;     B dd ?
;     vRes dd ?

; .code
; start:
;     print addr msgTitle

;     print addr msgA
;     invoke StdIn, addr inA, 63
;     invoke atodw, addr inA
;     mov A, eax

;     print addr msgB
;     invoke StdIn, addr inB, 63
;     invoke atodw, addr inB
;     mov B, eax

;     mov eax, A
;     mov ebx, B
;     mul ebx
;     mov vRes, eax

;     invoke dwtoa, vRes, addr buf
;     print addr msgRes
;     print addr buf, 13, 10

;     print addr msgHex
;     mov eax,vRes
;     print hex$(eax), 13, 10

;     exit
; end start

;DIVISION (A / B)

.386
.model flat, stdcall
option casemap:none
include \masm32\include\masm32rt.inc


.data
    msgTitle db " === DIVISION (A / B) === ",13, 10, 0
    msgA     db "Ingrese A: ", 0
    msgB     db "Ingrese B: ", 0
   
    msgCocD  db "Cociente (decimal): ", 0
    msgCocH  db "Cociente (hex): ", 0
    msgRemD  db "Resto (decimal): ",0
    msgRemH  db "Resto (hex): ", 0 

    inA db 64 dup(0)
    inB db 64 dup(0)
    buf db 64 dup(0)

    A dd ?
    B dd ?
    vCoc dd ?
    vRem dd ?

.code
start:
    print addr msgTitle

    print addr msgA
    invoke StdIn, addr inA, 63
    invoke atodw, addr inA
    mov A, eax

    print addr msgB
    invoke StdIn, addr inB, 63
    invoke atodw, addr inB
    mov B, eax

    mov eax, A
    mov edx, 0
    mov ebx, B
    div ebx
    
    mov vCoc, eax
    mov vRem, edx

    invoke dwtoa, vCoc, addr buf
    print addr msgCocD
    print addr buf, 13, 10
    
    print addr msgCocH
    mov eax,vCoc
    print hex$(eax), 13, 10

    invoke dwtoa, vRem, addr buf
    print addr msgRemD
    print addr buf, 13, 10
    
    print addr msgRemH
    mov eax,vRem
    print hex$(eax), 13, 10

    exit
end start