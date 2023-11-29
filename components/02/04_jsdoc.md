# JSDoc

Ett bra tips när man skriver kod är att dokumentera den. Det är dels för ens egna del men även för andra som eventuellt kan komma att behöva jobba med koden. För en själv kan det handla om att man kommer tillbaka till kod man skrivit tidigare och behöver friska upp minnet. För andra kan det helt enkelt handla om att man behöver sätta sig in i koden och förstå den. I JavaScript kan vi använda ett verktyg som automatiskt genererar dokumentation utefter våra kommentarer.

### JSDoc i kursen

I den här kursen används verktyget JSDoc för dokumenteringen av koden. vi har den kopplad till eslint så vi får varningar när vi itne kommenterad koden korrekt. Det är bra så vi blir lite uppstyrda.

### Komma igång med JSDoc

Vi genererar dokumentationen i terminalen med hjälp av `npm`. Filen som heter `package.json` är redan förberedd på att använda JSDoc. Vi tittar i package.json igen och ser följande rad:

```json
"scripts": {
    ...
    "jsdoc": "npx jsdoc -c .jsdoc.json -d $npm_config_what/jsdoc $npm_config_what/* || exit 0",
},
```

Vad är det som händer där då? Vi kan se två stycken så kallade "options": `-c` och `-d`. Med -c kan vi definiera en egen configfil som vi har i exempelmappen.

Med -d kan vi ange en mapp där dokumentationen ska hamna. Om vi inte sätter den själva kommer det skapas en mapp `out` där vi är för tillfället.

Vidare nyttjar vi möjligheten till att ta emot variabler i vårt script för att underlätta hanteringen. `$npm_config_what` kommer innehålla det vi skickar med som `--what=kmom02`. Vi kör alltså till exempel detta kommando när vi står i me-mappen: `npm run jsdoc --what=kmom02`. Det kommer "översättas" till: `./node_modules/.bin/jsdoc -c jsdoc.json -d kmom02/jsdoc kmom02/*`. Stjärnan (`*`) är ett wildcard som i detta fallet betyder "alla js-filer i mappen".

När vi genererar filerna kommer det skapas en mapp som heter `jsdoc` i den mappen som vi vill skapa dokumentation för. Där i finner vi bland annat en `index.html` som vi öppnar i webbläsaren och får se den genererade dokumentationen.

### Hur gör man då?

För att JSDoc ska förstå vad som händer i koden måste vi kommentera den. Det finns en uppsättning regler för hur kommentarerna bör se ut för att följa standarden.

Här följer ett exempel på några kommentarer:

```js
/**
 * A function that sums numbers.
 * @param {number} num1 The first number to use.
 * @param {number} num2 The second number to use.
 * @returns {number} The calculated result.
 */
function addNumbers (num1, num2) {
  return num1 + num2
}

addNumbers(30, 12)
```

Vi börjar med en kort beskrivning över vad funktionen gör. `@param` beskriver som väntat vilka parametrar funktionen vill ha, vilken datatyp {number} samt ett namn och en beskrivning. Slutligen kan vi använda `@returns` för att beskriva returvärde. Även där sätter vi datatypen. JSDoc är ganska känslig för grammatik så meningar behöver börja med stor bokstav och sluta med punkt.


### Strukturera filer och moduler

När vi jobbar med olika filer och moduler kan det vara bara att separera den genererade dokumentationen så det blir överskådligt vilka funktioner som hör till vilken modul.

Vi kommer ha filerna i en struktur likt:

```console
js
│   ├── kmom02.js
│   ├── kmom03.js
│   ├── kmom04.js
│   ├── kmom05.js
│   ├── main.js
│   ├── modules
│   │   ├── kmom02
│   │   │   ├── animals.js
│   │   │   └── greeting.js
│   │   ├── kmom03
│   │   │   └── info.js
│   │   ├── kmom04
│   │   │   ├── helpers.js
│   │   │   ├── keyboardevents.js
│   │   │   └── mouseevents.js
```

Det kommer finnas fler filer och moduler när vi är klara med kursen. Jag tar kursmoment 04 som exempel här.

I startfilen (kmom04.js) skriver vi följande JSDoc kommentarer:

```js
/**
 * @namespace kmom04
 * @property {module:helpers} helpers
 * @property {module:keyboardevents} keyboardevents
 * @property {module:mouseevents} mouseevents
 */
```

Notera att varje modul vi använder i kursmomentet läggs till som en egen "property".

I respektive modul börjar vi följande:

```js
/**
 * @module helpers
 */
```

Då har modulerna en koppling till respektive *[namespace](https://jsdoc.app/tags-namespace)* och det blir snyggt och prydligt när dokumenationen genereras.



På sidan [jsdoc.app](https://jsdoc.app/index.html) kan vi se hur alla tänkbara konstruktioner ska se ut.
