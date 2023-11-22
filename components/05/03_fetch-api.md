Fetch API
==================================

Ett verkligt trivsamt API är *fetch*. Vi kan med hjälp av det hämta filer och data från servrar via http-protokollet. JavaScript på klientsidan har ingen möjlighet att hämta data lokalt från hårddisken av diverse säkerhetsskäl.

När vi använder fetch behöver vi ett enda argument, viket är den url:en som datan finns tillgänglig på. Vi får tillbaka ett så kallat *Promise* - ett löfte om att vi kommer få tillbaka något, men inte när. När datan är laddad och vi kan jobba med den blir förfrågan (*Request*) löst (*Resolve*). Det är delar vi tar i senare kurser, men för stunden behöver vi ta reda på hur vi jobbar med den typen av funktionalitet.

Du kan se hur det fungerar i [exempelmappen](../../example/fetch). Det mest intressanta är själva requestet:

```js
fetch(`https://url-to-a-file`)
    .then(response => response.json())
    .then(function (json) {
        console.log(json)
    })

console.log('I get printed before the data...')
```

Om vi jämför med till exempel `setTimeout` så vet vi att all kod kommer exekveras vid inläsning och då behöver ju datan finnas. Vi kan vänta på ett Promise och jobba med datan med hjälp av funktionen `.then()`. Koden däri kommer exekveras vid rätt tillfälle, när datan är klar. Det kommer vara viktigt för uppgiften i detta kursmoment att ha koll på. Vill du se mer om Promise finns det i [exempelmappen](../../example/promise).

Om vi tittar på koden ovan så i första delen: `.then(response => response.json())` så returneras datan konverterad till JSON. Vi fångar upp den när det är klart och vi hamnar i nästa del som här enbart skriver ut datan i consolen:

```js
.then(function (json) {
    console.log(json)
})
```


Läs mer om [fetch på MDN](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API).
