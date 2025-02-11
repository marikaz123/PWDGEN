; ---

INCLUDE '..\..\_MAC\ifileio.mac'

RECORD FLAGS d:1,l:1,f:1,s:1,dg:1,uc:1,lc:1,sc:1

SPC EQU 20h
TAB EQU 9
CR  EQU 0Dh

PLO EQU 8    ;min. ilosc znakow hasla
PHI EQU 30   ;max. ilosc znakow hasla
PPF EQU 10   ;ilosc hasel w pliku. Uwaga! Plik max. 512 bajtow!

MACRO PUTSTR
      LOCAL @l,@x
      mov ah,0eh
  @l:
      lodsb
      or al,al
      je @x
      int 10h
      jmp @l
  @x:
      ENDM

MACRO CPSTR
      LOCAL @l,@x
  @l:
      cmp [BYTE si],0
      je @x
      movsb
      jmp @l
  @x:
      ENDM
