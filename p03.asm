pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    cad01 DB "estuvo facil el examen$"

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

        mov ax,ds
        mov bx,es
        mov ds,bx
        mov es,ax

        lea dx, C0
        mov ah,9
        int 21h

        

        ret
p0 endp

codigo ends
        end p0
