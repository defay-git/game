## Kurzanleitung für AI-Codieragenten (Projekt: Godot 2D game)

Zweck: Dieses Repo enthält ein minimales Godot-4 2D-Spiel mit Menü, persistentem Player und einer ersten Ebene aus 4 separaten Raum-Szenen (2x2). Ziel: KI-Agenten schnell produktiv machen.

Wichtige Dateien:

- `godot_project/project.godot` — Godot-Projektdatei.
- `godot_project/MainMenu.tscn`, `godot_project/Menu.gd` — Hauptmenü (Start/Options/Ende).
- `godot_project/Level1.tscn`, `godot_project/Level1.gd` — Level-Manager: lädt Räume, verbindet Türen, positioniert Player und HUD.
- `godot_project/Player.tscn`, `godot_project/Player.gd` — Spieler-Node (`CharacterBody2D`) mit `Camera2D` (Smoothing), Kollision und Movement.
- `godot_project/rooms/Room1.tscn` .. `Room4.tscn` — separate Raumszenen mit Wänden und `Area2D`-Türen.
- `godot_project/Door.gd` — Tür-`Area2D`-Script: `target_scene_path`, `spawn_position`, `open()/close()/toggle()` und visuelle Animationen.
- `godot_project/Transition.gd` — Fade-In/Out beim Raumwechsel.
- `godot_project/Sfx.gd` — einfacher Audio-Generator für kurze Feedback-Töne.
- `godot_project/SaveManager.gd` — Speichern/Laden (`user://save_game.cfg`).

Architektur & Datenfluss:

- `MainMenu` lädt `Level1.tscn` (Start). `Level1` instanziiert einen persistenten `Player` und einen `RoomContainer`.
- Beim Laden einer Room-Szene positioniert `Level1` den Player an `spawn_position`, setzt Kamera-Limits und verbindet alle `Door`-Signale.
- `Door.gd` emittiert `request_room_change(target_scene_path, spawn_position)` beim Betreten (nur wenn `is_open`). `Level1` reagiert und lädt das Ziel mit Fade und SFX.

Projekt-spezifische Konventionen:

- Räume: `godot_project/rooms/` — Szenen sind eigenständig; Verknüpfung über `Door.target_scene_path` (res://-Pfad).
- Player ist persistent innerhalb `Level1.tscn` (Räume ersetzen sich selbst; Player bleibt erhalten).
- Raumgröße: Standard `320x180`. Räume können optional `get_room_rect()` implementieren, damit `Level1` korrekte Kamera-Limits setzt.
- Save-Datei: `user://save_game.cfg` (F5 speichert, F9 lädt).

Developer-Workflows:

- Öffnen: Starte Godot 4 und öffne `godot_project/project.godot`.
- Ausführen: Öffne `MainMenu.tscn` und klicke Play (oder setze `MainMenu.tscn` als Hauptszene).
- Debugging: Nutze `print()` im Script, den Remote Scene Tree und die Editor-Konsole.

Änderungen & Best Practices für Agenten:

- Räume erweitern: Bei Änderungen an Raumlayout immer `Door.target_scene_path` und `spawn_position` prüfen.
- Neue Assets: Lege sie unter `godot_project/assets/` ab und referenziere mit `res://godot_project/assets/...`.
- Tests: Manuelles Testen im Editor reicht derzeit; es gibt keine automatisierten Tests.

Beispiele (konkrete Patterns):

- Tür-Signal: `Door.gd` emittiert `request_room_change(target_scene_path, spawn_position)` — `Level1.gd` verbindet daraufhin `_on_request_room_change`.
- Kamera-Limits: `Level1.gd` ruft `player.set_camera_limits(Rect2)` auf; implementiere `get_room_rect()` in der Room-Szene, um abweichende Größen zu liefern.

Wenn etwas fehlt oder du möchtest, dass ich Coding-Richtlinien, Linting oder CI-Schritte hinzufüge (z. B. `gdformat`), sag mir welche Tools du bevorzugst — ich ergänze die Datei.

Ende
