
extends Area2D

@export var target_scene_path: String = ""
@export var spawn_position: Vector2 = Vector2.ZERO
@export var is_open: bool = true
signal request_room_change(target_scene_path, spawn_position)

var _visual_scale: float = 1.0 setget set_visual_scale
var _visual_alpha: float = 1.0 setget set_visual_alpha

func _ready() -> void:
    connect("body_entered", Callable(self, "_on_body_entered"))
    # ensure initial visual state
    if is_open:
        _visual_scale = 1.0
        _visual_alpha = 1.0
    else:
        _visual_scale = 0.6
        _visual_alpha = 0.4
    update()

func _on_body_entered(body) -> void:
    if not is_open:
        return
    if body is CharacterBody2D:
        emit_signal("request_room_change", target_scene_path, spawn_position)

func open() -> void:
    is_open = true
    _animate_visual(to_open=true)

func close() -> void:
    is_open = false
    _animate_visual(to_open=false)

func toggle() -> void:
    is_open = not is_open
    _animate_visual(to_open=is_open)

func set_visual_scale(v: float) -> void:
    _visual_scale = v
    update()

func set_visual_alpha(v: float) -> void:
    _visual_alpha = v
    update()

func _animate_visual(to_open: bool) -> void:
    var tween = create_tween()
    if to_open:
        tween.tween_property(self, "_visual_scale", 1.0, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "_visual_alpha", 1.0, 0.25)
    else:
        tween.tween_property(self, "_visual_scale", 0.6, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
        tween.tween_property(self, "_visual_alpha", 0.4, 0.2)

func _draw() -> void:
    var cshape = $CollisionShape2D.shape if has_node("CollisionShape2D") else null
    var base_color = is_open ? Color(0.2, 0.9, 0.2) : Color(0.9, 0.2, 0.2)
    var color = Color(base_color.r, base_color.g, base_color.b, _visual_alpha)
    if cshape and cshape is RectangleShape2D:
        var ext = cshape.extents * _visual_scale
        var rect = Rect2(-ext, ext * 2)
        draw_rect(rect, color)
