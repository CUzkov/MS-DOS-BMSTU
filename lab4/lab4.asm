MYCODE SEGMENT 'CODE'
    ASSUME CS:MYCODE,DS:MYCODE
    HexTabl db '0123456789ABCDEF'
    kbEsc equ 1Bh
    UpBorder db '⁄ƒƒƒƒƒƒø$'
    MiddleBorder db '≥'
    BottomBorder db'¿ƒƒƒƒƒƒŸ$'
    EqualSign db ' = $'
    ent db 10, 13, '$'
    ErrorMsg db 'Invalid number!$'
start:
    PUSH CS
    POP  DS

    call Cls
    call CorrInput
    call PrintTable
    call NextStr

@@Loop:
    call CorrInput

    cmp     al, kbEsc
    je      @@Break

    push ax
    mov ah, 09h
    mov dx, offset [UpBorder]
    int 21h
    call NextStr
    mov al, [MiddleBorder]
    int 29h
    pop ax
    int 29h
    push ax

    mov ah, 09h
    mov dx, offset [EqualSign]
    int 21h

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

    mov al, [MiddleBorder]
    int 29h
    call NextStr
    pop ax
    mov ah, 09h
    mov dx, offset [BottomBorder]
    int 21h
    call NextStr
    mov al, 1

    jmp     @@Loop
@@Break:

@@Exit:
    call Cls
    mov  ax, 4C00h
    int  21h

proc PrintTable
    add al, -1
    push ax

    mov bx, offset [HexTabl]
    mov ah, 09h
    mov dx, offset [UpBorder]
    int 21h
    call NextStr
;Å´Æ™
    mov cx, 14h
L:
    mov al, [MiddleBorder]
    int 29h
    pop ax
    add al, 1
    int 29h
    push ax

    mov ah, 09h
    mov dx, offset [EqualSign]
    int 21h

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

    mov al, [MiddleBorder]
    int 29h
    call NextStr
    pop ax
    push ax
    cmp al, 255
    je @@Stop
    loop L
;Å´Æ™
@@Stop:
    pop ax
    mov ah, 09h
    mov dx, offset [BottomBorder]
    int 21h
    call NextStr
    ret
endp PrintTable

proc NextStr
    lea dx, ent
    mov ah, 9
    int 21h
    ret
endp NextStr

proc Cls
    mov ah, 00h
    mov al, 2
    int 10h
endp Cls

proc CorrInput
@@Loop2:
    mov ah, 08h
    int 21h
    cmp al, 14h
    jb @@Error
    ja @@Break2
    @@Error:
    mov ah, 09h
    mov dx, offset [ErrorMsg]
    int 21h
    call NextStr
    jmp @@Loop2
@@Break2:
    call NextStr
    ret
endp CorrInput
MYCODE ENDS
END START
