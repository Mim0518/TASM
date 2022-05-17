;-----------------------------
; Invocamos el procedimiento sin más
;-----------------------------
public cls
codigo segment para public 'code'
cls proc far
    ;Guardamos los registros en la pila para mantener el valor
    push cx
    push dx
    push ax
    push bx
    ;Limpiamos cx, es nuestro punto de inicio desde donde se borrará la pantalla
    mov ch, 0
    mov cl, 0
    ;Ponemos en dx el punto final hasto donde se borrará la pantalla, en este caso Renglon 24 columna 79
    mov dh, 24
    mov dl, 79
    ;Función 06 de la interrupción 10h
    mov ah, 6
    mov al, 0
    mov bh, 7
    int 10h
    ;Sacamos los valores guardados
    pop bx
    pop ax
    pop dx
    pop cx
    ret
cls endp
codigo ends
end 
