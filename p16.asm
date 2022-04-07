pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    num DB 6, ?, 6 dup (?)
    v dw ?
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
        ;Leer cadena
        lea dx, num
        mov ah, 0AH
        int 21h
        ;definimos variables de control
        lea bx, num + 1
        mov ch, 0
        mov cl, [bx]
        push cx
        cv:
                inc bx
                sub [bx], 30H
        loop cv
        
        pop cx
        dec cx
        mov si, 0AH
        lea bx, num + 1
        inc bx
        mov al, [bx]
        mov ah, 0
        jcxz tp
        guardado:
        mul si
        inc bx
        mov dl, [bx]
        mov dh, 0
        add ax, dx
        loop guardado
        tp:
        mov v, ax
        ret
p0 endp

codigo ends
        end p0
