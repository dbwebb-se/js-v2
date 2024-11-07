Uppgift - "Basics"
==================================

Skapa några scriptfiler där du använder några vanliga konstruktioner i JavaScript.


Förkunskaper
-----------------------

Du har installerat kursens labbmiljö samt installerat kommandot `dbwebb` och du har clonat kursrepot för kursen.



Introduktion
-----------------------

Du ska skapa en uppsättning scriptfiler som var för sig utför olika uppgifter. Alla filer ska jobba med inkommande argument via `process.argv`. Du kan se hur man går tillväga i [exempelmappen](../../example/node). Du kan räkna med att användaren skickar in rätt datatyp.


Krav
-----------------------

Jobba i mappen `me/kmom01` och skapa där följande script som löser respektive uppgift. `<arg>` ska bytas ut mot det inskickade argumentet.

1. Skapa filen `if-numbers.js`. Skapa if-satser som vid exekvering (`$ node if-numbers.js <arg>`) gör följande kontroller och utskrifter:
  * Om argumentet är lägre än 10: `<arg> är lägre än 10.`.
  * Om argumentet är högre än eller lika med 100: `<arg> är högre än eller lika med 100.`.
  * Om argumentet är högre än 10 och lägre än 20: `<arg> är mellan 10 och 20.`.
  * Om argumentet är ett jämt tal: `<arg> är ett jämt tal.`.
  * Om argumentet är ett udda tal: `<arg> är ett udda tal.`.
  * Om argumentet är 42: `Meaning of life.`.

Exempel:

```console
$ node if-numbers.js 2
2 är lägre än 10.
2 är ett jämt tal.

$ node if-numbers.js 13
13 är mellan 10 och 20.
13 är ett udda tal.

$ node if-numbers.js 100
100 är högre än eller lika med 100.
100 är ett jämt tal.

$ node if-numbers.js 42
42 är ett jämt tal.
Meaning of life.
```

2. Skapa filen `forloop.js`. Vid exekvering (`$ node forloop.js <arg1> <arg2>`) ska följande krav lösas med hjälp av forloopar och if-satser:
  * Gör en kontroll om `<arg1>` är mindre, större eller samma som `<arg2>`.
  * Om de inte är samma, skriv ut alla värden från `<arg1>` till och med `<arg2>`.
  * Om `<arg1>` är samma som `<arg2>` och de är 10 eller högre, skriv ut varannat värde ner till 0.

Exempel:

```console
$ node forloop.js 4 10
4
5
6
7
8
9
10

$ node forloop.js 100 96
100
99
98
97
96

$ node forloop.js 12 12
12
10
8
6
4
2
0
```

4. Kör `dbwebb test kmom01` för att se så allt validerar och att filerna ligger på rätt plats.

```console
$ dbwebb test kmom01
```

5. Se till så koden validerar:

```console
$ npm run eslint --what=kmom01
```

6. Publicera koden på studentservern:

```console
$ dbwebb publish kmom01
```

> **_GLÖM INTE:_** Vill du köra en enskild validering kan du göra det med: `$ npm run {eslint,htmlhint,stylelint} --what=<folder>`
