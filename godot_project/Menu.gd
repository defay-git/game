extends Control

func _ready() -> void:
    # Connect buttons if present
    if has_node("ContinueButton"):
        $ContinueButton.pressed.connect(_on_continue_pressed)
    if has_node("NewGameButton"):
        $NewGameButton.pressed.connect(_on_newgame_pressed)
    if has_node("OptionsButton"):
        $OptionsButton.pressed.connect(_on_options_pressed)
    if has_node("QuitButton"):
        $QuitButton.pressed.connect(_on_quit_pressed)
    # Options panel connections
    if has_node("OptionsPanel"):
        if $OptionsPanel.has_node("OptVBox/OptClose"):
            $OptionsPanel/OptVBox/OptClose.pressed.connect(_on_close_options)
        if $OptionsPanel.has_node("OptVBox/LangOption"):
            $OptionsPanel/OptVBox/LangOption.connect("item_selected", Callable(self, "_on_lang_selected"))

    # Apply localization on menu load
    _apply_localization()

func _on_continue_pressed() -> void:
    # Write start mode to user:// so Level1 can decide to load save
    var cfg = ConfigFile.new()
    cfg.set_value("start", "use_save", true)
    cfg.save("user://start_mode.cfg")
    get_tree().change_scene_to_file("res://godot_project/Level1.tscn")

func _on_newgame_pressed() -> void:
    var cfg = ConfigFile.new()
    cfg.set_value("start", "use_save", false)
    cfg.save("user://start_mode.cfg")
    get_tree().change_scene_to_file("res://godot_project/Level1.tscn")

func _on_options_pressed() -> void:
    if has_node("OptionsPanel"):
        $OptionsPanel.visible = true
        # set current selection from settings
        var settings = preload("res://godot_project/Settings.gd").new()
        var lang = settings.get_language()
        var idx = 0
        if lang == "de":
            idx = 0
        else:
            idx = 1
        $OptionsPanel/OptVBox/LangOption.select(idx)

func _on_close_options() -> void:
    if has_node("OptionsPanel"):
        $OptionsPanel.visible = false

func _on_lang_selected(index: int) -> void:
    var lang = (index == 0) ? "de" : "en"
    var settings = preload("res://godot_project/Settings.gd").new()
    settings.set_language(lang)
    _apply_localization()

func _apply_localization() -> void:
    var loc = preload("res://godot_project/Localization.gd").new()
    if has_node("ContinueButton"):
        $ContinueButton.text = loc.translate("continue")
    if has_node("NewGameButton"):
        $NewGameButton.text = loc.translate("new_game")
    if has_node("OptionsButton"):
        $OptionsButton.text = loc.translate("options")
    if has_node("QuitButton"):
        $QuitButton.text = loc.translate("quit")
    # Options panel labels
    if has_node("OptionsPanel/OptVBox/LangLabel"):
        $OptionsPanel/OptVBox/LangLabel.text = loc.translate("language")
    if has_node("OptionsPanel/OptVBox/OptClose"):
        $OptionsPanel/OptVBox/OptClose.text = loc.translate("close")

func _on_quit_pressed() -> void:
    get_tree().quit()
