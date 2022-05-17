extern cls:far
pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data' 
extra ends
datos segment para public 'data'
    D1 DB "Presione una tecla para continuar..."
    SL DB 10,13,24H
datos ends
codigo segment para public 'code'
        assume cs:codigo , ds:datos , es:extra , ss:pila
        public p0
p0 proc far
        push ds
        mov ax,0
        push ax
        mov ax, datos
        mov ds, ax
        mov ax, extra
        mov es, ax
        mov ax, 20
        push ax
        push bx
        push cx
        push dx
        call cls
    
        lea dx, D1
        mov ah, 9
        int 21h

        mov ah, 1
        int 21h

        call cls
        pop dx
        pop cx
        pop bx
        pop ax
        ret
p0 endp
codigo ends
end p0
