-----------------------------------------------------------------------------
 PWDGEN v1.0.2
 (c)1997 'marikaz'           ** GENERATOR HASEL **
                                                                   [MOD2412]
-----------------------------------------------------------------------------

Program, na podstawie podanych parametrow, generuje serie 10 hasel i zapisuje
je do pliku. Podanie parametrow nie jest obowiazkowe i w takim przypadku
program uzyje opcji domyslnych, o ktorych ponizej.

 UZYCIE

 PWDGEN.EXE [/D] [/L[:]nn] [/S[:]<duls>] [OutFile]

/D        Wyswietla wygenerowane hasla rowniez na ekranie.
/L[:]nn   Dlugosc hasla, nn=8..30 znakow.
/S[:]     Zestaw znakow: d - cyfry,
                         u - duze litery,
                         l - male litery,
                         s - znaki specjalne,
OutFile  Nazwa pliku dla wygenerowanych hasel.

- Kolejnosc wystapienia tych parametrow jest dowolna,
- biale znaki (space, tab) pomiedzy parametrami sa ignorowane,
- wielkosc liter jest dowolna.

 OPCJE DOMYSLNE

/L:10   - 10 znakow.
/S:dul  - cyfry, litery duze i male.
OutFile - __pwd_NN.txt, gdzie NN jest indeksem z przedzialu 00..99.
          Plik zostanie zapisany pod nazwa z pierwszym wolnym indeksem.
          W przypadku braku wolnego indeksu program zglosi blad.

 UWAGI

- Z zestawu znakow specjalnych wykluczono:
 "/"  slash, "\"  backslash, "<"  less than, ">"  greater than.

- Jezeli plik OutFile jest juz na dysku, uzytkownik zostanie o tym
  poinformowany pytaniem o nadpisanie istniejacego pliku. Odpowiedzi
  standardowe: klawisz t - tak, n - nie.

 POWIADOMIENIA

Powiadomienia dotycza nastepujacych przypadkow - cyfra przd napisem
to zwracana wartosc errorlevel:

0  bez bledow
   Haslo zapisano w pliku: <nazwa>.
1  ogolny blad parametrow
   Wyswietla info jak dla "/?"
2  parametr /L:nn poza zakresem
   Ilosc znakow hasla poza zakresem.
3  blad parametru /S
   Blad zestawu znakow. Oczekiwano: /s[:]<duls>
4  blad i/o pliku
   Blad operacji i/o na pliku.
5  brak indeksu
   Brak dostepnego indeksu dla domyslnej nazwy pliku.
6  zapis przerwano
   Plik jest obecny na dysku. Zastapic? [t/n] n
   Zapis do pliku przerwano.

Program w biezacej wersji zostal sprawdzony, poprawiony i ponownie
skompilowany (TASM) pod kontrola emulatora DOSBox 0.74-3

 IFILEIO.MAC

W kodzie zrodlowym wystepuja linie odwolujace sie do makr zawartych w pliku
ifileio.mac, ktorego nie ma w repozytorium. To sa makra wykonujace operacje
na plikach. Nazwy sa jednoznaczne, wiec nie powinno byc problemu z napisaniem
wlasnych lub zastapienie bezposrednio kodem.
