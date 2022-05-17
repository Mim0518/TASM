;---------------------
;Funcion salto de linea
;Invocar a la función sin más
;No necesita parametros
;---------------------
public saltolinea
codigo segment para public 'code'
saltolinea proc far
    push ax
    push dx
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    pop dx
    pop ax
    ret
saltolinea endp
codigo ends
end