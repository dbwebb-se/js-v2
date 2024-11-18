Radera element
==================================

Vi kan även radera html-element i JavaScript. Det görs med den inbyggda funktionen `removeElement`. 

I JavaScript finns en inbyggd metod `remove()`:

```js
const myElement = document.getElementById('box')
myElement.remove() // Removes the element
```

Ett annat sätt är att använda parent/child förhållandet mellan elementen och metoden `removeChild`. Låt säga att elementet `#box` ligger i en DIV med id `parent`:

```js
const myParent = document.getElementById('parent')
const box = document.getElementById('box')
myParent.removeChild(box) // Removes the child element
```

Man kan även ta andra "vägar" genom till exempel `parentNode`:

```js
const box = document.getElementById('box')
box.parentNode.removeChild(box) // Removes the child element
```

Återigen, det finns många fler sätt att hantera elementen, även att radera dem.
