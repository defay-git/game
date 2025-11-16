extends Node

const SAVE_PATH := "user://save_game.cfg"

func save_game(room_path: String, player_pos: Vector2) -> void:
    var cfg = ConfigFile.new()
    cfg.set_value("game", "room", room_path)
    cfg.set_value("game", "player_x", player_pos.x)
    cfg.set_value("game", "player_y", player_pos.y)
    var err = cfg.save(SAVE_PATH)
    if err != OK:
        push_error("Failed to save game: %s" % err)

func load_game() -> Dictionary:
    var cfg = ConfigFile.new()
    var err = cfg.load(SAVE_PATH)
    if err != OK:
        return {}
    var room = cfg.get_value("game", "room", "")
    var x = cfg.get_value("game", "player_x", 0)
    var y = cfg.get_value("game", "player_y", 0)
    return {"room": room, "pos": Vector2(x, y)}
