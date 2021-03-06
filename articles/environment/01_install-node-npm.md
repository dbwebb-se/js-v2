Installera Node.js och npm
===================================

![Nodejs logo](../img/nodejs-logo.png)

Vi skall installera en miljö för JavaScript. Det handlar om Node.js och pakethanteraren npm. Vi ska installera LTS versionen av Node.js, vilket står för Long Term Support och är oftast lite stabilare.

Miljön innebär att du kan köra JavaScript på din dator och du kan ta del av alla de program och paket som erbjuds via pakethanteraren npm.



<!--more-->



Läs mer
-------------------------------

Du kan läsa mer om [Node.js på webbplatsen](https://nodejs.org/).

Du kan läsa mer om [npm på webbplatsen](https://www.npmjs.com/). Där kan du också söka efter de paket som finns publicerade.



Förutsättning
-------------------------------

Du kör Windows, macOS eller en linuxdistribution, du är bekant med terminalen och hur man installerar program.



Installera på Windows (Cygwin, cmd)
-------------------------------

Gå till [nedladdningssidan för Node](https://nodejs.org/en/download/). Ladda ned installationsprogrammet för LTS och installera.

Programmen node och npm läggs till i din PATH automatiskt.

Du kan nu starta programmen från windows-terminalen `cmd` eller ifrån Cygwin. Men starta om din terminal så att den får del av den uppdaterade pathen.



Installera på Windows 10 WSL Debian/Bash
-------------------------------

Även om du har installerat Node på din Windows-maskin, och du använder WSL, så behöver du installera Node/npm i din klient i WSL. Du har då två installationer av Node, en i Windows och en i ditt WSL.

Olika linux-varianter har olika sätt att installera node och npm. Följ instruktionerna på [nedladdningssidan för olika pakethanterare](https://nodejs.org/en/download/package-manager/). Det kan finnas vissa förberedelser som behövs för att du skall kunna installera den senaste versionen, det handlar om vilket repo som apt-get använder för att hämta installationsfilern från. Kolla nedladdningssidan för att vara säker.

Sist jag installerade på WSL Debian/GNU Linux (oktober 2021) så var instruktionen enligt följande.

Först hämtar jag installationsprogrammet, så att pakethanteraren vet vad som skall installeras. Jag behöver vara root när detta görs. Kör

```text
# Using Debian, as root
$ sudo bash
$ curl -sL https://deb.nodesource.com/setup_lts.x | bash -
$ apt install -y nodejs
```

Nu är det installerat. Jag kan nu logga ut som root (`$ exit`) och fortsätta som min vanliga användare.

Jag får eventuellt uppdatera sökvägen, så mitt shell hittar de nyligen installerade binärerna.

```console
$ hash -r
```



Installera på Mac OS
-------------------------------

Gå till [nedladdningssidan för Node](https://nodejs.org/en/download/). Ladda ned installationsprogrammet (LTS) och installera.

Du kan nu starta programmet `node` från din terminal.



Installera på Linux
-------------------------------

Olika linux-varianter har olika sätt att installera node och npm. Följ instruktionerna på [nedladdningssidan för olika pakethanterare](https://nodejs.org/en/download/package-manager/). Det kan finnas vissa förberedelser som behövs för att du skall kunna installera den senaste versionen, det handlar om vilket repo som apt-get använder för att hämta installationsfilern från. Kolla nedladdningssidan för att vara säker.

Sist jag installerade på Debian 11 (oktober 2021) så var instruktionen enligt följande.

```console
# installera programmet Curl om det behövs
$ sudo apt install curl

# Lägg till Node.js repository i Debian
$ curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Installera nodejs (och npm)
$ sudo apt install nodejs
```

Du kan nu starta programmet `node` från din terminal.



Verifiera node och npm
-------------------------------

Nu är programmen installerade och redo. Verifiera att både node och npm fungerar enligt följande:

```console
$ node --version
v16.11.1
$ npm --version
6.14.15
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

**NOTERING:** För att få upp prompten i cygwin skall node köras i _interactive mode_. Detta gör du genom att använda kommandot `node -i`.

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



Avslutningsvis
------------------------------

Se till så installationen av node och npm är på sin plats innan du går vidare.
