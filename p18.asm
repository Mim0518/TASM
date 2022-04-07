pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    N dw 65535
    R dw ?
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
        mov ax, N
        mov cx, 1
        mov dx, 0
        JAXZ fin
        proce:
            sub ax, cx
            add cx, 2
            inc dx
            cmp ax, cx
        JAE proce
        fin:
        mov R, dx
        ret
p0 endp

codigo ends
        end p0
