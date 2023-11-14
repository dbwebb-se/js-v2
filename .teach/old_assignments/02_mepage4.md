# Uppgift - "Me page 4"

Jobba vidare med me-sidan och lägg till lite mer JavaScript.

Nu är det dags att få saker att röra sig på me-sidan. Vi ska lägga till en form som man kan styra med hjälp av piltangenterna.

## Krav

1. Skapa menyvalet "kmom04".

1. Skapa en figur som ska kunna flyttas runt på skärmen under ditt nya menyval. Figuren kan tex vara en bild eller en liten fyrkant, välj själv.

1. Tangenterna som ska styra figuren är piltangenterna.

1. Skriv om vad du gjort under ett eget stycke i redovisningstexten.

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

Om du har tid och kraft.

1. Se till så din figur inte kan gå utanför content (eller en annan instängd area).
