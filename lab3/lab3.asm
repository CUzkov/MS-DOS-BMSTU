MYCODE SEGMENT 'CODE'
    ASSUME CS:MYCODE,DS:MYCODE
buff db 'j'     
let1 db 's'
let2 db 'j'
let3 db 'j'

ent db 10, 13, '$'
start:
;Загрузка сегментного региства данных
    PUSH CS
    POP DS

;Исполнение программы

    call GetChar
    mov al, buff
    mov let1, al
    call NextStr
    ;call GetChar
    ;mov al, buff
    ;mov let2, al
    ;call GetChar
    ;mov al, buff
    ;mov let3, al

    mov dl, let1
    call AddOne
    mov al, buff
    mov let1, al
    mov dl, let1
    call PrintChar
    call NextStr

    mov dl, let1
    call AddOne
    mov al, buff
    mov let1, al
    mov dl, let1
    call PrintChar
    call NextStr

    mov dl, let1
    call AddOne
    mov al, buff
    mov let1, al
    mov dl, let1
    call PrintChar
    call NextStr

; Ожидание завершения программы  
    MOV ah, 08  
    INT 021H 
; Выход из программы      
    MOV al, 0      
    MOV ah, 4CH      
    INT 21H

;Функции
proc NextStr
    lea dx, ent
    mov ah, 9
    int 21h
    ret
endp NextStr    

GetChar proc
    mov ah, 01
    int 21h
    mov buff, al
    ret
GetChar endp

PrintChar proc
    mov ah, 02
    int 21h
    ret
PrintChar endp

proc Clear
    mov cx,80*24
    mov dl,' '
    mov ah,2
    m1:
    int 21h
    loop m1
    ret
endp Clear

proc AddOne
    mov ah, dl
    add ah, 1
    mov buff, ah
    ret
endp AddOne
MYCODE ENDS 
END START 