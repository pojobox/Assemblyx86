; Ejemplo 1: Mostrar contenido de los registros
;Imprimir registros sin que se corrompan (usando dwtoa)

; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     t1  db "EAX = ",0
;     t2  db "EBX = ",0
;     t3  db "ECX = ",0
;     t4  db "EDX = ",0
;     buf db 32 dup(0)
;     vEAX dd ?
;     vEBX dd ?
;     vECX dd ?
;     vEDX dd ?

; .code
; start:
;     ; Cargar registros
;     mov eax, 2025
;     mov ebx, 64
;     mov ecx, 1234
;     mov edx, 777

;     ; Guardar sus valores en memoria ANTES de imprimir
;     mov vEAX, eax
;     mov vEBX, ebx
;     mov vECX, ecx
;     mov vEDX, edx

;     ; ---- EAX ----
;     invoke dwtoa, vEAX, addr buf   ; convierte DWORD->ASCII en buf
;     print  addr t1
;     print  addr buf, 13, 10

;     ; ---- EBX ----
;     invoke dwtoa, vEBX, addr buf
;     print  addr t2
;     print  addr buf, 13, 10

;     ; ---- ECX ----
;     invoke dwtoa, vECX, addr buf
;     print  addr t3
;     print  addr buf, 13, 10

;     ; ---- EDX ----
;     invoke dwtoa, vEDX, addr buf
;     print  addr t4
;     print  addr buf, 13, 10

;     exit
; end start


;Ejemplo 2: Subregistros (AH, AL)
; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     msg0 db "Inicial EAX = ", 0
;     msg1 db "Tras AL= FFh -> EAX = ", 0
;     msg2 db "Tras AH= AAh -> EAX = ", 0
;     msg3 db "Tras AX= BEEFh -> EAX = ", 0
;     buf db 32 dup(0)
;     tmp dd ?

; .code
; start:
;     mov eax, 12345678h ; 12 34 56 78

;     ;------------Mostrar inicial-----------
;     mov tmp, eax
;     print addr msg0
;     ; hex$ usa EAX como fuente; cargamos desde tmp para no depender del estado
;     mov eax, tmp
;     print hex$(eax), 13, 10

;      ;------------Cambiar AL-----------
;     mov eax, tmp
;     mov al, 0FFh
;     mov tmp, eax
;     print addr msg1
;     mov eax, tmp
;     print hex$(eax), 13, 10

;      ;------------Cambiar AH-----------
;     mov eax, tmp
;     mov ah, 0AAh
;     mov tmp, eax
;     print addr msg2
;     mov eax, tmp
;     print hex$(eax), 13, 10

;     ;------------Cambiar AX completo-----------
;     mov eax, tmp
;     mov ax, 0BEEFh
;     mov tmp, eax
;     print addr msg3
;     mov eax, tmp
;     print hex$(eax), 13, 10

;     exit
; end start

;Ejercicio 1: Mostrar los registros
;Objetivo: Cargar valores distintos en EAX, EBX, ECX,EDX y mostrarlos por pantalla en decimal
;Al terminar agregar una linea que diga "Fin del programa"
; .386
; .model flat, stdcall
; option casemap:none
; include C:\masm32\include\masm32rt.inc

; .data
;     t1 db "EAX = ", 0
;     t2 db "EBX = ", 0
;     t3 db "ECX = ", 0
;     t4 db "EDX = ", 0
;     fin db "Fin del programa", 0
;     buf db 32 dup(0)
;     vEAX dd ?
;     vEBX dd ?
;     vECX dd ?
;     vEDX dd ?

; .code
; start:
;     ;Cargar
;     mov eax, 50
;     mov ebx, 25
;     mov ecx, 100
;     mov edx, 75

;     ;Guardar antes de imprimir (las macros pisan EAX/ECX/EDX)
;     mov vEAX, eax
;     mov vEBX, ebx
;     mov vECX, ecx
;     mov vEDX, edx

;     ; Imprimir cada etiqueta/valor por separado (dwtoa -> buf)
;     invoke dwtoa, vEAX, addr buf
;     print addr t1
;     print addr buf, 13, 10

;     invoke dwtoa, vEBX, addr buf
;     print addr t2
;     print addr buf, 13, 10

;     invoke dwtoa, vECX, addr buf
;     print addr t3
;     print addr buf, 13, 10

;     invoke dwtoa, vEDX, addr buf
;     print addr t4
;     print addr buf, 13, 10

;     print addr fin, 13 ,10

;     exit
; end start

;Ejercicio 2: Subregistros (AL,AH) 
;Objetivo: Cargar en EAX el valor 12345678h
;Luego cambia solo AL y solo AH, mostrando despues de cada cambio el valor completo de EAX en hexadecimal

.386
.model flat, stdcall
option casemap:none
include C:\masm32\include\masm32rt.inc

.data
    m0 db "Inicio EAX = ", 0
    m1 db "Despues de AL= FFh -> EAX = ", 0
    m2 db "Despues de AH= AAh -> EAX = ", 0
    tmp dd ?

.code
start:
    ;EAX de arranque
    mov eax, 12345678h

    ;Mostrar inicio
    mov tmp, eax
    print addr m0
    mov eax, tmp
    print hex$(eax), 13, 10

    ;Cambiar AL (byte bajo de AX)
    mov eax, tmp
    mov al, 0FFh ; 12345678h -> 123456FFh
    mov tmp, eax
    print addr m1
    mov eax, tmp
    print hex$(eax), 13, 10

    ;Cambiar AH(byte alto de AX)
    mov eax, tmp
    mov ah, 0AAh ; 123456FFh -> 1234AAFFh
    mov tmp, eax
    print addr m2
    mov eax, tmp
    print hex$(eax), 13, 10

    exit
end start