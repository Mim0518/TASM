pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
        D0 DB 8, 0, 127, 3FH, 01111111b, 255
        C0 DB "jueves", 65, 41H, 01000000b
        D1 DW 8, 0, 127

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
        
        ret
p0 endp

codigo ends
        end p0
