;GenPwds:PROC rev. A

        IDEAL
        MODEL SMALL

CODESEG
INCLUDE 'pwdgen.i'
PUBLIC GenPwds

PROC    GenPwds
        push bp
        mov bp,dx     ;ilosc el. tab. znakow w bp
        push cx       ;dlugosc hasla...
        mov ah,0
        int 1ah
        mov [seed],dx
        pop dx           ;..do dx
        mov cx,PPF       ;ilosc hasel w pliku
        lea di,[foBuff]
nxp:
        push cx
        mov cx,dx
nxs:
        call @SimRnd  ;wy: bx = offset wylosowanego znaku wzg. oSet
        mov al,[BYTE oSet+bx]
        stosb
        loop nxs
        mov ax,0a0dh
        stosw
        pop cx
        loop nxp
        lea dx,[foBuff]
        sub di,dx
        mov cx,di   ;wy: cx=ilosc bajtow do zapisu.
        pop bp
        ret
        ENDP

        PROC @SimRnd
        push dx
        xor dx,dx
        mov bx,[seed]
        add bx,9248h
        ror bx,3
        mov [seed],bx
        mov ax,bp
        mul bx
        mov bx,dx
        pop dx
        ret
        ENDP

UDATASEG
EXTRN seed:WORD,oSet,foBuff

        END
