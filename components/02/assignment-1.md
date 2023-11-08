# Uppgift - "Animals"

I den här uppgiften ska du skapa ett par moduler som exporterar fördefinierad funktionalitet.

Du jobbar i mappen `kmom02/`.

### Förutsättning

Det förutsätts att du gått igenom artiklarna för [kursmoment 02](.).

### Intro

Organisationen "Hållbara djur" vill att du hjälper dem med dokumentationen av utrotningshotade djur. De vill ha en uppsättning av något som tydligen kallas "ES moduler".

Den data du kan få är listor på några utrotningshotade djur i olika platser på jorden. Du hittar filen i exempelmappen som du börjar med att kopiera in i arbetsmappen:

```console
# Stå i kursmappens rot
$ cp example/animals/animals.js me/kmom02/
```

Du kan även se lite automatgenererad dokumentation över funktionaliteten i exempelmappen. Antingen öppnar ni [example/animals/jsdoc](../../example/animals/jsdoc/) lokalt i en webbläsare eller via [htmlpreview](https://htmlpreview.github.io/?https://raw.githubusercontent.com/dbwebb-se/js-v2/master/example/animals/jsdoc/global.html).

### Krav

1. Skapa en fil `kmom02/kmom02.js` som ska använda modulen och exportera en uppsättning funktioner.

2. Exportera funktionen `getAll` som returnerar samtliga djur i en array.

3. Exportera funktionen `getFrom` som ska ta ett argument, en sträng. Funktionen ska returnera en array med alla djur ifrån det inskickade argumentet. Man ska med andra ord kunna skicka in `america`, `africa` eller `europe`. Annars returneras en tom array.

4. Exportera funktionen `filterAnimals` som ska ta ett argument, en sträng. Funktionen ska returnera en array med alla djur som delvis består av det inskickade argumentet. Matchar inget returneras en tom array.

5. Exportera funktionen `whereLives` som ska ta ett argument, en sträng. Funktionen ska returnera en sträng med den kontinent djuret finns i ("Europe", "America" eller "Africa"). Matchar inget returneras "Unavailable".

6. Exportera funktionen `report` som returnerar en formatterad rapport likt nedan över alla djur och vilken kontinent de tillhör samt vilket index de finns på.

Exempel:
```console
// Fler tidigare
Africa: Hooded vulture (8)
Africa: Chimpanzee (9)
America: Florida panther (0)
America: Lesser prairie chicken (1)
America: Devil's Hole pupfish (2)
// Fler följer
```

7. När du är klar ska filen `kmom02.js` exportera följande funktioner: `export { getAll, getFrom, filterAnimals, whereLives, report }`

8. Generera JSDoc med scriptet `npm run jsdoc --what=kmom02`

Dubbelkolla så den stämmer.

### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=kmom02
```

### Enhetstester

För det här kursmomentet finns en testsuite som kontrollerar modulen.

```console
# Ställ dig i kursroten
$ cd me
$ cp ../example/animals/kmom02.test.js kmom02/
$ npm test --what=kmom02
```

Om allt går igenom är det bara att lämna in.

### Inlämning

Publicera koden enligt följande:

```console
$ cd me
$ dbwebb publish kmom02
```
<!--
### Hur kan det se ut när det är klart?

Nedan är en video som visar hur det kan se ut när det är klart:

[![js exercise kmom02](https://img.youtube.com/vi/EKFOlAsJDkE/0.jpg)](https://www.youtube.com/watch?v=EKFOlAsJDkE) -->

### Avslutningsvis

Lycka till och hör av dig om du kör fast eller har några funderingar.

<!-- [TBD: Länk till issues](#) -->
