code segment
    assume CS:code, DS:data

start: 

mov ax, data
mov ds, ax

@mainLoop:

    mov ah, 09h
    mov dx, offset [firstMsg]
    int 21h

    mov cx, 4
    @loop1:
        call CorrInput
        push ax
        loop @loop1

    mov ah, 09h
    mov dx, offset [[equalSing]]
    int 21h

    mov dx, 0

;Block

    pop ax
    cmp al, 3Dh
    ja @letter1
    mov ah, 0
    add ax, -30h
    add dx, ax
    jmp @next1
    @letter1:
    mov ah, 0
    add ax, -37h
    add dx, ax
    @next1:

    pop ax
    mov ah, 0
    cmp al, 3Dh
    ja @letter2
    add ax, -30h
    mov bx, 16
    push dx
    mul bx
    pop dx
    add dx, ax
    jmp @next2
    @letter2:
    mov ah, 0
    add ax, -37h
    mov bx, 16
    push dx
    mul bx
    pop dx
    add dx, ax
    @next2:

    pop ax
    mov ah, 0
    cmp al, 3Dh
    ja @letter3
    add ax, -30h
    mov bx, 100h
    push dx
    mul bx
    pop dx
    add dx, ax
    jmp @next3
    @letter3:
    mov ah, 0
    add ax, -37h
    mov bx, 100h
    push dx
    mul bx
    pop dx
    add dx, ax
    @next3:

    pop ax
    mov ah, 0
    cmp al, 3Dh
    ja @letter4
    add ax, -30h
    mov bx, 1000h
    push dx
    mul bx
    pop dx
    add dx, ax
    jmp @next4
    @letter4:
    mov ah, 0
    add ax, -37h
    mov bx, 1000h
    push dx
    mul bx
    pop dx
    add dx, ax
    @next4:

;Block

    mov ax, dx
    mov bx, offset [hexTabl]

    push ax
    shr ax, 12
    xlat
    int 29h
    pop ax
    push ax
    and ah, 0Fh
    shr ax, 8
    xlat
    int 29h

    pop ax
    push ax
    shr al, 4
    xlat
    int 29h
    pop ax
    push ax
    and al, 0Fh
    xlat
    int 29h

    mov al, 'h'
    int 29h
    push dx
    call NextStr
    pop dx

    mov ah, 09h
    push dx
    mov dx, offset [decFormat]
    int 21h
    pop dx

    mov ax, dx
    mov dx, 0
    mov bx, 10000
    div bx
    add al, 30h
    int 29h
    
    mov ax, dx
    mov dx, 0
    mov bx, 1000
    div bx
    add al, 30h
    int 29h

    mov ax, dx
    mov dx, 0
    mov bx, 100
    div bx
    add al, 30h
    int 29h

    mov ax, dx
    mov dx, 0
    mov bx, 10
    div bx
    add al, 30h
    int 29h

    mov ax, dx
    mov dx, 0
    mov bx, 1
    div bx
    add al, 30h
    int 29h

    call NextStr

    jmp @mainLoop

mov al, 0      
mov ah, 4CH      
int 21H

proc NextStr
    lea dx, ent
    mov ah, 9
    int 21h
    ret
endp NextStr

proc CorrInput
@@Loop2:
    mov ah, 01h
    int 21h

    cmp al, 3Dh
    ja @@letter

    cmp al, 30h
    jb @@Error
    cmp al, 39h
    ja @@Error
    jmp @@Break2

    @@letter:
    cmp al, 41h
    jb @@Error
    cmp al, 46h
    ja @@Error
    jmp @@Break2

    @@Error:
    cmp al, '*'
    je @@stop
    mov ah, 09h
    mov dx, offset [errorMsg]
    int 21h
    @@stop:
    call NextStr
    mov al, 0      
    mov ah, 4CH
    int 21H

@@Break2:
    ret
endp CorrInput

code ends
data segment
    ent db 10, 13, '$'
    errorMsg db 'Invalid number!$'
    firstMsg db 'Enter number: $'
    equalSing db ' = $'
    hexTabl db '0123456789ABCDEF'
    decFormat db 'Dec form: $'
data ends
end start  