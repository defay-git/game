extends Node

var _strings := {
    "en": {
        "continue": "Continue",
        "new_game": "New Game",
        "options": "Options",
        "quit": "Quit",
        "room_prefix": "Room: ",
        "language": "Language",
        "close": "Close"
    },
    "de": {
        "continue": "Fortsetzen",
        "new_game": "Neues Spiel",
        "options": "Optionen",
        "quit": "Ende",
        "room_prefix": "Raum: ",
        "language": "Sprache",
        "close": "Schließen"
    }
}

onready var settings := preload("res://godot_project/Settings.gd").new()

func translate(key: String) -> String:
    var lang = settings.get_language()
    if not _strings.has(lang):
        lang = "de"
    var map = _strings[lang]
    if map.has(key):
        return map[key]
    return key
