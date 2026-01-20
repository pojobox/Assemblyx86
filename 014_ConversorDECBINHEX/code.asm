.386
.model flat,stdcall
option casemap:none
include \masm32\include\masm32rt.inc

.data
    titulo db "=== CONVERSOR (Modulo 2 ) ===",13 ,10, 0
    menuTxt db 13,10, \
                "1) Decimal -> Binario",13,10,\
                "2) Decimal -> Hexadecimal",13,10,\
                "3) Hexadecimal -> Decimal",13,10,\
                "4) Binario -> Decimal",13,10,\
                "5) Salir",13,10,0

    askOpt  db "Opcion (1-5): ",0
    askDec  db "Ingrese DECIMAL: ",0
    askHex  db "Ingrese HEX (sin 0x, ej : 2A O FF): ",0
    askBin  db "Ingrese BINARIO (solo 0 y 1): ",0

    msgDec  db "Decimal: ",0
    msgHex  db "Hex: ", 0
    msgBin  db "Binario: ", 0
    
    msgInvalid db "Entrada invalida.",13,10,0
    msgPress   db 13,10,"ENTER para volver al menu...",13,10,0
    clrf       db 13,10,0

    inOpt   db 64 dup(0)
    inLine  db 128 dup(0)
    buf     db 128 dup(0)
    outBin  db 128 dup(0)
    tmpBits db 64 dup(0)

    vNum    dd ?
    opcion  dd ?

.code
start:
;MAIN MENU
main_menu:
    print addr titulo
    print addr menuTxt
    print addr askOpt

    invoke StdIn, addr inOpt, 63

    lea esi, inOpt
cut_opt:
    mov al, [esi]
    cmp al, 0
    je opt_ok
    cmp al,13
    jne next_opt
    mov byte ptr [esi], 0
    jmp opt_ok
next_opt:
    inc esi
    jmp cut_opt

opt_ok:
    invoke atodw, addr inOpt
    mov opcion, eax

    mov eax, opcion
    cmp eax, 1
    je opt_dec_bin
    cmp eax, 2
    je opt_dec_hex
    cmp eax, 3
    je opt_hex_dec
    cmp eax, 4
    je opt_bin_dec
    cmp eax, 5
    je opt_exit

    print addr msgInvalid
    jmp main_menu

    ;Operacion Decimal -> Binario
opt_dec_bin:
    print addr askDec
    invoke StdIn, addr inLine, 127

    ;Cortamos CR
    lea esi, inLine
cut_dec1:
    mov al, [esi]
    cmp al, 0
    je dec1_ok
    cmp al, 13
    jne dec1_next
    mov byte ptr [esi], 0
    jmp dec1_ok

dec1_next:
    inc esi
    jmp cut_dec1

dec1_ok:
    invoke atodw, addr inLine
    mov vNum, eax

    mov eax, vNum
    cmp eax, 0 
    jne build_bin
    lea edi, outBin
    mov byte ptr [edi], '0'
    mov byte ptr [edi + 1], 0
    jmp show_dec_bin

build_bin:
    lea esi, tmpBits
    xor ecx, ecx    ;cantidad de bits guardados

bin_loop:
    xor edx, edx
    mov ebx, 2
    div ebx
    add dl, '0'
    mov [esi+ecx], dl
    inc ecx
    cmp eax, 0
    jne bin_loop

    ; Invertimos tmpBits -> outBin
    lea edi, outBin
    dec ecx     ;ultimo indice valido
bin_rev:
    mov al, [esi+ecx]
    mov [edi], al
    inc edi
    dec ecx
    jns bin_rev
    mov byte ptr [edi], 0

show_dec_bin:
    ;mostrar DEC
    invoke dwtoa, vNum, addr buf
    print addr msgDec
    print addr buf,13, 10

    ; Mostrar BIN
    print addr msgBin
    invoke StdOut, addr outBin
    print addr clrf

    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

; Decimal a Hex

opt_dec_hex:
    print addr askDec
    invoke StdIn, addr inLine, 127

    ;cortamos CR
    lea esi, inLine
cut_dec2:
    mov al, [esi]
    cmp al, 0
    je dec2_ok
    cmp al, 13
    jne dec2_next
    mov byte ptr [esi], 0
    jmp dec2_ok
dec2_next:
    inc esi
    jmp cut_dec2

dec2_ok:
    invoke atodw, addr inLine
    mov vNum, eax

    ;DEC
    invoke dwtoa, vNum, addr buf
    print addr msgDec
    print addr buf, 13, 10

    ;HEX
    print addr msgHex
    mov eax, vNum
    print hex$(eax), 13, 10

    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

;Hex -> Decimal
opt_hex_dec:
    print addr askHex
    invoke StdIn, addr inLine, 127

    ;Cortamos CR
    lea esi, inLine
cut_hex:
    mov al, [esi]
    cmp al,0
    je hex_parse_start
    cmp al, 13
    jne hex_next
    mov byte ptr [esi], 0
    jmp hex_parse_start
hex_next:
    inc esi
    jmp cut_hex

hex_parse_start:
    lea esi, inLine
    xor eax, eax    ;acumulador
hex_parse:
    mov bl, [esi]
    cmp bl, 0
    je hex_done

    ; ignoramos espacios
    cmp bl, ' '
    je hex_skip
    cmp bl, 9
    je hex_skip

   ; eax *= 16
   shl eax, 4

   ; BL -> nibble (0...15) en ECX
   movzx ecx, bl

   ; 0-9
   cmp cl, '0'
   jb hex_invalid
   cmp cl, '9'
   jbe hex_digit09

   ; A-F
   cmp cl, 'A'
   jb hex_check_af
   cmp cl, 'F'
   jbe hex_digitAF

hex_check_af:
    ; a-f
    cmp cl, 'a'
    jb hex_invalid
    cmp cl, 'f'
    jbe hex_digitaf
    jmp hex_invalid

hex_digit09:
    sub ecx, '0'
    add eax, ecx
    inc esi
    jmp hex_parse

hex_digitAF:
    sub ecx, 'A'
    add ecx, 10
    add eax, ecx
    inc esi
    jmp hex_parse

hex_digitaf:
    sub ecx, 'a'
    add ecx, 10
    add eax, ecx
    inc esi
    jmp hex_parse

hex_skip:
    inc esi
    jmp hex_parse

hex_invalid:
    print addr msgInvalid
    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

hex_done:
    mov vNum, eax

    ;Mostramos HEX 
    print addr msgHex
    mov eax, vNum
    print hex$(eax),13, 10

    ;mostramos DEC
    invoke dwtoa, vNum, addr buf
    print addr msgDec
    print addr buf,13, 10

    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

; Binario a decimal (parse manual)
opt_bin_dec:
    print addr askBin
    invoke StdIn, addr inLine, 127

    ;Cortamos CR
    lea esi, inLine
cut_bin:
    mov al, [esi]
    cmp al, 0
    je bin_parse_start
    cmp al, 13
    jne bin_next
    mov byte ptr [esi], 0
    jmp bin_parse_start
bin_next:
    inc esi
    jmp cut_bin

bin_parse_start:
    lea esi, inLine
    xor eax, eax    ; acumulador

bin_parse:
    mov bl, [esi]
    cmp bl, 0
    je bin_done

    ; ignoramos espacios
    cmp bl, ' '
    je bin_skip
    cmp bl, 9
    je bin_skip

    cmp bl, '0'
    je bin_bit0
    cmp bl, '1'
    je bin_bit1
    jmp bin_invalid

bin_bit0:
    shl eax, 1
    inc esi
    jmp bin_parse

bin_bit1:
    shl eax, 1
    add eax, 1
    inc esi
    jmp bin_parse

bin_skip:
    inc esi
    jmp bin_parse

bin_invalid:
    print addr msgInvalid
    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

bin_done:
    mov vNum, eax

    ;Mostramos DEC  
    invoke dwtoa, vNum, addr buf
    print addr msgDec
    print addr buf,13, 10

    print addr msgPress
    invoke StdIn, addr inOpt, 63
    jmp main_menu

opt_exit:
    exit

end start