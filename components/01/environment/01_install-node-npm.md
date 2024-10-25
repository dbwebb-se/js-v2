Installera Node.js och npm
===================================

![Nodejs logo](../../img/nodejs-logo.png)

Vi skall installera en miljö för JavaScript. Det handlar om Node.js och pakethanteraren npm. Vi ska installera LTS versionen av Node.js, vilket står för Long Term Support och är en mer stabil version.

Miljön innebär att du kan köra JavaScript på din dator och du kan ta del av alla de program och paket som erbjuds via pakethanteraren npm.



<!--more-->



Läs mer
-------------------------------

Du kan läsa mer om [Node.js på webbplatsen](https://nodejs.org/).

Du kan läsa mer om [npm på webbplatsen](https://www.npmjs.com/). Där kan du också söka efter de paket som finns publicerade.



Förutsättning
-------------------------------

Du kör Windows, macOS eller en linuxdistribution, du är bekant med terminalen och hur man installerar program.



<!-- Installera på Windows (Cygwin, cmd)
-------------------------------

Gå till [nedladdningssidan för Node](https://nodejs.org/en/download/). Ladda ned installationsprogrammet för LTS och installera.

Programmen node och npm läggs till i din PATH automatiskt.

Du kan nu starta programmen från windows-terminalen `cmd` eller ifrån Cygwin. Men starta om din terminal så att den får del av den uppdaterade pathen. -->



Installera på Windows 10/11 WSL Debian/Ubuntu/Bash
-------------------------------

Även om du har installerat Node på din Windows-maskin, och du använder WSL, så behöver du installera Node/npm i din klient i WSL. Du har då två installationer av Node, en i Windows och en i ditt WSL. Avinstallera Nodejs i Windows, då det har en förmåga att krocka med installationen i WSL.

Olika linux-varianter har olika sätt att installera node och npm. Följ instruktionerna på [nedladdningssidan för olika pakethanterare](https://nodejs.org/en/download/package-manager/). Det kan finnas vissa förberedelser som behövs för att du skall kunna installera den senaste versionen, det handlar om vilket repo som apt-get använder för att hämta installationsfilern från. Kolla nedladdningssidan för att vara säker.



### Installera med nvm

Vi kan installera node och npm på flera sätt. En vanig metod för att installera Nodejs är att använda "nvm" (node version manager). Vi börjar med att installera programmet cURL, som används för att hämta filer från internet via terminalen. Det är säkerligen redan installerat hos dig.

```console
$ sudo apt install curl
```

Sedan kan vi hämta och installera nvm med följande kommando:

```console
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```

Lista tillgängliga versioner:

```console
$ nvm ls
# flera versioner listas
```

Installera senaste LTS versionen:

```console
$ nvm install --lts
# I skrivande stund är det v20.18.0
```

Nu kan du se de installerade versionerna med `$ nvm ls`.

Vi kan även använda nvm för att skifta mellan installerade versioner men det är inget vi behöver göra i kursen.



### Installera med snap

[INFO]
OBS! Om du installerat Nodejs via nvm behöver du inte installera det igen. Hoppa då över detta steg.
[/INFO]

Sist jag installerade på WSL Ubuntu-22.04 (Oktober 2023) använde jag pakethanteraren `snap`. Om man har en senare version av Ubuntu, tex 22.04 så finns det förinstallerat. Vi kan se vilka varianter som finns att välja mellan:

```console
$ snap info node
# Lite info...
channels:
  18/stable:        18.18.0                        2023-09-18 (7823) 33MB classic
  18/candidate:     ↑
  18/beta:          ↑
  18/edge:          ↑
  latest/stable:    –
  latest/candidate: –
  latest/beta:      –
  latest/edge:      21.0.0-nightly20231017ea595ebb 2023-10-17 (7875) 36MB classic
  20/stable:        20.8.0                         2023-09-29 (7844) 34MB classic
  20/candidate:     ↑
  20/beta:          ↑
  20/edge:          ↑
  19/stable:        19.9.0                         2023-04-11 (7382) 33MB classic
```

Vi kan se att version 20 finns som stabil version så den tar vi. 

```console
$ sudo snap install node --classic --channel=20
```

`--channel=20` talar om att det är den versionen vi vill ha. Skulle vi vilja byta gör vi det enkelt med: `$ sudo snap refresh node --channel=18` för version 18.



Installera på Mac OS
-------------------------------

Gå till [nedladdningssidan för Node](https://nodejs.org/en/download/). Ladda ned installationsprogrammet (LTS) och installera.

Du kan nu starta programmet `node` från din terminal.



Verifiera node och npm
-------------------------------

Nu är programmen installerade och redo. Verifiera att både node och npm fungerar enligt följande:

```console
$ node --version
v20.18.0
$ npm --version
10.8.2
```



Verifiera att Node.js fungerar
-------------------------------

Du kan nu köra JavaScript med node. Pröva följande.

```console
$ node --help
$ node --eval "console.log('Hello World')"
Hello World
```

Du kan också köra node interaktivt och evaluera JavaScript rad för rad. Programmet visar att den är redo för inmatning med prompten `>`.

<!-- **NOTERING:** För att få upp prompten i cygwin skall node köras i _interactive mode_. Detta gör du genom att använda kommandot `node -i`. -->

```console
$ node
> console.log("Hej")
Hej
>
```
<!--
För att få upp prompten i cygwin skall node köras i _interactive mode_. Detta gör du genom att använda kommandot `node -i`.

Så här kan det se ut.

[ASCIINEMA src=91267] -->

Du kan också låta nodejs köra JavaScript-program som finns i filer.

```console
$ echo "console.log('Hello')" > hello.js
$ node hello.js
Hello
```

Man kan jobba med inkommande argument på följande sätt:

args.js
```js
let arg = process.argv[2]

console.log(`You entered: ${arg}`)
```

```console
$ node args.js kaktus
You entered: kaktus
```



Avslutningsvis
------------------------------

Se till så installationen av node och npm är på sin plats innan du går vidare.
