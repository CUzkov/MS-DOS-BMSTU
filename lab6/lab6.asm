code segment
    assume CS:code, DS:data

start: 

mov ax, data
mov ds, ax

xor bx, bx
mov cl, es:[80h]

mov bx, 0
mov bl, -1
@loop1:
add bl, 1
mov dl, es:[82h + bx]
cmp dl, [correctParam + bx]
je @loop1
cmp dl, 20h
je @YesF
add bl, 1
cmp cl, bl
jne @Uncorr


@YesF:
mov ah, 09h
mov dx, offset [firstStrYes]
int 21h
mov ah, 09h
mov dx, offset [correctParam]
int 21h
call NextStr

jmp @SecondParam

@Uncorr:
mov ah, 09h
mov dx, offset [firstStrNo]
int 21h
call NextStr

add bl, 1
@loop5:
mov dl, es:[82h + bx]
cmp dl, 20h
je @SecondParam
cmp cl, bl
je @SecondParam
add bl, 1
jmp @loop5


@SecondParam:

cmp bl, cl 
jne @exite

jmp @exite2

@exite:
mov ah, 09h
mov dx, offset [secondStrYes]
int 21h
call NextStr
jmp @last

@exite2:
mov ah, 09h
mov dx, offset [secondStrNo]
int 21h
call NextStr

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
    firstStrNo db 'First param is not correct!$'
    secondStrYes db 'Second param entered!$'
    secondStrNo db 'Second param not entered!$'
    correctParam db 'Uskov$'
    numbOfParam db 'Entered params: $'
    ent db 10, 13, '$'
data ends
end start  