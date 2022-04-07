pila segment para stack 'stack'

pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    cad01 DB 'Escriba una cadena de maximo 20 caracteres: ','$'
    cad02 DB 'La cadena que Ud escribio en el teclado es: ','$'
    cad03 DB 'Programa T01$'
    cad04 DB 'Guillermo Moreno Rivera$'
    cad05 DB 'Presione una tecla para finalizar$'
    buffer db 20,?,20 dup(?)
    SL DB 10,13,24H
    ctlf: db 13,10,"$"
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

        limpiar_pantalla:
        MOV CH, 0
        MOV CL, 0
        MOV DH, 24
        MOV DL, 79
        MOV AH, 6
        MOV AL, 0
        MOV BH, 7
        INT 10H

        lea dx, cad01
        mov ah, 9h
        int 21h

        mov dx, offset buffer
        mov ah, 0ah
        int 21h

        mov dx, offset ctlf
        mov ah, 9h
        int 21h

        mov cx, 3
        x:
        lea dx, sl
        mov ah, 9
        int 21h
        loop x

        lea dx, cad02
        mov ah, 9h
        int 21h

        xor bx, bx
        mov bl, buffer[1]
        mov buffer[bx+2], '$'
        mov dx, offset buffer + 2
        mov ah, 9h
        int 21h

        mov cx, 3
        y:
        lea dx, sl
        mov ah, 9
        int 21h
        loop y

        lea dx, cad03
        mov ah, 9h
        int 21h

        lea dx, sl
        mov ah, 9
        int 21h

        lea dx, cad04
        mov ah, 9h
        int 21h

        lea dx, sl
        mov ah, 9
        int 21h

        lea dx, cad05
        mov ah, 9h
        int 21h
        ret
p0 endp

codigo ends
    end p0