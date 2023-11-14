Timing events
==================================

Det finns två mycket hjälpsamma inbyggda funktioner som gör det möjligt för oss att utföra saker i ett interval eller efter en viss tid.

Båda eventen finns i Windowobjektet.

### setTimeout

För att utföra något efter en viss tid använder vi `setTimeout`.

```js
setTimeout(function () {
    console.log('Last')
}, 5000)

console.log('First')
```

Koden utanför timeouten kommer exekveras så ovan kod kommer skriva ut *First* först och *Last* efter fem sekunder. Om vi vill avbryta timeouten måste vi lägga den i en variabel och använda `clearTimeout`:

```js
const myTimeout = setTimeout(function () {
    console.log('Last')
}, 5000)

console.log('First')
clearTimeout(myTimeout)
```



### setInterval

Om vi istället vill upprepa något i ett vist interval använder vi `setInterval`. Vi kan med fördel lägga det i en variabel så vi kan avsluta upprepningen smidigt. Det passar ofta bra att samköra med setTimeout:

```js
function printDate () {
    const date = new Date()

    console.log(date.toLocaleTimeString())
}

const myInterval = setInterval(printDate, 1000)

setTimeout(function () {
    clearInterval(myInterval)
    console.log('Interval stopped.')
}, 5000)
```


Det finns ett [exempelprogram om timing events](../../example/timingEvents).
