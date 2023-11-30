Objekt-literalen
==================================

Objekt är en samling av namngivna värden som vanligen kallas "properties" (egenskaper). För att referera till ett objekts egenskap används punkt. I andra programmeringsspråk kan du se konstruktionen som en dictionary (Python) eller associativ array (php).

Man kan skapa ett objekt med objekt-literalen `{}`. Vi kan antingen lägga till properties direkt och/eller vid ett senare tillfälle. Häng gärna med i programmeringen och koda lite själv.

```js
let myObject = {
    height: 0,
    width: 0
}

console.log(myObject.height) // 0
console.log(myObject.width)  // 0
```

Objektet innehåller nu två egenskaper, `height` och `width` som ska representera storleken på objektet. Vi kan även lägga till egenskaper efterhand:

```js
myObject.background = ""
```

Objekt i JavaScript är så kallt *mutable* vilket betyder att man kan ändra på det under resans gång. Det är både bra och dåligt. Om vi skulle råka stava fel på egenskapen så skapas det en ny egenskap istället för att ge ett felmeddelande att egenskapen inte finns:

```js
console.log(myObject.backGround) // prints undefined
```

Ett objekt kan även innehålla andra objekt. Vi skapar om objektet och kikar på hur vi kan ändra ovan kod och placera height och width i ett eget objekt:

```js
let myObject = {
    size: {
        h: 0,
        w: 0
    },
    background: ""
}
```

Vi kan nu nå storleken med `myObject.size.h` respektive `myObject.size.w`.



### Objekt och `this`

Vad sägs om en metod `init()` för att initiera vårt objekt med värden? Vi kallar det *metoder* när funktioner är kopplade till ett objekt.


Objekt-literalen har ingen [konstruktor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/constructor), utan för att se till så varje objekt blir sitt egna kan vi använda `Object.create()` som använder sig av urmoder-objektet *Object* och skapar en ny instans av vårt egna objekt. Men innan vi löser det behöver vi kunna definiera objektets egenskaper. Vi lägger till en metod för att sätta objektets storlek och bakgrundsfärg:

```js
let myObject = {
    size: {
        h: 0,
        w: 0
    },
    background: "",
    init: function(height, width, background) {
        this.size = {
            h: height,
            w: width
        }
        this.background = background
    },
}

let greenBox = Object.create(myObject) // Create an instance of the object
greenBox.init(100, 100, "green") // Initiate the newly created object with some values
```

När man exekverar en metod eller vill nå instansens egenskaper i ett objekt kan man använda [`this`](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Operators/this) för att referera till det objekt som anropade metoden/egenskapen. Vi behöver "skapa om" objektet `size` då JavaScript använder sig av referenser och vi vill ha en ny storlek på alla våra objekt.

Nu behöver vi få ut objektet till webbläsaren. Det finns som alltid olika sätt att lösa det på. Vi har våra värden i objektet. Till detta skapar vi en metod, `draw()`, som hjälper oss:

```js
let content = document.getElementsByClassName("content")[0]
let myObj = {
    size: {
        h: 100,
        w: 200
    },
    background: "",
    init: function(height, width, background) {
        this.size = {
            h: height,
            w: width
        }
        this.background = background
    },
    draw: function() {
        let element = document.createElement("div")
        element.style.position = "absolute"
        element.style.margin = "5px"
        element.style.height = this.size.h + "px"
        element.style.width = this.size.w + "px"
        element.style.backgroundColor = this.background
        content.appendChild(element)
    }
}
```

Vi kan nu skapa några objekt och rita ut dem:

```js
// Objektet skapas ovan

let obj1 = Object.create(myObj)
let obj2 = Object.create(myObj)
let obj3 = Object.create(myObj)

obj2.init(100, 250, "red")
obj3.init(65, 147, "yellow")
obj1.init(25, 54, "green")

obj1.draw()
obj2.draw()
obj3.draw()
```

En fördel med att ha en metod som ritar ut dem är att vi kan lägga objekten i en array och loopa igenom den:

```js
// Objektet skapas ovan

let obj1 = Object.create(myObj)
let obj2 = Object.create(myObj)
let obj3 = Object.create(myObj)

obj1.init(25, 54, "green")
obj2.init(100, 250, "red")
obj3.init(65, 147, "yellow")

let allObjects = [obj1, obj2, obj3]

for (let i = 0 i < allObjects.length i++) {
    allObjects[i].draw()
}
```



# Resultat

Om vi nu tittar på resultatet kan vi se de olika formerna vi skapat.

![Former skapade med objekt.](../img/obj-create.png)
