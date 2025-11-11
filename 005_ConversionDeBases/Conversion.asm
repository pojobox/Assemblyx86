; Ejemplo 1: Decimal -> Binario y Hexadecimal

; Convertimos 45 (decimal) a sus equivalentes en binario y hexadecimal
; Division          Cociente            Resto
;  45 % 2             22                  1
;  22 % 2             11                  0
;  11 % 2             5                   1
;  5  % 2             2                   1
;  2  % 2             1                   0
;  1  % 2             0                   1
; Resultado en Binario : 101101b
;
; Division          Cociente            Resto
;  45 % 16              2                13(D)
;   2 % 16              0                  2
; Resultado en Hexadecimal: 2Dh
;
; Ejemplo 2: Binario -> Decimal y Hexadecimal
; Convertimos 110111b a sus equivalentes en decimal y hexadecimal
;
; Sumamos las potencias de 2 correspondientes a los 1 bits:
;
; 1x32 1x16 0x8 1x4 1x2 1x1 = 55 
; Resultado en decimal es: 55d
;
; Binario a hexadecimal
; Agrupamos en bloques de 4 bits desde la derecha.
;
; 00 110111 -> 0011 0111
;
; 0011 = 3
; 0111 = 7
; Resultado en hexadecimal es: 37h
;
;
; Ejercicio 1: Decimal -> Binario y hexadecimal
; Objetivo: Converti el 73 (decimal) a sus equivalentes en binario y hexadecimal. Mostra todas las divisiones y restos
;
; Paso 1: Decimal -> Binario
;
; Division          Cociente            Resto
;  73 % 2              36                 1
;  36 % 2              18                 0
;  18 % 2               9                 0
;   9 % 2               4                 1
;   4 % 2               2                 0
;   2 % 2               1                 0
;   1 % 2               0                 1
;   
; Resultado en binario : 1001001b
;
;
; Paso 2: Decimal -> hexadecimal
; 
; Division          Cociente            Resto
;  73 % 16              4                 9
;   4 % 16              0                 4
;
; Resultado en hexadecimal : 49h
;
;
;
; Ejercicio 2: Hexadecimal -> Decimal y binario
; Objetivo: Converti el 4Bh (hexadecimal) en decimal y binario
;
; Paso 1: Hexadecimal -> Decimal
;
; Usamos las posiciones hexadecimales:
; 
; 4bH = (4X161) + (Bx160)
;
; (4 x 16) + (11 x 1) = 64 + 11 = 75
;
; Resultado en decimal: 75d 
;
; Hexadecimal -> Binario
;
;
; Cada digito hexadecimal equivale a 4 bits
;
; Digito          Equivalente binario
;
;   4                   0100
;   B (11)              1011
; Resultado en binario: 01001011b

