# Uppgift - "Hangman"

Nu är det dags att koda ihop ett spel. Det är ett välkänt spel, "Hänga gubben". Om man inte vet hur det går till kan man kika på [reglerna](https://www.wikihow.com/Play-Hangman).

Du jobbar i mappen `public/`.

### Förutsättning

Det förutsätts att du gått igenom artiklarna för [kursmoment 06](.) samt är det en fördel om du gjort tidigare kursmoment. De ger dig koll på hur vi börjar jobba med JavaScript, webbläsaren och de tekniker du behöver känna till.

### Intro

Det är som sagt "hangman" som gäller. Till din hjälp har du en grundstruktur att utgå ifrån. Här är grunden ett objekt som använder sig utav "revealing pattern". Du ska utgå ifrån den kodbasen och skapa ett fungerande spel utifrån vissa krav. Börja med att kopiera in filerna och skapa de relevanta delarna:

```console
# Ställ dig i kursmappen
$ mkdir me/public/data
$ mkdir me/public/modules/kmom06
$ cp example/hangman/words.json me/public/data/
$ cp example/hangman/index.html me/public/kmom06.html
$ cp example/hangman/hangman.js me/public/js/modules/kmom06/
```

### Krav

1. Använd filerna du kopierade och skapa en bra grundstruktur. Lägg till din navbar och se till så menyvalet "kmom06" även finns med. Skapa även filen `js/kmom06.js`, vilken du ska läsa in i `public/kmom06.html`.
1. Skapa bokstäverna som du kan klicka på, du kan bara klicka på en bokstav en gång. Då skall den ändra style och inte gå att klicka på längre.
1. Uppdatera file `data/words.json` med egna ord.
1. Skapa en funktion `Hangman.wordlist()` som exporteras och skriver ut hela ordlistan i consolen. Använd fetch med async/await.
1. Skapa en funktion som slumpar fram ett ord från ordlistan. Detta blir det aktiva ordet. Skapa en funktion `Hangman.peek()` som exporteras, det skall returnera det aktiva ordet.
1. När spelaren klickar på en bokstav så kontrollerar du om bokstaven finns i ordet. Om bokstaven inte finns så ritar du ut en del av bilden. Rita ut ordet med en kombination av `_` för icke gissade bokstäver och de gissade bokstäverna på sina rätta platser.
1. När (om) alla delar är utritade så visar du ett meddelande om “Game Over” på spelplanen, eller motsvarande. Det går nu inte att göra några fler gissningar.
1. När (om) spelaren har gissat alla bokstäver i ordet så skriver du ut “You Won The Game!” på spelplanen, eller motsvarande. Det går nu inte att göra några fler gissningar.
1. Ladda om sidan för att köra ett nytt spel.
1. Fundera på vilka delar som behöver vara publika eller privata och gör aktiva val av hur du strukturerar koden.

Tips: När det rättas kommer det kopieras in en ny fil `words.json` som används. Se till så koden skrivs generell och inte låst till era egna ord.


### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=public
$ npm run stylelint --what=public
$ npm run htmlhint --what=public
```


### Generera JSDoc

Strukturera gärna dokumentationen likt exemplet i [artikeln om jsdoc](../02/04_jsdoc.md).

```console
$ cd me
$ npm run jsdoc --what=public
```

### Publicera

Vid det här laget kan vi proceduren.

```console
$ dbwebb publish public
```


### Avslutningsvis

Lycka till och hör av dig om du kör fast eller har några funderingar.
