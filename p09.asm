pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    cad01 DB "murcielago"
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

        mov si, 0
        mov cx, 10
        x:
        lea bx, cad01
        mov ah, 2
        mov dl, [bx+si]
        int 21h

        lea dx, sl
        mov ah, 9
        int 21h

        inc si
        loop x

        lea dx, sl
        mov ah, 9
        int 21h

        mov si, 9
        mov cx, 10
        y:
        lea bx, cad01
        mov ah, 2
        mov dl, [bx+si]
        int 21h

        lea dx, sl
        mov ah, 9
        int 21h

        dec si
        loop y

        lea dx, sl
        mov ah, 9
        int 21h

        mov si, 0
        mov cx, 10
        z:
        lea bx, cad01
        mov ah, 2
        mov dl, [bx+si]
        int 21h

        xchg si, cx
        mov ah, 2
        mov dl, [bx+si-1]
        int 21h
        xchg si, cx

        lea dx, sl
        mov ah, 9
        int 21h

        inc si
        dec di
        loop z

        ret
p0 endp

codigo ends
        end p0
