pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data' 
extra ends
datos segment para public 'data'
    C1 DB 20 dup ("$") 
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
       ;mov ax, extra
        mov es, ax
        
        ;Leer cadena
        mov al, 64
        mov cx, 5
        cld
        lea di, C1
        rep stosb

        lea dx, C1
        mov ah, 9
        int 21h  
        ret
p0 endp

codigo ends
        end p0
