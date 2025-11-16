# game

Dieses Repository enthält ein minimales Godot 2D-Beispielprojekt.

Schnellstart:

- Projekt öffnen: Öffne `godot_project/project.godot` in Godot (empfohlen Godot 4).
- Im Editor `MainMenu.tscn` öffnen oder das Projekt starten.

Steuerung:

- Bewegung: WASD oder Pfeiltasten

Projektstruktur (wichtigste Dateien):

- `godot_project/MainMenu.tscn` - Hauptmenü mit `Start`, `Options`, `Ende`.
- `godot_project/Menu.gd` - Menü-Handler (wechsel zu `Level1.tscn`).
- `godot_project/Level1.tscn` - Erste Ebene; zeichnet 4 Räume (2x2) und instanziert den Player.
- `godot_project/Level1.gd` - zeichnet die Räume.
- `godot_project/Player.tscn` / `Player.gd` - Spielerrechteck + WASD-Bewegung.

Aktualisiert für Räume & Türen:

- Räume sind jetzt einzelne Szenen: `godot_project/rooms/Room1.tscn` .. `Room4.tscn`.
- `godot_project/Door.gd` - Area2D-basiertes Tür-Objekt; Türen melden Raumwechsel an `Level1.gd`.
- `godot_project/Level1.tscn` / `Level1.gd` - Level-Manager: lädt Räume, verbindet Türen und positioniert den persistenten `Player`.
- `Player.tscn` enthält jetzt `CharacterBody2D`, `CollisionShape2D` und `Camera2D`.

Spieltest:

1. Öffne `godot_project/project.godot` in Godot.
2. Öffne `MainMenu.tscn` und drücke `Play` oder starte das Projekt.
3. Wähle `Start` im Menü: das Level (Room1) wird geladen; mit WASD/Pfeiltasten bewegen.
4. Geh zu einer Tür (rechte oder untere Seite) — beim Betreten wechselt das Spiel in den Zielraum.

Hinweis: `Options` ist weiterhin ein Platzhalter.

Neue Features:

- Kamera-Limits: Die Kamera bleibt innerhalb des aktuellen Raums.
- Fade-Übergänge: Räume wechseln mit kurzem Fade-Out/Fade-In.
- Tür-Visuals: Türen zeigen offen/geschlossen (grün/rot). Du kannst Türen per Script öffnen/close/toggle.
- SFX: Kurzer Piepton beim Raumwechsel (procedural, keine externen Dateien nötig).
- Save/Checkpoint: Drücke `F5` um zu speichern, `F9` um zu laden (speichert `user://save_game.cfg`).

Hinweis zur Anpassung:
- Räume haben aktuell feste Größe `320x180`. Um Größen pro Raum anzugeben, kannst du in einer Raum-Szene eine Methode `get_room_rect()` implementieren und `Level1.gd` wird diese verwenden.

Hinweis: Dies ist ein minimales Beispiel; Assets und komplexere Physik fehlen bewusst.