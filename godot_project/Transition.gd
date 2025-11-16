extends CanvasLayer

@onready var rect := $ColorRect

func _ready() -> void:
    rect.color = Color(0,0,0,0)

func fade_out(duration: float = 0.35) -> void:
    var tween = rect.create_tween()
    tween.tween_property(rect, "color:a", 1.0, duration)
    await tween.finished

func fade_in(duration: float = 0.35) -> void:
    var tween = rect.create_tween()
    tween.tween_property(rect, "color:a", 0.0, duration)
    await tween.finished
