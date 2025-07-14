; GetCmdLP:PROC rev. B2
; --> [/D] [/L[:]nn] [/S[:]duls] [OutFile]

          IDEAL
          MODEL SMALL

CODESEG
INCLUDE 'pwdgen.i'
PUBLIC GetCmdLP
JUMPS

PROC      GetCmdLP
          LOCALS
          mov ax,@DATA
          mov es,ax
          mov si,80h
          cmp [BYTE si],0
          je  @@eop
          add si,1
@@skbc1:
          lodsb
          cmp al,TAB
          je @@skbc1
          cmp al,SPC
          je @@skbc1
          cmp al,CR
          je @@eop
          cmp al,20h
          jb @@err
          cmp al,'/'
          je @@switch

          test [es:cmdfl],MASK f ;filename
          jnz @@err
          or [es:cmdfl],MASK f
          lea di,[es:fName]
          dec si ;korekta po lodsb
          mov cx,8+1 ; \
@@gfn:               ;    ok= wyskok z petli (obu)
          cmp [BYTE si],20h
          jbe @@skbc1
          cmp [BYTE si],'.'
          je @@dot
          movsb
          loop @@gfn
          jmp @@err
   @@dot:
          movsb
          mov cx,3+1 ; ..
   @@gex:
          cmp [BYTE si],20h
          jbe @@skbc1
          movsb
          loop @@gex
          jmp @@err
@@switch:
          lodsb
          or al,20h
          cmp al,'l'
          je @@caseL
          cmp al,'s'
          je @@caseS
          cmp al,'d'
          je @@caseD
          jmp @@err
@@caseD:
          test [es:cmdfl],MASK d
          jnz @@err
          or [es:cmdfl],MASK d
          cmp [BYTE si],20h
          jbe @@skbc1
          jmp @@err
@@caseL:
          test [es:cmdfl],MASK l
          jnz @@err
          or [es:cmdfl],MASK l
          cmp [BYTE si],'='
          jne @@err
          inc si
          lodsb
          cmp al,'0'
          jb @@err
          cmp al,'9'
          ja @@err
          sub al,'0'
          mov [BYTE es:pwdl],al
          ;2 cyfra, jesli jest
          cmp [BYTE si],20h
          jbe @@el
          lodsb
          cmp al,'0'
          jb @@err
          cmp al,'9'
          ja @@err
          sub al,'0'
          mov ah,[BYTE es:pwdl] ;2 cyfry, pierwsza x10
          shl ah,1
          mov dl,ah
          shl ah,2
          add ah,dl
          add al,ah
          mov [BYTE es:pwdl],al
    @@el:
          cmp al,PLO   ;min. ilosc znamow
          jb @@lerr
          cmp al,PHI   ;max. ilosc znakow
          ja @@lerr
          cmp [BYTE si],20h
          jbe @@skbc1
          jmp @@err
@@caseS:
          test [es:cmdfl],MASK s
          jnz @@err
          or [es:cmdfl],MASK s
          cmp [BYTE si],':'
          jne @@s
          inc si
     @@s:
          and [es:cmdfl],0f0h ;jesli jest /s to trzeba wybrac
          mov cx,4            ;4 obroty
   @@gch:
          cmp [BYTE si],20h
          jbe @@es
          lodsb
          or al,20h
          cmp al,'d'
          jne @@cuc
          test [es:cmdfl],MASK dg
          jnz @@serr
          or [es:cmdfl],MASK dg
          loop @@gch
          jmp @@es
   @@cuc:
          cmp al,'u'
          jne @@lcc
          test [es:cmdfl],MASK uc
          jnz @@serr
          or [es:cmdfl],MASK uc
          loop @@gch
          jmp @@es
   @@lcc:
          cmp al,'l'
          jne @@scc
          test [es:cmdfl],MASK lc
          jnz @@serr
          or [es:cmdfl],MASK lc
          loop @@gch
          jmp @@es
   @@scc:
          cmp al,'s'
          jne @@serr     ;ostatnia prawidlowa litera w kolejce...
          test [es:cmdfl],MASK sc
          jnz @@serr
          or [es:cmdfl],MASK sc
          loop @@gch
          jmp @@es
   @@es:
          mov al,[es:cmdfl]
          and al,1111b
          jz @@serr
          cmp [BYTE si],20h
          ja @@serr
          jmp @@skbc1
@@err:
          mov ax,1  ;ogolny blad sciezki
          stc
          jmp @@ret
@@lerr:
          mov ax,2  ;blad /l poza zakresem
          stc
          jmp @@ret
@@serr:
          mov ax,3  ;blad zestawu /s
          stc
          jmp @@ret
@@eop:
          mov ax,0
          clc
@@ret:
          ret
          ENDP

DATASEG
EXTRN fName
EXTRN cmdfl:BYTE,pwdl:WORD

          END
