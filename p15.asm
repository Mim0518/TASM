pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
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
        ;Leer caracter
        mov ah, 01
        int 21h
        ;Decision
        mov bl, 164
        cmp al, bl
        JE n1
        mov bl, 165
        cmp al, bl
        JE n2
        JB fin
        mov bl, 90
        cmp al, bl
        JA minus
        add al, 32
        jmp fin
        minus:
        mov bl, 97
        cmp al, bl
        JB fin
        mov bl, 122
        cmp al, bl
        JA fin
        sub al, 32
        fin:
        mov ah, 2
        mov dl, al
        int 21h
        ret
        n1:
        add al, 1
        jmp fin
        n2:
        sub al, 1
        jmp fin
        
p0 endp

codigo ends
        end p0
