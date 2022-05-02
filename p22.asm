pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'
    PC DB "Murcielago"
extra ends
datos segment para public 'data'
    CIT DB 11, ?, 11 dup (?)
    MSG DB "Simon$"
    MSGN DB "Nel$"
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
        lea dx, CIT
        mov ah, 0AH
        int 21h
        lea dx, SL
        mov ah, 9
        int 21h     
        
        lea si, CIT + 2
        lea di, PC
        CLD
        mov cl, 10

        repe cmpsb
        JZ no

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
