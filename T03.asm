pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    NP DB "Programa T03"
    NM DB "Guillermo Moreno Rivera"
    DS1 DB "Este programa solicita una entrada por el teclado, misma que $"
    DS2 DB "Evaluará y emitirá un mensaje dependiendo del resultado de la misma $"
    P1 DB "Ingrese un número dentro del rango de los valores tipo word (0-65535): $"
    MS1 DB "Escribio en el teclado una cadena NULA, no es numero$"
    MS2 DB "Escribio en el teclado algun simbolo que no representa numeros$"
    MS3 DB "Escribio en el teclado un numero fuera del rango$"
    MA DB "Introdujo un valor decimal sin signo tipo word$"
    MF DB "Presione cualquier tecla para probar con otro numero, o ENTER para
           terminar$"
    Cad DB 6, ?, 6 dup (?)
    SL DB 10,13,24H
    CONT DB 0
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
        ;Limpia Pantalla
        MOV CH, 0
        MOV CL, 0
        MOV DH, 24
        MOV DL, 79
        MOV AH, 6
        MOV AL, 0
        MOV BH, 7
        INT 10H
        ;Poner cursor al principio
        MOV DH,0
        MOV DL,31
        MOV AH,2
        MOV BH,0
        INT 10H
        ;Nombre del Programa
        lea dx, NP
        mov ah, 0AH
        int 21h
        ;Leer cadena
        lea dx, Cad
        mov ah, 0AH
        int 21h
        ;Convertimos a decimal
        lea bx, Cad + 1
        mov ch, 0
        mov cl, [bx]
        push cx
        cv:
                inc bx
                sub [bx], 30H
        loop cv
        ;Preparamos registros
        pop cx
        dec cx
        mov si, 0AH
        lea bx, Cad + 1
        inc bx
        mov al, [bx]
        mov ah, 0
        jcxz tp
        ;Convertimos a hex
        guardado:
        mul si
        inc bx
        mov dl, [bx]
        mov dh, 0
        add ax, dx
        loop guardado
        ;Guarda num hex en N
        tp:
        mov N, ax
        ;Sacamos Raiz y la guardamos en R
        mov ax, N
        mov cx, 1
        mov dx, 0
        proce:
            sub ax, cx
            add cx, 2
            inc dx
            cmp ax, cx
        JAE proce
        mov r, dx
        fin:
        ;Convertimos a decimal e imprimimos
        mov dl, 10
        mov ah, 2
        int 21h

        xor ax, ax
        xor bx, bx
        xor dx, dx

        mov ax, [r]
        mov bx, 0ah
        mov cx, sp

        z:
                div bx
                push dx
                mov dx, 0
                cmp ax, 0
        jne z
        x:
                pop dx
                mov ah, 2
                mov dh, 0
                add dl, 30h
                int 21h
                cmp sp, cx
        jnz x
        ret
p0 endp

codigo ends
        end p0