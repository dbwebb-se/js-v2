# Uppgift - "CO2 Emission"

I den här uppgiften ska vi använda data utifrån. Datan hämtas via http-protokollet med hjälp av fetch och vi ska använda datan för att populera en tabell.

Du jobbar i mappen `public/`.

### Förutsättning

Det förutsätts att du gått igenom artiklarna för [kursmoment 05](.) samt är det en fördel om du gjort tidigare kursmoment. De ger dig koll på hur vi börjar jobba med JavaScript och webbläsaren.

### Intro

Uppdragen rullar in och näst på tur står organisationen "Carbonara". Det är ett nystartat företag som vill belysa länders utsläpp av koldioxid. Som ett första steg vill de använda och jämföra data för länderna Sverige, Norge och Danmark. De saknar dock den tekniska kompetensen och det är där du kommer in i bilden.

Som av en händelse har de hittat data de vill att du använder från "[Our World In Data (owid)](https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions)".

I din exempelmapp finns [tre filer](../../example/co2-json) med färdigextraherad data. Då det inte går att hämta filerna lokalt så tänker du att du använder addressen till filerna i exempelmappen via github: `https://raw.githubusercontent.com/dbwebb-se/js-v2/master/example/co2-json/<filename>.json` där &lt;filename&gt; byts ut mot landet du vill hämta.

Datan innehåller en hel del nycklar och värden och du kan se en lista på dem i [owid's gitrepo](https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv).

Bra. Då har du nog allt du behöver för att gå igenom kraven.

### Krav

1. Skapa filerna `kmom05.html`, `js/kmom05.js` samt mappen `js/modules/kmom05`. I mappen lägger du de moduler du skapar för kursmomentet.
2. Användaren ska via ett `select` element och en eventlyssnare kunna hämta data från alla filer.
3. Filerna ska hämtas med fetch API.
4. Använd async/await för att invänta datan.
5. Man ska bara kunna välja år mellan `1900` och `2019`.
6. Datan ska presenteras i en tabell med minst sex kolumner.
7. Välj ut minst tre värden som ska jämföras och vinnarens cell ska markeras, tex grön bakgrundsfärg.
8. Skapa en "highscorelista" med hjälp av SessionStorage. 
  * Spara undan vilket land som fick bäst resultat varje år man filterar på. 
  * Presentera datan på sidan. 
  * Datan ska vara kvar om man laddar om sidan.
  * Lägg till en knapp som rensar SessionStorage och laddar om sidan.

9. Fundera ut vilken funktionalitet som bör finnas i `kmom05.js` eller i moduler. När du är klar ska du ha minst en modul.
10. Kommentera din kod enligt JSDoc och generera dokumentationen:

```console
$ cd me
$ npm run jsdoc --what=public
```

### Extra uppgift (Optionell)

1. Ta med mer data i tabellen och lägg till i jämförelsen. Kanske kan man markera det land som "kom sist" varje år också?
2. Kanske lägga till en "loading gif" i stil med [den här](https://commons.wikimedia.org/wiki/File:Loading_icon.gif). Eller en annan. Välj själv.
<!-- 1. Implementera cachning av datan så du inte hämtar den mer än en gång. -->

### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=public
$ npm run stylelint --what=public
$ npm run htmlhint --what=public
```

### Avslutningsvis

Lycka till och hör av dig om du kör fast eller har några funderingar.
