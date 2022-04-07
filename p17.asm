pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    vai dw 925BH 
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
        ;definimos variables de control
        mov ax, vai
        mov bx, 0AH
        mov cx, sp
        z:
            div bx
            push bx
            mov dx,0
            cmp ax, 0
        jne Z

        x:
            pop dx
            mov dh, 0
            add dl, 30H
            mov ah, 02
            int 21h
            cmp sp, cx
        jnz x
        
        ret
p0 endp

codigo ends
        end p0
