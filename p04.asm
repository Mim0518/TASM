pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    CAIDT db 10,?,10 dup(?)
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

        lea dx, CAIDT
        mov ah, 0ah
        int 21h

        ret
p0 endp

codigo ends
        end p0