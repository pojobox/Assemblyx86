;Ejemplo 1: Suma con ADD
; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg db "Resultado de la suma: ",0
;     buf db 32 dup(0)
;     v dd ?

; .code
; start:
;     mov eax, 15
;     add eax, 27 ; eax = 15 +27 = 42
;     mov v, eax

;     invoke dwtoa, v , addr buf
;     print addr msg
;     print addr buf, 13, 10

;     exit
; end start

;Ejemplo 2: Restar , Incrementar y decrementar
; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg db "Resultado final: ",0
;     buf db 32 dup(0)
;     v dd ?

; .code
; start:
;     mov eax, 50
;     sub eax, 7  ; 50 - 7 = 43
;     inc eax     ; 44
;     dec eax     ;43
;     mov v,eax

;     invoke dwtoa, v, addr buf
;     print addr msg
;     print addr buf, 13, 10

;     exit
; end start

; Ejercicio 1: Suma y resta basica.
; Objetivo: Cargar en EAX el valor 100
; Restarle 25
; Sumarle 7
; Restarle 50.
; Mostrar el resultado final por pantalla

; .386
; .model flat,stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg db "Resultado final: ",0
;     buf db 32 dup(0)
;     v dd ?

; .code
; start:
;     mov eax, 100    ; Cargamos eax = 100
;     sub eax, 25     ; 100 - 25 = 75
;     add eax, 7      ; 75 + 7 = 82
;     sub eax, 50     ; 82- 50 = 32

;     mov v, eax      ; snapshot en memoria (para no modificar registros con dwtoa)
;     invoke dwtoa, v, addr buf
;     print addr msg
;     print addr buf,13 ,10


;     exit
; end start

; Ejercicio 2: INC y DEC encadenados
; Objetivo: Cargar 10 en EBX.
; Aplicar esta secuencia: 
; INC
; INC
; DEC
; INC
; DEC
; DEC
; Mostrar el resultado final.

.386
.model flat,stdcall
option casemap:none
include C:\masm32\include\masm32rt.inc

.data
    msg db "EBX Final: ",0
    buf db 32 dup(0)
    vEBX dd ?

.code
start:
    mov ebx, 10     ; Cargamos 10

    inc ebx     ; 11
    inc ebx     ; 12
    dec ebx     ; 11
    inc ebx     ; 12
    dec ebx     ; 11
    dec ebx     ; 10

    mov vEBX, ebx ; snapshot
    invoke dwtoa, vEBX, addr buf
    print addr msg
    print addr buf,13, 10
     
    exit
end start