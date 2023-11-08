# Uppgift - "Rainbow"

I den här uppgiften ska du skapa former i olika färger och arbeta med DOM-trädet och dess funktionalitet.

Du bygger vidare på din sida i `public/`.

### Förutsättning

Det förutsätts att du gått igenom artiklarna för [kursmoment 03](.). De ger dig koll på hur vi börjar jobba med JavaScript och webbläsaren.

### Intro

Nu börjar fler få upp ögonen för ditt sinne för programmering och nästa jobb väntar! Rörelsen "eQuality" behöver en dynamisk webbsida där användaren kan interagera med innehållet. Användaren ska kunna klicka på former och få se namnen på några av historiens största förkämpar för mänskliga rättigheter.

De kan ge dig en start att utgå ifrån och av någon anledning har de lagt filen i exempelmappen. Mycket märkligt, tänker du, men det är bara att kopiera in den och köra:

```console
# Ställ dig i kursroten
$ mkdir -p me/public/js/modules/kmom03
$ cp example/rainbow/info.js me/public/js/modules/kmom03/
$ cp example/rainbow/logo.png me/public/img/
```

Kikar vi i info.js ser vi att det är en modul som exporterar tre arrayer, `colors`, `persons` och `years`. Det gäller nu att använda dem och snickra ihop en sida som uppfyller kraven nedan.

### Krav

1. Lägg till menyvalet "kmom03" som ska länka till filen `kmom03.html`.
1. Läs där in scriptet `js/kmom03.js` som i sin tur använder `modules/kmom03/info.js`.
1. Börja med en tom sida med en knapp i mitten.
1. Varje gång man klickar på knappen ska en form ritas ut med korrekt bakgrundsfärg. Färgerna finns i ordning i arrayen `colors`.
1. Knappen ska visa vilken form i ordningen som kommer näst. När alla former är framme, tas knappen bort.
1. När man klickar på knappen ska det även läggas till en eventlyssnare som lägger till en ram runt formen när muspekaren är på elementet. När man för musen utanför ska ramen försvinna.
1. När man klickar på en form ska respektive namn och år skrivas ut tillsammans med bilden `logo.png`. Namn och år finns i `info.js` och bilden finns i mappen `img/`.
1. Utöver dessa krav vill de se hur dina vingar bär. Utmana dig själv och lägg gärna till mer funktionalitet. Skapar du fler moduler lägger du dem i mappen `modules/kmom3/`.
1. Kommentera din kod enligt JSDoc och generera dokumentationen:

```console
$ cd me
$ npm run jsdoc --what=public
```

### Extra uppgift (Optionell)

1. Kan du lägga till en eventlyssnare som gör att man kan "vända tillbaka" korten?

<!-- 1. Du kanske till och med kan göra ett memoryspel av korten? Om du väljer detta krav så kan du anpassa grundkraven efter ditt memoryspel. Du kan tex ändra hur eventlyssnarna fungerar och knappen kan tas bort. Du ska dock använda informationen ifrån arrayerna. -->

### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=public
$ npm run stylelint --what=public
$ npm run htmlhnt --what=public
```

### Avslutningsvis

Lycka till och hör av dig om du kör fast eller har några funderingar.
