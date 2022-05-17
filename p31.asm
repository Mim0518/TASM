pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'

datos ends
codigo segment para public 'code'
        assume cs:codigo , ds:datos , es:extra , ss:pila
        public p0
main proc far
    push ds
    mov ax,0
    push ax
    mov ax, datos
    mov ds, ax
    mov ax, extra
    mov es, ax
        
        
    ret
main endp

codigo ends
        end main
