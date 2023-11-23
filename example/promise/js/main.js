function promise1 () {
    return new Promise((resolve, reject) => {
        setTimeout(() => resolve('42'), 3000)
    })
}

function promise2 () {
    return new Promise((resolve, reject) => {
        setTimeout(() => resolve('done'), 2000)
    })
}

const promise3 = new Promise((resolve, reject) => {
    setTimeout(resolve, 100, "even me")
})

promise1().then((result) => console.log(result))

Promise.all([promise1(), promise2(), promise3]).then((results) => {
    console.log(results)
})
