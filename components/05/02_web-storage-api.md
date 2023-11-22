Web Storage API
==================================

JavaScript på klientsidan kan lagra data i webbläsaren åt oss. Datan lagras som strängar i nyckel/värde-par. Det är heller ingen data som skickas till någon server, utan den stannar i webbläsaren. Numer finns det hela applikationer som körs med hjälp av Web Storage.

Windowobjektet ger oss två sätt att lagra datan på: *sessionStorage* och *localStorage*.

Läs mer om [Web Storage på mdn](https://developer.mozilla.org/en-US/docs/Web/API/Web_Storage_API)



#### sessionStorage

När vi sparar i sessionen lagras datan så länge som webbläsaren är öppen, även under omladdningar. När webbläsaren eller fliken stängs ner raderas datan.



#### localStorage

I localStorage lagras datan under en längre tid och man kan bara ta bort datan via JavaScript eller en rensning av cachen eller lokalt lagrad data.



### Lagra/hämta/radera

Oavsett vilken mekanism vi använder för att lagra datan har vi tillgång till samma funktioner för att lagra eller hämta datan. Det är som sagt lagrat som strängar i nyckel/värde-par så vi kan jobba med datan på två sätt:

```js
// Set items
window.localStorage.setItem('name', 'Murphy')
window.localStorage.profession = `Stormtrooper`

// Get items
const name = window.localStorage.getItem('name')
const profession = window.localStorage.profession
```

Vi kan se att det finns två funktioner som hjälper oss men vi kan även peta på det med nyckel/värde.

Behöver vi radera datan finns även där en funktion till hjälp:

```js
let myStore = window.localStorage

myStore.setItem('tomato', "45")

// Clears all data from storage
myStore.clear()
```

Du kan se ett exempel på Web Storage i [exempelmappen](../../example/webstorage).
