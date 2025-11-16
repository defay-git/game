extends Node

const PATH := "user://settings.cfg"

func set_language(lang: String) -> void:
    var cfg = ConfigFile.new()
    cfg.load(PATH)
    cfg.set_value("prefs", "language", lang)
    cfg.save(PATH)

func get_language() -> String:
    var cfg = ConfigFile.new()
    var err = cfg.load(PATH)
    if err != OK:
        return "de"
    return str(cfg.get_value("prefs", "language", "de"))

func set_volume(vol: int) -> void:
    var cfg = ConfigFile.new()
    cfg.load(PATH)
    cfg.set_value("prefs", "volume", vol)
    cfg.save(PATH)

func get_volume() -> int:
    var cfg = ConfigFile.new()
    var err = cfg.load(PATH)
    if err != OK:
        return 80
    return int(cfg.get_value("prefs", "volume", 80))

func set_resolution(res: String) -> void:
    var cfg = ConfigFile.new()
    cfg.load(PATH)
    cfg.set_value("prefs", "resolution", res)
    cfg.save(PATH)

func get_resolution() -> String:
    var cfg = ConfigFile.new()
    var err = cfg.load(PATH)
    if err != OK:
        return "1280,720"
    return str(cfg.get_value("prefs", "resolution", "1280,720"))
