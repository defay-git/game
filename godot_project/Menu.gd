extends Control

func _ready() -> void:
    # Connect buttons if present
    if has_node("StartButton"):
        $StartButton.pressed.connect(_on_start_pressed)
    if has_node("OptionsButton"):
        $OptionsButton.pressed.connect(_on_options_pressed)
    if has_node("QuitButton"):
        $QuitButton.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://godot_project/Level1.tscn")

func _on_options_pressed() -> void:
    # Minimal placeholder for options
    print("Options pressed - implement settings here")

func _on_quit_pressed() -> void:
    get_tree().quit()
