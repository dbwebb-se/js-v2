# Uppgift - "Me page 5"

Jobba vidare med me-sidan och lägg till lite mer JavaScript.

Vi ska jobba lite med Web Storage och bygga till ett litet spel i me-sidan.

## Krav

1. Lägg till menyvalet "kmom05".

1. När man går in på länken ska ett spel startas med följande regler:

   1. Det ska finnas två knappar `Nytt spel` och `Kasta`.
   1. När man klickar på `kasta` ska det slumpas fram en siffra mellan och inklusive 1 och 6. Tänk en vanlig tärning.
   1. Spelaren får kasta en ny tärning så länge det inte blir en 1:a. Då avslutas spelet.
   1. För varje kast ska det nya värdet samt det totala värdet presenteras.
   1. Använd Web Storage (`sessionStorage`) för att spara den nödvändiga informationen vid eventuell omladdning av sidan.
   1. Klickar spelaren på `Nytt spel` ska omgången starta om och alla värden nollställas.

1. Skriv om hur det har gått under ett eget stycke i redovisningstexten.

1. Lägg till din redovisningstext i `redovisning.html`.

### Validering

Se till så koden validerar:

```console
$ cd me
# js
$ npm run linter redovisa/

# html/css
$ dbwebb validate redovisa
```

### Publicering

Glöm inte att publicera koden:

```console
$ cd me
$ dbwebb publish redovisa
```

## Extrauppgift

Det finns ingen extrauppgift den här veckan.
