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

- Kolejnosc wystapienia parametrow jest dowolna,
- biale znaki (space, tab) pomiedzy parametrami sa ignorowane,
- wielkosc liter jest dowolna.

 OPCJE DOMYSLNE

/D      - Brak.
/L[:]nn - nn=10 znakow.
/S[:]   - Domyslnie przyjmuje parametry: /S:dul - cyfry i litery duze, male
OutFile - _pwd__NN.txt, gdzie NN jest indeksem z przedzialu 00..99.
          Plik zostanie zapisany pod nazwa z pierwszym wolnym indeksem.
          W przypadku braku wolnego indeksu - blad.

 UWAGI

- Z zestawu znakow specjalnych wykluczono:
  /  slash,
  \  backslash,
  <  less than,
  >  greater than.

- Jesli juz podano opcje /S[:] to trzeba rowniez podac zestaw(y) znakow.

- Jezeli plik OutFile jest juz na dysku, uzytkownik zostanie o tym
  poinformowany z pytaniem o nadpisanie istniejacego pliku. Odpowiedzi
  standardowe: klawisz t - tak, n - nie.

 POWIADOMIENIA

Powiadomienia dotycza nastepujacych przypadkow - cyfra przd napisem
to wartosc errorlevel:

0  bez bledow
   PWDGEN: Haslo zapisano w pliku: <nazwa>.
1  ogolny blad sciezki
   PWDGEN: Wyswietla info jak dla "/?"
2  parametr /L:nn poza zakresem
   PWDGEN: Ilosc znakow hasla poza zakresem.
3  blad parametru /S
   PWDGEN: Blad zestawu znakow. Oczekiwano: /s[:]<duls>
4  blad i/o pliku
   PWDGEN: Blad i/o operacji na pliku.
5  brak indeksu
   PWDGEN: Brak dostepnego indeksu dla domyslnej nazwy pliku.
6  przerwano zapis do pliku
   PWDGEN: Plik jest obecny na dysku. Zastapic? [t/n] n
           Zapis do pliku przerwano.


Program zostal sprawdzony, poprawiony i ponownie skompilowany (TASM) pod
kontrola emulatora DOSBox 0.74-3

 IFILEIO.MAC

W kodzie zrodlowym wystepuja linie odwolujace sie do makr zawartych w pliku
ifileio.mac, ktorego nie ma w repozytorium. To sa makra wykonujace operacje
na plikach. Nazwy sa jednoznaczne, wiec nie powinno byc problemu z napisaniem
wlasnych lub zastapienie bezposrednio kodem.
