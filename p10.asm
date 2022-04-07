pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    PLA DB "Si presiono la letra A$"
    ct db 2,?,2 dup(?)
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

        mov ah, 01
        mov dx, offset ct
        int 21h
        lea dx, sl
        mov ah, 9
        int 21h
        mov bl, 65
        cmp al, bl
        jne fin
        lea dx, PLA
        mov ah, 9
        int 21h
        fin:
        ret
p0 endp

codigo ends
        end p0
