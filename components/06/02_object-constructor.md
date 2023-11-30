Constructor
==================================

En "konstruktor" är enbart en funktion som hjälper oss att initiera flera objekt från samma bas. Vi tar föregående kod och gör om det till en konstruktor-funktion.

```js
function MyObj(size, background) {
    this.size = size
    this.background = background
    this.draw = function() {
        let element = document.createElement("div")
        element.style.margin = "5px"
        element.style.height = this.size.h + "px"
        element.style.width = this.size.w + "px"
        element.style.backgroundColor = this.background
        document.getElementsByClassName("content")[0].appendChild(element)
    }
}

let obj1 = new MyObj({h: 25, w: 54}, "green")
let obj2 = new MyObj({h: 100, w: 250}, "red")
let obj3 = new MyObj({h: 65, w: 147}, "yellow")

let allObjects = [obj1, obj2, obj3]

for (let i = 0 i < allObjects.length i++) {
    allObjects[i].draw()
}
```

När vi har en konstruktor använder vi nyckelordet `new` samt en stor bokstav i objektets namn.

Resultatet ser ut som i förra artikeln.
