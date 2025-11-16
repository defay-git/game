extends Node

const PATH := "user://settings.cfg"

func set_language(lang: String) -> void:
    var cfg = ConfigFile.new()
    cfg.set_value("prefs", "language", lang)
    cfg.save(PATH)

func get_language() -> String:
    var cfg = ConfigFile.new()
    var err = cfg.load(PATH)
    if err != OK:
        return "de" # default to German
    return str(cfg.get_value("prefs", "language", "de"))
