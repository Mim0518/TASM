pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'
    CADC DB 21 dup ("$")  
extra ends
datos segment para public 'data'
    CAD DB 21, ?, 21 dup (?)
    
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
        mov ax, extra
        mov es, ax
        
        ;Leer cadena
        lea dx, CAD
        mov ah, 0AH
        int 21h
        
        cld
        lea si, cad + 2
        lea di, CADC
        lea bx, cad+1
        mov cl, [bx]
        mov ch, 00
        rep movsb

        lea dx, SL
        mov ah, 9
        int 21h  

        push ds
        push es
        pop ds
        pop es

        lea dx, CADC
        mov ah, 9
        int 21h  
        ret
p0 endp

codigo ends
        end p0
