const incBtn = document.getElementById('inc')
const decBtn = document.getElementById('dec')
const clearBtn = document.getElementById('clear')
const result = document.getElementById('result')

result.innerHTML = parseInt(sessionStorage.getItem('value')) || 0

function dumpStorage () {
    console.log(sessionStorage)
}

function increaseValue () {
    const old = parseInt(result.innerHTML)

    result.innerHTML = old + 1
}

function decreaseValue () {
    const old = parseInt(result.innerHTML)

    result.innerHTML = old - 1
}

incBtn.addEventListener('click', increaseValue)

decBtn.addEventListener('click', decreaseValue)

clearBtn.addEventListener('click', function () {
    sessionStorage.clear()
    dumpStorage()
    result.innerHTML = 0
})

window.addEventListener('unload', function () {
    sessionStorage.setItem('value', result.innerHTML)
})

dumpStorage()
window.console.log('Sandbox is ready!')
