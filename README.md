#  npcswitcher — Globalne przełączanie NPC i ruchu ulicznego (FiveM + ox_lib)

**npcswitcher** to nowoczesne narzędzie administracyjne dla serwerów FiveM, umożliwiające globalne włączanie i wyłączanie **NPC (pieszych)** oraz **ruchu ulicznego** poprzez prosty panel GUI oparty o `ox_lib`.

 Zmiany są **natychmiastowe** i widoczne dla wszystkich graczy na serwerze.

---

##  Funkcje

-  Interaktywne menu kontekstowe z ikonami i opisami (komenda: `/npcmenu`)
-  Globalny efekt — zmiany wpływają na wszystkich graczy (serwer-client sync)
-  Możliwość przełączania niezależnie NPC i ruchu
-  Powiadomienia na czacie w stylu `vclear` (`SYSTEM: NPC WYŁĄCZENI`)
-  Kompatybilny z `ox_lib` i QBCore/Qbox/vanilla

---

##  Instalacja

1. Upewnij się, że masz zainstalowane i uruchomione `ox_lib`
2. Wrzuc folder `npcswitcher` do katalogu `resources`  
3. W `server.cfg` dodaj:
   ```
   ensure ox_lib
   ensure un_npcswitcher
   ```

4. Upewnij się, że w pliku `fxmanifest.lua` znajduje się linia:
   ```lua
   lua54 'yes'
   ```

---

##  Użycie

W grze wpisz:

```
/npcmenu
```

Otworzy się panel z opcjami:
-  NPC: WŁĄCZENI / WYŁĄCZENI
-  Ruch uliczny: WŁĄCZONY / WYŁĄCZONY

Zmiany zastosują się do całego świata gry — także u innych graczy.

---

##  Zawartość zasobu

```
npcswitcher/
├── fxmanifest.lua
├── client.lua
└── server.lua
```

---
