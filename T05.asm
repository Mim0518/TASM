pila segment para stack 'stack'
    db 500 DUP(?)
pila ends

extra segment para public 'data'

extra ends
datos segment para public 'data'
    cad2 db 51,?,51 dup(?)
    cad1 db 51,?,51 dup(?)
    NP db "Tarea T05$"
    D1 db "Este programa busca una subcadena dentro de una cadena ingresada$"
    D2 db "Por el usuario, esta cadena tiene un maximo de 50 caracteres ASCII$"
    D3 db "Insituto Tecnologico de Ciudad Guzman$"
    D4 db "Ingenieria en Sistemas Computacionales$"
    D5 db "Aula K03$"
    D6 db "12 de mayo de 2022$"
    D7 db "Prof. Estanislao Castillo Horta$"
    NM db "Guillermo Moreno Rivera$"
    C1 DB 'Ingrese una cadena: $'
    C2 DB 'Ingrese una subcadena: $'
    NU DB "Ingresó una cadena nula, intentelo de nuevo$"
    NF DB "No es subcadena$"
    F  DB "Es subcadena$"
    FINZ db "Presione cualquier tecla para probar con otro numero, o ENTER para terminar: ","$"
datos ends
codigo segment para public 'code'
        assume cs:codigo , ds:datos , es:extra , ss:pila
        public main
main proc far
        push ds
        mov ax,0
        push ax
        mov ax, datos
        mov ds, ax
        mov es, ax

        call limpiap
        mov DH,0 ;renglon
        mov DL, 35 ;columna
        call poscursor
        lea dx, NP
        call impcad
        mov DH,1 ;renglon
        mov DL, 7 ;columna
        call poscursor
        lea dx, D1
        call impcad
        mov DH,2 ;renglon
        mov DL, 6 ;columna
        call poscursor
        lea dx, D2
        call impcad
        mov DH,3 ;renglon
        mov DL,20 ;columna
        call poscursor
        lea dx, D3
        call impcad
        mov DH,4 ;renglon
        mov DL,20 ;columna
        call poscursor
        lea dx, D4
        call impcad
        mov DH,5 ;renglon
        mov DL,35 ;columna
        call poscursor
        lea dx, D5
        call impcad
        mov DH,6 ;renglon
        mov DL,29 ;columna
        call poscursor
        lea dx, D6
        call impcad
        mov DH,7 ;renglon
        mov DL,23 ;columna
        call poscursor
        lea dx, D7
        call impcad
        mov DH,8 ;renglon
        mov DL, 27 ;columna
        call poscursor
        lea dx, NM
        call impcad
        jmp pedircad
        nulo:
        call impchar
        lea dx, NU
        call impcad
        pedircad:
        ;puntero en media pantalla
        mov DH,12 ;renglon
        mov DL,0 ;columna
        call poscursor
        call limpiam

        lea dx, C1
        call impcad
        lea dx, cad1
        call pidecad
        mov bl, 13
        cmp cad1+2, bl
        je nulo
        call impchar

        lea dx, C2
        call impcad
        lea dx, cad2
        call pidecad
        call impchar

        mov bl, 13
        cmp cad1+2, bl
        je nulo
        cmp cad2+2, bl
        je nulo


        xor cx, cx
        xor ax, ax
        cld
        lea si, cad2 + 2
        lea di, cad1 + 2
        mov cx, 50
        mov al, cl
        sub al, cad2+1
        sub al, 1
        comp:
            repe cmpsb
            jz equals
            cmp cl, al
            je equals
            lea si, cad2 + 2
            cld
            cmp cl, 0
            je negativo
            mov al, cl
            sub al, cad2+1
            sub al, 1
            jmp comp
        negativo:
            lea dx, NF
            call impcad
            call impchar
            jmp repetir
        equals:
            lea dx, F
            call impcad
            call impchar
        repetir:
        lea dx, FINZ
        call impcad
        call impchar
        mov ah, 1
        int 21h
        mov ah, 13
        cmp ah, al
        jne pedircad
        fin:
        call limpiap
        ret
main endp
limpiap proc near
    mov ch, 0
    mov cl, 0
    mov dh, 24
    mov dl, 79
    mov ah, 6
    mov al, 0
    mov bh, 7
    int 10h
    ret
limpiap endp
poscursor proc near
    mov AH,2
    mov BH,0
    int 10H
    ret
poscursor endp
impcad proc near
     mov ah, 9
     int 21h
     ret
impcad endp
limpiam proc near
    mov ch, 12
    mov cl, 0
    mov dh, 24
    mov dl, 79
    mov ah, 6
    mov al, 0
    mov bh, 7
    int 10h
    ret
limpiam endp
pidecad proc near
    mov ah, 0ah
    int 21h
    ret
pidecad endp
impchar proc near
    mov dx, 10
    mov ah, 2h
    int 21h
    ret
impchar endp
codigo ends
        end main