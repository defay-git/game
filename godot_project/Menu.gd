extends Control

var _localization: Node
var _settings: Node

func _ready() -> void:
    _localization = preload("res://godot_project/Localization.gd").new()
    _settings = preload("res://godot_project/Settings.gd").new()
    
    # Connect buttons
    if has_node("VBox/StartButton"):
        $VBox/StartButton.pressed.connect(_on_start_pressed)
    if has_node("VBox/OptionsButton"):
        $VBox/OptionsButton.pressed.connect(_on_options_pressed)
    if has_node("VBox/QuitButton"):
        $VBox/QuitButton.pressed.connect(_on_quit_pressed)
    
    # Connect options panel
    if has_node("OptionsPanel/OptVBox/OptClose"):
        $OptionsPanel/OptVBox/OptClose.pressed.connect(_on_close_options)
    if has_node("OptionsPanel/OptVBox/LangOption"):
        $OptionsPanel/OptVBox/LangOption.connect("item_selected", Callable(self, "_on_lang_selected"))
    if has_node("OptionsPanel/OptVBox/VolumeSlider"):
        $OptionsPanel/OptVBox/VolumeSlider.connect("value_changed", Callable(self, "_on_volume_changed"))
    if has_node("OptionsPanel/OptVBox/ResolutionOption"):
        $OptionsPanel/OptVBox/ResolutionOption.connect("item_selected", Callable(self, "_on_resolution_selected"))
    
    _apply_localization()

func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://godot_project/Level1.tscn")

func _on_options_pressed() -> void:
    if has_node("OptionsPanel"):
        $OptionsPanel.visible = true
        var lang = _settings.get_language()
        var idx = 0 if lang == "de" else 1
        $OptionsPanel/OptVBox/LangOption.select(idx)

func _on_close_options() -> void:
    if has_node("OptionsPanel"):
        $OptionsPanel.visible = false

func _on_lang_selected(index: int) -> void:
    var lang = "de" if index == 0 else "en"
    _settings.set_language(lang)
    _apply_localization()

func _on_volume_changed(value: float) -> void:
    _settings.set_volume(int(value))

func _on_resolution_selected(index: int) -> void:
    var resolutions = ["1280,720", "1920,1080", "640,360"]
    if index < len(resolutions):
        _settings.set_resolution(resolutions[index])

func _on_quit_pressed() -> void:
    get_tree().quit()

func _apply_localization() -> void:
    if has_node("VBox/Title"):
        $VBox/Title.text = "SQUARE EATER"
    if has_node("VBox/StartButton"):
        $VBox/StartButton.text = "Start"
    if has_node("VBox/OptionsButton"):
        $VBox/OptionsButton.text = "Options"
    if has_node("VBox/QuitButton"):
        $VBox/QuitButton.text = "End"
    if has_node("OptionsPanel/OptVBox/OptTitle"):
        $OptionsPanel/OptVBox/OptTitle.text = "OPTIONS"
    if has_node("OptionsPanel/OptVBox/LangLabel"):
        $OptionsPanel/OptVBox/LangLabel.text = "Language:"
    if has_node("OptionsPanel/OptVBox/VolumeLabel"):
        $OptionsPanel/OptVBox/VolumeLabel.text = "Volume:"
    if has_node("OptionsPanel/OptVBox/ResolutionLabel"):
        $OptionsPanel/OptVBox/ResolutionLabel.text = "Resolution:"
    if has_node("OptionsPanel/OptVBox/OptClose"):
        $OptionsPanel/OptVBox/OptClose.text = "Back"

