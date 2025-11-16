extends Node2D

var current_room: Node = null
var current_room_path: String = ""
onready var room_container := $RoomContainer
onready var player := $Player
onready var transition := $Transition
onready var hud_label := $HUD/RoomLabel
onready var sfx := $Sfx
var save_manager := null

func _ready() -> void:
    # SaveManager is a script-only helper; instantiate and keep in scene
    save_manager = preload("res://godot_project/SaveManager.gd").new()
    add_child(save_manager)
    load_room("res://godot_project/rooms/Room1.tscn", Vector2(160, 90))

func _input(event):
    if event is InputEventKey and event.pressed:
        # F5 save, F9 load
        if event.scancode == Key.F5:
            _save_game()
        elif event.scancode == Key.F9:
            _load_game()

func _save_game() -> void:
    if save_manager:
        save_manager.save_game(current_room_path, player.position)
        print("Game saved")

func _load_game() -> void:
    if not save_manager:
        return
    var data = save_manager.load_game()
    if data.has("room") and data["room"] != "":
        load_room(data["room"], data["pos"])
        print("Game loaded")

func load_room(path: String, player_spawn: Vector2) -> void:
    # fade out, load, then fade in
    await transition.fade_out()

    # remove existing room
    for c in room_container.get_children():
        c.queue_free()

    var res = ResourceLoader.load(path)
    if not res:
        push_error("Failed to load room: %s" % path)
        await transition.fade_in()
        return

    var room = res.instantiate()
    room_container.add_child(room)
    current_room = room
    current_room_path = path

    # position player
    player.position = player_spawn

    # set camera limits (room assumed to be 320x180 unless room provides rect)
    var room_rect = Rect2(Vector2.ZERO, Vector2(320, 180))
    # if room provides `room_size` export, use it
    if room.has_method("get_room_rect"):
        room_rect = room.get_room_rect()
    player.set_camera_limits(room_rect)

    # update HUD
    if hud_label:
        hud_label.text = path.get_file()

    # connect doors inside the room
    _connect_doors_recursive(room)

    # play SFX
    if sfx and sfx.has_method("play_beep"):
        sfx.play_beep()

    await transition.fade_in()

func _connect_doors_recursive(node: Node) -> void:
    for child in node.get_children():
        if child is Area2D and child.get_script() and String(child.get_script().get_path()).ends_with("Door.gd"):
            # ensure connected only once
            if not child.is_connected("request_room_change", Callable(self, "_on_request_room_change")):
                child.connect("request_room_change", Callable(self, "_on_request_room_change"))
        _connect_doors_recursive(child)

func _on_request_room_change(target_path: String, spawn_pos: Vector2) -> void:
    load_room(target_path, spawn_pos)
