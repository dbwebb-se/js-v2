let maxHeight = window.innerHeight
let maxWidth = window.innerWidth
let backgroundImage = null
let gameObj = {
  duck: {
    size: {
      h: "100px",
      w: "100px"
    }
  },
  getNewPos: function() {
    let newX = Math.floor(Math.random() * (maxWidth - parseInt(this.duck.size.w) / 2))
    let newY = Math.floor(Math.random() * (maxHeight - parseInt(this.duck.size.h) / 2))
    
    return {x: newX, y: newY}
  },
  start: function() {
    let pos = this.getNewPos()
    let duckEl = document.createElement("img")
    duckEl.src = this.duck.url
    duckEl.style.height = this.duck.size.h
    duckEl.style.width = this.duck.size.w
    duckEl.style.position = "absolute"
    duckEl.style.top = pos.y + "px"
    duckEl.style.left = pos.x + "px"
    console.log(pos.y, pos.x)
    this.area.appendChild(duckEl)
  }
}


async function getBackground() {
  document.body.innerHTML = "<h1>Please wait...</h1>"
  let temp = await fetch(`https://raw.githubusercontent.com/webtec-2024/teacher/refs/heads/main/kmom06/backgrounds/1.jpg`)
  let blob = await temp.blob()
  backgroundImage = URL.createObjectURL(blob)

  document.body.style.backgroundImage = `url(${backgroundImage})`
  document.body.style.backgroundSize = "cover"
  document.body.style.backgroundRepeat = "no-repeat"
  document.body.style.backgroundPosition = "center"
  document.body.style.height = "100vh"
  document.body.style.width = "100vw"

  document.body.innerHTML = ""
}

async function getDuck() {
  let temp = await fetch(`https://raw.githubusercontent.com/webtec-2024/teacher/refs/heads/main/kmom06/duck/duck.png`)
  let blob = await temp.blob()
  gameObj.duck.url = URL.createObjectURL(blob)
}

async function startGame() {
  await getBackground()
  await getDuck()
  gameObj.start()
}

async function setupGame() {
  gameObj.area = document.body

  await startGame()

  console.log(gameObj)
}


setupGame()