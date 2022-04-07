pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
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
        
        mov cx, 26
        mov dl, 65
        x:
        mov ah, 2
        int 21h
        inc dl
        loop x
        
        lea dx, sl
        mov ah, 9
        int 21h

        mov cx, 26
        mov dl, 90
        y:
        mov ah, 2
        int 21h
        dec dl
        loop y

        lea dx, sl
        mov ah, 9
        int 21h

        mov cx, 26
        mov dl, 65
        z:
        mov ah, 2
        int 21h
        ADD dl, 32
        mov ah, 2
        int 21h
        SUB dl, 32
        inc dl
        loop z

        lea dx, sl
        mov ah, 9
        int 21h

        mov cx, 26
        mov dh, 97
        mov dl, 65
        m:
        mov ah, 2
        int 21h
        mov bx, dl
        mov dl, dh
        mov dh, bx
        loop m

        ret
p0 endp

codigo ends
        end p0
