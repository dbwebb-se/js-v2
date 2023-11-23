Async/Await
==================================

Vi ska inte gå på djupet med Promises i den här kursen, utan vi håller det på en hög nivå. Vi såg i artikeln om [fetch-api](./03_fetch-api.md) att vi kan använda `.then()` för att hamna i ett läge i koden där vi har inväntat svar från något funktionsanrop.

Vi kan antingen skapa egna så kallade "Promises", eller i vissa fall använda de som redan finns inbyggda i diverse funktionsanrop, som tex fetch(). För att se hur vi kan skapa egna kan du kika i [exempelmappen](./../../example/promise/). Kortfattat så ger ett Promise ett löfte om att något kommer returneras. Det är där then() kommer in i bilden.

Vi kan göra det på ett annat sätt, med hjälp av *async/await*. Vi kikar på ett exempel där vi ska hämta en fil:

```js
let data = await fetch(`https://url-to-a-file.json`)
let json = await data.json()

// Här har du tillgång till datan
```

Vi kan nu skriva koden på ett enligt många, behändigare sätt som är enklare att följa och strukturera, utan att fastna i någon form av callback hell: .then().then().then(). Kravet är bara att funktionen returnerar ett Promise.


Läs mer om [async på MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function).

Läs mer om [await på MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/await).
