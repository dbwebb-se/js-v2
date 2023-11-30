# Uppgift - "Hangman"

Nu är det dags att koda ihop ett spel. Det är ett välkänt spel, "Hänga gubben". Om man inte vet hur det går till kan man kika på [reglerna](https://www.wikihow.com/Play-Hangman).

Du jobbar i mappen `public/`.

### Förutsättning

Det förutsätts att du gått igenom artiklarna för [kursmoment 06](.) samt är det en fördel om du gjort tidigare kursmoment. De ger dig koll på hur vi börjar jobba med JavaScript, webbläsaren och de tekniker du behöver känna till.

### Intro

Det är som sagt "hangman" som gäller. Till din hjälp har du en grundstruktur att utgå ifrån. Här är grunden ett objekt som använder sig utav "revealing pattern". Du ska utgå ifrån den kodbasen och skapa ett fungerande spel utifrån vissa krav. Börja med att kopiera in filerna:

```console
# Ställ dig i kursmappen
$ cp -r example/hangman/* me/kmom06/
```

### Krav

1. Använd filerna du kopierade och skapa en bra grundstruktur.
1. Skapa bokstäverna som du kan klicka på, du kan bara klicka på en bokstav en gång. Då skall den ändra style och inte gå att klicka på.
1. Skapa en ordlista (minst fem ord) som en del av din Hangman-modul. Skapa en funktion `Hangman.wordlist()` som exporteras och skriver ut hela ordlistan i consolen.
1. Skapa en funktion som slumpar fram ett ord från ordlistan. Detta blir det aktiva ordet. Skapa en funktion `Hangman.peek()` som exporteras, det skall returnera det aktiva ordet.
1. När spelaren klickar på en bokstav så kontrollerar du om bokstaven finns i ordet. Om bokstaven inte finns så ritar du ut en del av bilden. Rita ut ordet med en kombination av `_` för icke gissade bokstäver och de gissade bokstäverna på sina rätta platser.
1. När (om) alla delar är utritade så visar du ett meddelande om “Game Over” på spelplanen, eller motsvarande. Det går nu inte att göra några fler gissningar.
1. När (om) spelaren har gissat alla bokstäver i ordet så skriver du ut “You Won The Game!” på spelplanen, eller motsvarande. Det går nu inte att göra några fler gissningar.
1. Ladda om sidan för att köra ett nytt spel.
1. Fundera på vilka delar som behöver vara publika eller privata och gör aktiva val av hur du strukturerar koden.
1. Kommentera din kod enligt JSDoc och generera dokumentationen:

```console
$ cd me
$ npm run jsdoc --kmom=kmom06
```

### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run linter kmom06/
```

### Webpack

Packa ihop koden innan publicering:

```console
$ npm run build --kmom=kmom06
```


### Avslutningsvis

Lycka till och hör av dig om du kör fast eller har några funderingar.
