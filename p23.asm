pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'
extra ends
datos segment para public 'data'
    CIT DB 11, ?, 11 dup (?)
    MSG DB "Si tiene @$"
    MSGN DB "No tiene @$"
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
        lea dx, CIT
        mov ah, 0AH
        int 21h
        lea dx, SL
        mov ah, 9
        int 21h     
        
        mov al, 64
        lea di, CIT + 2
        CLD
        mov cl, 10

        repne scasb
        jz no

        lea dx, MSGN
        mov ah, 09
        int 21h
        ret

        no:
        lea dx, MSG
        mov ah, 09
        int 21h
        ret
        
p0 endp

codigo ends
        end p0
