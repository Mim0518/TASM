pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    NP db "Tarea T03$"
    D1 db "Este programa realiza validaciones sobre una cadena ingresada$"
    D2 db "Por el usuario, y posteriormente imprime un mensaje acorde$"
    NM db "Guillermo Moreno Rivera$"
    PN db "Ingrese un numero dentro del rango de DW (0-65535): ", "$"
    CN db "Escribio una cadena nula, no es un numero$"
    CCS db "Escribio algun simbolo no numerico$"
    OOR db "Escribio un numero fuera de rango$"
    AC db "Introdujo un valor decimal sin signo tipo WORD$"
    FIN db "Presione cualquier tecla para probar con otro numero, o ENTER para terminar: ","$"
    Num db 6,?,6 dup(?)
    SL DB 10,13,24H
datos ends
codigo segment para public 'code'
        assume cs:codigo , ds:datos , es:extra , ss:pila
        public p0
p0      proc far
        push ds
        mov ax,0
        push ax
        mov ax, datos
        mov ds, ax
        mov ax, extra
        mov es, ax
        
        ;Limpiar pantalla
        mov ch, 0
        mov cl, 0
        mov dh, 24
        mov dl, 79
        mov ah, 6
        mov al, 0
        mov bh, 7
        int 10h
        ;Posicionar Cursor
        mov DH,0 ;renglon
	mov DL, 35 ;columna
	mov AH,2
	mov BH,0
	int 10H
        ;NomProg
        lea dx, NP
        mov ah, 9
        int 21h
        ;Posicionar Cursor
        mov DH,1 ;renglon
	mov DL, 29 ;columna
	mov AH,2
	mov BH,0
	int 10H
        ;NomMemo
        lea dx, NM
        mov ah, 9
        int 21h
        ;Posicionar Cursor
        mov DH,2 ;renglon
	mov DL, 8 ;columna
	mov AH,2
	mov BH,0
	int 10H
        ;Desc1
        lea dx, D1
        mov ah, 9
        int 21h
        ;Posicionar Cursor
        mov DH,3 ;renglon
	mov DL,10 ;columna
	mov AH,2
	mov BH,0
	int 10H
        ;Desc2
        lea dx, D2
        mov ah, 9
        int 21h
        ;puntero en media pantalla
        mov DH, 4 ;renglon
	mov DL, 0 ;columna
	mov AH,2
	mov BH,0
	int 10H
        jmp X
        Z:
                ;borrar media pantalla
                mov CH,12
		mov CL,0
		mov DH,24
		mov DL,79
		mov AH,6
		mov AL,0
		mov BH,7
		int 10H

                ;puntero en media pantalla
                mov DH,12 ;renglon
	        mov DL,0 ;columna
	        mov AH,2
	        mov BH,0
	        int 10H
        ;Meter cadena
        X:
                ;puntero en media pantalla
                mov DH,12 ;renglon
	        mov DL, 5 ;columna
	        mov AH,2
	        mov BH,0
	        int 10H

                ;SALTO DE LINEA
                lea dx, SL
                mov ah, 9
                int 21h

                lea dx, PN
                mov ah, 9
                int 21h

                lea dx, offset Num
                mov ah, 0AH
                int 21h

                ;Revision si nulo
                mov bl, 13
                cmp Num+2, bl
                je nula
                ;revision de simbolos
                mov bx, dx
                inc bx
                lea bx, Num+1
                xor cx, cx
                mov cl, [bx]
                push cx
                l1:
                        inc bx
                        mov al, [bx]
                        cmp al, 2Fh
                        jl nonum
                        cmp al, 3Ah
                        jg nonum
                        sub [bx], 30h
                loop l1
                pop cx
                dec cx
                ;revisión de rango
                mov si, 0AH
                lea bx, Num+2
                mov al, [bx]
                mov ah, 0
                jcxz fina
                l3:
                        mul si
                        jo outrange
                        inc bx
                        mov dl, [bx]
                        mov dh, 0
                        add ax,dx
                loop l3
                
        fina:
                jc outrange

                lea dx, SL
                mov ah, 9
                int 21h

                lea dx, AC
                mov ah, 9
                int 21h

                lea dx, SL
                mov ah, 9
                int 21h
        finalM:
                lea dx, FIN
                mov ah, 9
                int 21h

                mov ah, 1
                int 21h

                mov ah, 13
                cmp ah, al
                jne Z
                jmp final
        nula:
        ;SALTO DE LINEA
                lea dx, SL
                mov ah, 9
                int 21h

                lea dx, CN
                mov ah, 9
                int 21h

                lea dx, SL
                mov ah, 9
                int 21h
                jmp finalM
        nonum:
                pop cx
                dec cx
                ;SALTO DE LINEA
                lea dx, SL
                mov ah, 9
                int 21h

                lea dx, CCS
                mov ah, 9
                int 21h

                lea dx, SL
                mov ah, 9
                int 21h
                jmp finalM
        outrange:
        ;SALTO DE LINEA
                lea dx, SL
                mov ah, 9
                int 21h

                lea dx, OOR
                mov ah, 9
                int 21h

                lea dx, SL
                mov ah, 9
                int 21h
                jmp finalM
        final:
        ret
p0 endp

codigo ends
        end p0
