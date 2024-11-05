# Uppgift - "Me page 2"

Jobba vidare med me-sidan och utöka med moduler. Här behöver vi använda attributet `type="module"` i htmlfilen och se den via en webbserver.



## Förkunskaper

Du har gjort en första version av [me-sidan](../instructions_01/assignment.md) och har koll på dess struktur.



## Krav

Kopiera in relevanta moduler från exempelmappen:

```console
# stå i kursroten
$ mkdir -p me/public/js/modules/kmom02
$ cp example/animals/animals.js me/public/js/modules/kmom02/
```

1. Lägg till menyvalet "kmom02" som ska länka till filen `kmom02.html`.

2. Läs där in scriptet `js/kmom02.js`.

3. Använd modulen via `js/kmom02.js` och skriv ut ett slumpmässigt djur från varje kontinent i valfritt htmlelement. Vid sidomladdning ska det slumpas ut nya djur.

4. Skapa en modul `modules/kmom02/greeting.js`. Där exporterar du en funktion som returnerar "God förmiddag" eller "God eftermiddag" beroende på om klockan är före eller efter `12.00`. Använd modulen i `kmom02.js` och skriv ut resultatet i valfritt htmlelement på din sida.

5. Generera JSDoc med scriptet `npm run jsdoc --what=public`. Från och med nu kommer vi bygga upp fler moduler som vi använder i me-sidan. Se till så det genereras snyggt och prydligt likt [artikeln](./04_jsdoc.md#strukturera-filer-och-moduler) visar.

6. Kör `dbwebb test kmom02` för att se så att filerna ligger på rätt plats.

```console
$ dbwebb test kmom02
```

### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=public
$ npm run stylelint --what=public
$ npm run htmlhint --what=public
```

### Inlämning

Publicera koden enligt följande:

```console
$ cd me
$ dbwebb publish public
```



## Extrauppgift

Om du har tid och kraft.

1. Lägg extra kraft på CSS och styla din me-sida så den blir mer personlig.
