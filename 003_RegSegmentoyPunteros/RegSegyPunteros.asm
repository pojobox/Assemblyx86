;Ejemplo 1: Direcciones de variables (offset)

; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     var1 dd 100
;     var2 dd 200
;     msgV1 db "Direccion de var1: ", 0
;     msgV2 db "Direccion de var2: ", 0
;     msgDS db "DS en modelo flat: memoria lineal unica", 0
;     buf   db 32 dup(0)

; .code
; start:   
;     ; ----var1----
;     mov eax, offset var1            ; 1) guardo la direccion (lineal) en EAX
;     invoke dwtoa, eax, addr buf     ; 2) paso EAX a ASCII dentro de buf
;     print addr msgV1                ; 3) imprimo la etiqueta
;     print addr buf, 13, 10          ; 4) imprimo el valor

;      ; ----var2----
;     mov eax, offset var2            ; 1) guardo la direccion (lineal) en EAX
;     invoke dwtoa, eax, addr buf     ; 2) paso EAX a ASCII dentro de buf
;     print addr msgV2                ; 3) imprimo la etiqueta
;     print addr buf, 13, 10          ; 4) imprimo el valor

;     print addr msgDS, 13, 10
;     exit
; end start

; Ejemplo 2: Pila con ESP/ EBP (push/pop de valores)

; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     valA dd 10
;     valB dd 20
;     valC dd 30
;     msgHdr db "Simulando pila (LIFO): ", 0 ; (LIFO) = Last in First out
;     msgPop db "POP -> EAX = " , 0
;     buf db 32 dup(0)

; .code
; start:
;     print addr msgHdr, 13,10

;     ;Empujo los valores (no las direcciones)
;     push dword ptr valA         ; equivale: mov eax, valA  / push eax
;     push dword ptr valB 
;     push dword ptr valC         ; C el primero en salir (LIFO)

;     ; 1er POP -> valC
;     pop eax
;     invoke dwtoa, eax, addr buf
;     print addr msgPop
;     print addr buf, 13, 10

;      ; 1er POP -> valB
;     pop eax
;     invoke dwtoa, eax, addr buf
;     print addr msgPop
;     print addr buf, 13, 10

;     ; 1er POP -> valA
;     pop eax
;     invoke dwtoa, eax, addr buf
;     print addr msgPop
;     print addr buf, 13, 10

;     ;ESP volvio a su posicion original
;     exit
; end start

;Ejercicio 1: Imprimir direcciones
; Objetivo: declara tres valores (x, y, z) en la seccion .data.
;Mostra sus direcciones (offset) y un texto que diga "modo flat activo - segmentos unificados".

; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     x dd 1
;     y dd 2
;     z dd 3
;     msgX db "Direccion de X: " , 0
;     msgY db "Direccion de Y: " , 0
;     msgZ db "Direccion de Z: " , 0
;     msgFlat db "Modo flat activo, segmentos unificados", 0
;     buf db 32 dup(0)

; .code
; start:
;     mov eax, offset x
;     invoke dwtoa, eax, addr buf
;     print addr msgX
;     print addr buf, 13,10

;     mov eax, offset y
;     invoke dwtoa, eax, addr buf
;     print addr msgY
;     print addr buf, 13,10

;     mov eax, offset z
;     invoke dwtoa, eax, addr buf
;     print addr msgZ
;     print addr buf, 13,10

;     print addr msgFlat, 13 ,10
;     exit
; end start



;Ejercicio 2: Pila de numeros
;Objetivo: Apila tres numeros (10,20,30), luego desapilalos y mostralos en orden.
;Explica como cambia ESP tras cada operacion

.386
.model flat, stdcall
option casemap:none
include C:\masm32\include\masm32rt.inc

.data
    msgTitle db "PILA , Push y pop (trazando ESP)",0
    mBef db "ESP antes: " , 0
    mAft db "ESP despues: ",0
    mPush10 db "push 10", 0
    mPush20 db "push 20",0
    mPush30 db "push 30",0
    mPop db "pop -> EAX = ",0
    mDash db "------------------------------------", 0

    ;snapshots de ESP
    esp0 dd ?
    esp1 dd ?
    esp2 dd ?
    esp3 dd ?
    esp4 dd ?
    esp5 dd ?
    esp6 dd ?

    buf db 32 dup(0)
    vTemp dd ?
.code
start:
    print addr msgTitle, 13, 10
    print addr mDash, 13, 10

    ; ====Estado inicial====
    mov eax, esp
    mov esp0, eax
    print addr mBef
    mov eax, esp0
    print hex$(eax), 13, 10

    ; ==== Push 10 ====
    print addr mPush10, 13 , 10
    push 10
    mov eax, esp
    mov esp1, eax
    print addr mAft
    mov eax, esp1
    print hex$(eax), 13, 10
    print addr mDash, 13,10

    ; ==== Push 20 ====
    print addr mPush20, 13 , 10
    push 20
    mov eax, esp
    mov esp2, eax
    print addr mAft
    mov eax, esp2
    print hex$(eax), 13, 10
    print addr mDash, 13,10

    ; ==== Push 30 ====
    print addr mPush30, 13 , 10
    push 30
    mov eax, esp
    mov esp3, eax
    print addr mAft
    mov eax, esp3
    print hex$(eax), 13, 10
    print addr mDash, 13,10

    ; ==== Pop 30 ====
    pop eax         ; EAX = 30
    mov vTemp, eax  ;Guardamos ANTES  de imprimir 
    invoke dwtoa, vTemp, addr buf
    print addr mPop
    print addr buf, 13, 10
    
    mov eax, esp
    mov esp4, eax
    print addr mAft
    mov eax, esp4
    print hex$(eax),13, 10
    print addr mDash,13 ,10

    ; ==== Pop 20 ====
    pop eax         ; EAX = 20
    mov vTemp, eax  ;Guardamos ANTES  de imprimir 
    invoke dwtoa, vTemp, addr buf
    print addr mPop
    print addr buf, 13, 10
    
    mov eax, esp
    mov esp5, eax
    print addr mAft
    mov eax, esp5
    print hex$(eax),13, 10
    print addr mDash,13 ,10

    ; ==== Pop 10 ====
    pop eax         ; EAX = 10
    mov vTemp, eax  ;Guardamos ANTES  de imprimir 
    invoke dwtoa, vTemp, addr buf
    print addr mPop
    print addr buf, 13, 10
    
    mov eax, esp
    mov esp6, eax
    print addr mAft
    mov eax, esp6
    print hex$(eax),13, 10
    print addr mDash,13 ,10

    exit
end start