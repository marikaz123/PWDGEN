;----------------------------------------------------------------------------
; PWDGEN v1.0 ** GENERATOR HASEL ** (c)1997 'marikaz'                (F2412)
;----------------------------------------------------------------------------

        IDEAL
        MODEL SMALL

CODESEG
INCLUDE 'pwdgen.i'
EXTRN GetCmdLP:PROC
EXTRN GenPwds:PROC
JUMPS

PROC    Main
        call GetCmdLP ;CY jesli blad, ax=kod bledu.
        mov dx,@DATA
        mov ds,dx
        mov es,dx
        jc svMsg
        test [cmdfl],MASK f
        jnz sChrs
        call SetFN
        jc svMsg
sChrs:
        lea di,[oSet]
        test [cmdfl],MASK dg
        jz tuc
        lea si,[dgs]
        mov cx,DIG
        rep movsb
   tuc:
        test [cmdfl],MASK uc
        jz tlc
        lea si,[ucs]
        mov cx,LCH
        rep movsb
   tlc:
        test [cmdfl],MASK lc
        jz lcs
        lea si,[lls]
        mov cx,LCH
        rep movsb
   lcs:
        test [cmdfl],MASK sc
        jz calcNC
        lea si,[scs]
        mov cx,SCH
        rep movsb
calcNC:
        lea dx,[oSet]
        sub di,dx
        mov dx,di          ;dx=ilosc elementow tablicy znakow
        mov cx,[pwdl]      ;cx=dlugosc hasla
        call GenPwds
        mov [btwr],cx      ;zwraca ilosc znakow do zapisu

        FFIND fName
        jc svBuff
        lea si,[feMsg]
        PUTSTR
  wfch:                    ;plik jest na dysku, zapytaj
        mov ah,0
        int 16h
        or al,20h
        cmp al,'t'
        jne n
        mov si,OFFSET yes
        PUTSTR
        jmp svBuff
     n:
        cmp al,'n'
        jne wfch
        mov si,OFFSET no
        PUTSTR
        mov ax,6
        jmp svMsg

svBuff:
         test [cmdfl],MASK d ;na ekran tez?
         jz noScr
         mov cx,[btwr]
         mov bx,1 ;uchwyt
         FWRITE foBuff
  noScr:
         FCREATE fName
         mov bx,ax
         mov ax,4
         jc svMsg
         mov cx,[btwr]
         sub cx,2       ;pomin ostatni enter w pliku
         FWRITE foBuff
         mov ax,4
         jc svMsg
         FCLOSE
         mov ax,4
         jc svMsg
         mov ax,0
svMsg:
         push ax
         mov bx,ax
         shl bx,1
         mov si,[msgIdx+bx]
         PUTSTR
         pop ax

         mov ah,4ch ;errorlevel: 0  bez bledow
         int 21h    ;            1  ogolny blad sciezki
         ENDP       ;            2  parametr /L:nn poza zakresem
                    ;            3  blad parametru /S
                    ;            4  blad i/o pliku
                    ;            5  brak dostepnego indeksu dla dom. nazwy
                    ;            6  plik obecny na dysku - zapis przerwano

PROC     SetFN
         lea si,[defFN]
         lea di,[fName]
         CPSTR
         push di
         add di,2
         mov ax,'t.'
         stosw
         mov ax,'tx'
         stosw
         pop di
         mov cx,100
nidx:
         mov ax,100
         sub ax,cx
         aam
         xchg ah,al
         add ax,'00'
         mov [di],ax
         FFIND fName
         jc ffn
         loop nidx
         mov ax,5
         stc
         ret
ffn:
         cmp al,12h   ;DOS: no more matching file
         jne eio
         mov ax,0
         clc
         ret
eio:
         mov ax,4     ;inny blad i/o
         stc
         ret
         ENDP

DATASEG
PUBLIC fName,pwdl,cmdfl
PUBLIC seed,oSet,foBuff

cmdfl   FLAGS <0,0,0,0,1,1,1,0>   ;domyslnie: /s:dul
pwdl    DW 10
okMsg   DB "Hasla zapisano w pliku: "
fName   DB 12 DUP (0),0
defFN   DB '_pwd__',0
ucs     DB 'ZAQWSXCDERFVBGTYHNMJUIKLOP'
scs     DB ',.?',3bh,27h,':"[]{}|=+-_)(*&^%$#@!~`'
dgs     DB '0325417869','3910746258'
lls     DB 'plokmijnuhbygvtfcrdxeszwaq'
ACH = $-ucs    ; .
LCH = scs-ucs  ;   ilosc
SCH = dgs-scs  ;    .  znakow
DIG = lls-dgs  ; .
yes     DB 't',13,10,0
no      DB 'n',13,10,0
INCLUDE 'info.inc'
        EVENDATA
msgIdx  DW okMsg,info,lErr,sErr,fErr,iErr,noMsg
btwr    DW ?
seed    DW ?
oSet    DB ACH DUP (?)
foBuff  DB 512 DUP (?)

STACK 100h

        END Main