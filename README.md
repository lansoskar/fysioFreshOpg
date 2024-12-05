# kanban-vuetify ☀
Det her er designet til at være et simpelt kanban board. Projektet er deployed på vercel. Har ikke fået lavet nogen tests.

vercel link:
https://fysio-fresh-79xnq49jd-lansoskars-projects.vercel.app/

## Baggrund
Det her er første gang jeg sidder med vue og typescript, det har virkeligt været learn as you go i en kort periode, da tiden jeg har brugt har været lidt presset, da jeg har mandatory eksamens-opgaver at se til.

Jeg har lavet projekter med JavaScript, React og Java før, så det er ikke fordi jeg ikke har noget at referrer til undervejs. Jeg estimerer at have brugt i alt ~16 timer på den her opgave henover et par eftermiddage og aftener.
## Tilgang
Lige så snart jeg ser kravene til opgaven begynder jeg at tænker over hvor meget jeg skal bryde det ned i components og struktur. 
  
Siden at det skal være et kanbanboard tænkte jeg at der mindst kommer til at være 3 components:  
- selve boardet der indeholder koloner  
- kolonerne der skal holde cards  
- cards med issues / tasks. 
  
I KanbanBoard.vue component er der en modal der displayer card data når man trykker på et card, dette kunne nok separeres ind i et component for sig selv.
  
Draggable funktioner af cards mellem kolonner er lavet med HTML Drag and Drop API.

Jeg har ikke implementeret nogen tests, men hvis jeg skulle ville jeg starte med nogen unit tests af om funktioner fungerer som forventet, ellers ville jeg teste om props og emits bliver handlet ordentligt.