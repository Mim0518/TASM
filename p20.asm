pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    N1 DB 51, ?, 51 dup (?)
    N2 DB 51, ?, 51 dup (?)
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
        
        ;Leer cadena
        lea dx, N1
        mov ah, 0AH
        int 21h
        lea dx, SL
        mov ah, 9
        int 21h     
        ;Leer cadena
        lea dx, N1
        mov ah, 0AH
        int 21h
        lea dx, SL
        mov ah, 9
        int 21h
        ;convertir a numeros n1
        lea bx, N1 + 1
        mov ch, 0
        mov cl, [bx]
        r1:
                inc bx
                sub [bx], 30H
        loop r1
        push bx
        ;convertir a numeros n2
        lea bx, N2 + 1
        mov ch, 0
        mov cl, [bx]
        r2:
                inc bx
                sub [bx], 30H
        loop r2
        push bx

        pop si
        pop bx
        mov cx, 50
        clc
        sv:
        mov al, [bx]
        adc al, [si]
        aaa
        push ax
        dec bx
        dec si
        loop sv
        mov cx, 50
        mov ah, 2
        ci:
        pop dx
        mov dh, 0
        add dl, 30h
        int 21h
        loop ci
        ret
p0 endp

codigo ends
        end p0
