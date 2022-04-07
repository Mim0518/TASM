pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    imp DB 10,"Si es ASCII$"
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
        ;Leer caracter
        mov ah, 01
        int 21h
        ;Decision
        mov cl, 127
        cmp al, cl
        JBE proce
        jmp fin
        proce:
        lea dx, imp
        mov ah, 9
        int 21h
        fin:
        ret
p0 endp

codigo ends
        end p0
