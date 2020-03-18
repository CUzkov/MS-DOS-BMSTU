;kbEsc equ 1Bh               ;код Esc



start:    
    PUSH DS  
    POP  ES 
 
    Table db '0123456789ABCDEF'

    mov bx,offset Table
    mov al, 1
    xlat
    mov ah, 0eH
    int 10h 

@@Loop:
    mov     ah, 01h
    int     21h             ;Ожидание ввода символа

    cmp     al, kbEsc       ;Сравнение файлов, флаг в je
    je      @@Break
 
    mov ah, 0eH
    int 10h                 ;печать символа ASCII (0Eh прерывания 10h)
 
    mov     ah, al          ;печать разделителя - пробела
    mov     al, ' '
    int     29h
 
    mov     al, ah          ;печать кода символа
    call    ShowHex
 
    mov     ah, al          ;печать разделителя - пробела
    mov     al, ' '
    int     29h
 
    jmp     @@Loop
@@Break:

@@Exit:
    mov  ax, 4C00h           ; выход в DOS
    int  21h

ShowHex PROC
    push    ax
    push    bx
    push    cx

    mov cx, ax
    shr al, 4
    and ax, 000fh
    ;mov bx, offset Tabl
    mov al, 4
    xlat
    int     29h

    mov     ax, cx
    and     ax, 000fh
    xlat
    int     29h

    pop     cx
    pop     bx
    pop     ax
    ret
ShowHex ENDP