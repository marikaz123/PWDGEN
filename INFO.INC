; ---

info DB 'GENERATOR HASEL ++ PWDGEN v1.0 (F2412) ++ (c)1997 ',27h,'MARIKAZ',27h,0Dh,0Ah
DB 0Dh,0Ah
DB '   PWDGEN.EXE [/D] [/L[:]nn] [/S[:]<duls>] [OutFile]',0Dh,0Ah
DB 0Dh,0Ah
DB '/D       Pokaz hasla na ekranie.',0Dh,0Ah
DB '/L[:]nn  Dlugosc hasla, nn=8..30 (domyslnie 10).',0Dh,0Ah
DB '/S[:]    Uzyj znakow: d  cyfr,',0Dh,0Ah
DB '                      u  duzych liter,',0Dh,0Ah
DB '                      l  malych liter,',0Dh,0Ah
DB '                      s  znakow specjalnych.',0Dh,0Ah
DB 'OutFile  Nazwa pliku dla wygenerowanych hasel.',0Dh,0Ah
DB 0Dh,0Ah,0

lErr DB 'Ilosc znakow hasla poza zakresem.',0Dh,0Ah,0
sErr DB 'Blad zestawu znakow. Oczekiwano: /s[:]<duls>',0Dh,0Ah,0
fErr DB 'Blad i/o operacji na pliku.',0Dh,0Ah,0
iErr DB 'Brak dostepnego indeksu dla domyslnej nazwy pliku.',0Dh,0Ah,0
feMSG DB 'Plik jest obecny na dysku. Zastapic? [t/n] ',0
noMSG DB 'Zapis do pliku przerwano.',0Dh,0Ah,0
