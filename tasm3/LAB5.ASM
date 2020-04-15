code segment
    assume CS:code, DS:code
    org 100h 

start: 
    mov ax, cs
    mov ds, ax
@@Loop2:
    push ax
    mov bp, sp
    pop ax
;ввод строки
    mov ah, 01h
    int 21h
    cmp al, '*'
    mov ah, 0
    je @@Exite1
    push ax
    mov cx, 19
    @@Loop1:
    mov ah, 01h
    int 21h
    push ax
    cmp al, '$'
    je @@Breake1    
    loop @@Loop1
    @@Breake1:
    mov ax, 14h
    sub ax, cx
    mov cx, ax
    mov [buff], cx
;конец ввода
    cmp ax, 0
    je @@Exite2
    mov ah, 09h
    mov dx, offset [EqualSing]
    int 21h
    mov bx, offset [HexTabl]
    mov si, 0
    @@Loop3:
        call Hex
        mov ah, 02h
        mov dl, 20h
        int 21h
        add bp, -2
        loop @@Loop3
    call NextStr
    mov cx, [buff]
    @@Loop4:
        pop ax
        loop @@Loop4
    jmp @@Loop2
    @@Exite1:
    @@Exite2:
    mov ah, 4ch
    mov al, 0
    int 21h

proc Hex
    mov ax, [bp]
    shr al, 4
    xlat
    int 29h

    mov ax, [bp]
    and al, 0Fh
    xlat
    int 29h   
    ret 
endp Hex

proc NextStr
    lea dx, ent
    mov ah, 9
    int 21h
    ret
endp NextStr

HexTabl db '0123456789ABCDEF'
EqualSing db ' = $'
ent db 10, 13, '$'
buff dw 0

code ends
end start  