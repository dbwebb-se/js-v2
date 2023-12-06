# Uppgift - "Intelligenstest"

Du har blivit kontaktad av ett företag som mäter intelligens, de vill ha din hjälp att skapa ett testverktyg för att räkna ut hur intelligent en person är. Det handlar om att en testperson skall utföra ett antal övningar och det sammanlagda resultatet från övningarna blir intelligensen hos testpersonen.

Du är tveksam till deras affärsidé, men du accepterar uppdraget som innebär att du skall bygga ett par mindre program som du sätter samman till ett större test-program. Det handlar om JavaScript (HTML, CSS), och det är ju din grej. Du tänker efter och det känns som du har en hel del kod som du kan återanvända.

# Projektspecifikation

Utveckla och leverera projektet enligt specifikationen från kunden (se längre ned i dokumentet). Saknas info i specen så kan du själv välja väg, dokumentera dina val i redovisningstexten.

De tre första kraven är obligatoriska och måste lösas för att få godkänt på uppgiften. De tre sista kraven samt genererad dokumentation är optionella krav. Lös de optionella kraven för att samla poäng och därmed nå högre betyg.

Varje grundkrav ger max 10 poäng (30).
Varje optionellt krav ger max 15 poäng (30).
Totalt är det 60 poäng.

Exempel 1: Deltest 1, 2 och 3 är grundkrav. Deltest 4 och 5 blir optionella.
Exempel 2: Deltest 1, 2 och 4 är grundkrav. Deltest 3 och 5 blir optionella.
Exempel 3: Deltest 1, 2 och 5 är grundkrav. Deltest 3 och 4 blir optionella.

### Deltest 1, 2, 3: Grunden

Enligt specifikationen från kunden (se nedan) -- gör ett komplett testverktyg som består av:

1. Deltest 1, 2 och minst ett av deltesten 3, 4 eller 5.
2. Genererad dokumentation. Dubbelkolla så den finns publicerad och strukturerad så det går att se vilken dokumentation som hör till projektet.
3. All kod ska validera.

Spara filerna i katalogen `public/`.

Strukturera din kod i en eller flera ES moduler. Fundera igenom hur du vill strukturera innan du börjar.

Varje del-test skall kunna nollställas och startas om. Det är en fusk-funktion som låter användaren göra om del-testet för att få bättre resultat. Det ska gå att köra `window.reset()` i konsolen i webbläsaren för att starta om deltestet.


### Deltest 4, 5, 6: Optionellt

Välj att göra ett eller två ytterligare deltester. Välj de som du ännu inte gjort av deltest 3, 4 och 5.

Varje deltest är här värt 15 poäng styck. Totalt 30 poäng.

## Specification från kunden

Så här är tanken att testverktyget skall fungera. Det är en halvt flummig specifikation från kunden, men du gör ditt bästa för att tolka den. Du har ju trots allt en hel del koll på hur man löser sådana här saker.

### Idé om testverktyget

Testpersonen öppnar webbsidan i sin webbläsare. Det kommer upp ett välkomstmeddelande som hälsar välkommen till testverktyget och förklarar idén och vad som skall göras. När testpersonen är klar så skall hen klicka på en länk för att starta testet.

Hela testet skall köras i en enda HTML-sida, utan omladdningar. Varje test skall alltså dynamiskt bygga om sidans innehåll.

### Deltest 1: Tipsfrågor

Första delen av testet är valfritt antal 1X2-frågor. Som en tipspromenad. Frågan visas upp i webbsidan. Testpersonen svarar på frågan (genom att till exempel klicka på svarsalternativen) och får därefter direkt se det rätta svaret. Sedan kan testpersonen välja att gå vidare till nästa fråga.

Du väljer att ta med minst 5 tipsfrågor, bara för att visa hur det fungerar. Frågorna och svaren ska läsas in från en JSON-fil så det enkelt går att uppdatera dem.

Testpersonen samlar poäng i varje deltest. Här är förslaget att rätt svar ger tre poäng per fråga och fel ger 0 poäng.

### Deltest 2: Fizzbuzz

På detta testet så visar du upp en sekvens av spelet [FizzBuzz](https://en.wikipedia.org/wiki/Fizz_buzz). Testpersonen skall gissa på nästa siffra i sekvensen genom att klicka på en av flera alternativa svar (länkar eller knappar).

När testpersonen klickat på svaret så visas det rätta svaret tillsammans med en länk till nästa test.

Rätt klick ger tre poäng och fel ger 0 poäng.

Startvärdet för FizzBuzz-sekvensens skall slumpas fram så det inte är samma varje gång.

Exempel på en fizzbuzz serie:

```console
buzz, 11, fizz, 13, 14, fizz buzz, ?
```

Tips: modulus operator

### Deltest 3: Minne (optionellt)

Detta är ett litet minnes-test som kollar hur bra bildminne man har.

Testpersonen kommer till testet och får en förklarande text. Därefter klickar man på en länk för att starta testet.

Testet börjar med att 9 bilder visas under 5 sekunder. Därefter döljs de. Du visar nu upp en numrerad lista med namnen på de nio bilderna. Testpersonen skall nu klicka på rätt ruta där motsvarande bild ligger, i rätt ordning. När testpersonen gissar så skall bilden vändas upp.

Du behöver inte ha nio olika bilder, du kan återanvända dem så att samma bild förekommer flera gånger, dock max 3 gånger per bild.

Testpersonen får fortsätta så länge hen gissar rätt. När alla bilderna visas så är testet över, eller när testpersonen gissar fel.

Rätt klick ger ett poäng styck.

Efter avklarat test kan testpersonen klicka på en länk för att gå vidare till nästa test.

### Deltest 4: Visuell förmåga och läsförståelse (optionellt)

Detta testet kombinerar läsförståelse med visuell förmåga.

Testet börjar med en text som förklarar vad det går ut på. Sedan klickar testpersonen på en länk för att starta testet.

Testet innebär att du skall rita ut 10 unika objekt. Objekt kan vara en kvadrat, en cirkel, en triangel eller en rektangel. Objektet har en färg. Samtidigt får testpersonen en numrerad lista med 10 alternativ som säger i vilken ordning som de olika objekten skall klickas på. Så här kan alternativen i listan se ut.

1. Den röda cirkeln.
2. Den vita trekanten.
3. Den svarta cirkeln.

Testpersonen måste klicka på rätt objekt i rätt ordning. Om hen klickar fel, så fortsätter testet med nästa alternativ på listan.

Rätt klick ger ett poäng och fel ger 0 poäng.

Testet sker under tidspress. Testet skall utföras på max 15 sekunder. Därefter visas resultatet och en länk som tar testpersonen vidare till nästa test.

### Deltest 5: Uppfattningsförmåga (optionellt)

Testet börjar med en text som förklarar vad det går ut på. Det finns en länk som spelaren kan klicka på för att starta testet.

I testet visas ett objekt under 1 sekund. Testpersonen skall välja att klicka på objektet eller ej. När objektet försvinner så är det en paus på en sekund, sedan visas nästa objekt. Allt som allt visas tio objekt. Objekten är samma som i övningen ovan.

Testpersonen skall få instruktioner att klicka på alla objekt som:

1. Har en annan färg än röd.
2. Har en annan form än kvadrat...
3. ...eller är röd och kvadrat.

Man ska till exempel **inte** klicka på en gul kvadrat eller en röd cirkel men man ska klicka på en röd kvadrat.

Rätt klick ger +1 poäng och fel ger -1 poäng.

När testet är klart så visas resultatet tillsammans med en länk till nästa test.


### Formel för att beräkna intelligensen

Den är så hemlig så att du inte får se den. Kunden har bett dig att göra en egen formel så länge, du väljer att göra så här.

- Varje fråga/övning ger poäng.
- Total max intelligens är x (du väljer själv) poäng.

Specen innehåller grova förslag till poängsättningen, men du kan justera den precis som du vill.

### Slutet

När testet är slut så visas en siffra upp som motsvarar intelligensen, tillsammans med siffran för maximal intelligens.


### Validering

Se till så koden validerar:

```console
$ cd me
$ npm run eslint --what=kmom10
$ npm run htmlhint --what=kmom10
$ npm run stylelint --what=kmom10
```

### Generera JSDoc

Strukturera dokumentationen likt exemplet i [artikeln om jsdoc](../02/04_jsdoc.md).

```console
$ cd me
$ npm run jsdoc --what=public
```

### Publicering

Publicera koden:

```console
$ cd me
$ dbwebb publish public
```
