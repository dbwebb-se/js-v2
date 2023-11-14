Radera element
==================================

För att radera element kan vi använda funktionen `Node.removeChild()` eller helt enkelt `element.remove()`. Node i detta fallet är föräldern till elementet som ska tas bort. Vi tittar på ett exempel där vi tar bort det elementet vi klickar på.

Vi utgår ifrån vår [sandbox](../../example/sandbox).

```js
const myContent = document.getElementById('content')

myContent.innerHTML = '<h3>This is a template!</h3>'

myContent.addEventListener('click', function (event) {
    const clickedElement = event.target

    // using removeChild()
    clickedElement.parentNode.removeChild(clickedElement)

    // using remove()
    clickedElement.remove()
})
```
