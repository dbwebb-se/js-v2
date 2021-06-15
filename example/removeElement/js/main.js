(function () {
    'use strict'

    const myContent = document.getElementById('content')

    myContent.innerHTML = '<h3>This is a template!</h3>'

    myContent.addEventListener('click', function () {
        const clickedElement = event.target

        clickedElement.parentNode.removeChild(clickedElement)
    })

    window.console.log('Sandbox is ready!')
})()
