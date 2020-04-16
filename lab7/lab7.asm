code segment
    assume CS:code, DS:data

start: 

mov ax, data
mov ds, ax

xor   bx, bx
mov   bl, es:[80h]
mov   byte [bx + 81h], '$'

; print the string
mov   ah, 9
mov   dx, es:[81h]
int   21h


@last:
mov al, 0      
mov ah, 4CH      
int 21H

proc NextStr
    lea dx, ent
    mov ah, 9
    int 21h
    ret
endp NextStr

code ends
data segment
    firstStrYes db 'First param is coorrect = $'

    ent db 10, 13, '$'
data ends
end start  