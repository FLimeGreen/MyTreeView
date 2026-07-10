# MyTreeView

## Projekt Idee 
Ein shell-script das mir eine Ordnerstruktur im Terminal anzeigt und dem ich besondere Befehle beibringen kann.

## Kompilieren
For dem ersten mal starten muss das Projekt kompiliert werden.
Entweder man führt ./compile.sh aus um zu bild und run zumachen.
Oder man fürt ./build.sh aus und dann ./mytree.sh

## Requierments

| Software      | Kürzel        | Zweck          |
|---------------|---------------|----------------|
| Neovim        | nvim          | open Editor im aktuellen Ordner  |
| Fuzzy Finder  | fzf           | Unterordner weite Suche um Ordenr / Dateien zu finden  |

## To DO 

### Allgemein
- [x] Option für . und .. Anzeigen oder nicht

### Command Interface
- [ ] c für manuelle Comand eingabe
- [ ] <R> für ausführen einzelner Dateien

### Datei System Operationen
- [ ] Dateien erstellen.
- [ ] Dateien umbennen.
- [ ] Dateien löschen.

 Weiß nicht ob das zu stark ist...
- [ ] Ordner erstellen
- [ ] Ordner umbennen
- [ ] Ordner löschen

## Tasten Kombinationen
| Taste      | Aktion                                                   |
|------------|----------------------------------------------------------|
| ↑ / k      | Zeile hoch                                               |
| ↓ / j      | Zeile runter                                             |
| → / l      | Verzeichnis öffnen                                       |
| ← / h      | Verzeichnis hoch (cd ..)                                 |
| n          | Neovim öffnen                                            |
| s          | Verzeichnisse durchsuchen (fzf)                          |
| S          | Verzeichnisse und Dateien durchsuchen (fzf)              |
| o          | Sortierung umschalten (Ordner zuerst an/aus)             |
| r          | Gespeicherten Befehl für aktuelles Verzeichnis ausführen |
| Strg+R     | Befehl für aktuelles Verzeichnis setzen / löschen        |
| Strg+Y     | Config Editor öffnen                                     |
| ESC        | Programm beenden                                         |
