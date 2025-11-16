extends CharacterBody2D

@export var speed: float = 220.0

var _velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
    var input_dir = Vector2.ZERO
    if Input.is_action_pressed("ui_right") or Input.is_key_pressed(Key.D):
        input_dir.x += 1
    if Input.is_action_pressed("ui_left") or Input.is_key_pressed(Key.A):
        input_dir.x -= 1
    if Input.is_action_pressed("ui_down") or Input.is_key_pressed(Key.S):
        input_dir.y += 1
    if Input.is_action_pressed("ui_up") or Input.is_key_pressed(Key.W):
        input_dir.y -= 1

    if input_dir != Vector2.ZERO:
        input_dir = input_dir.normalized()

    _velocity = input_dir * speed
    velocity = _velocity
    move_and_slide()

func _draw() -> void:
    # Visual fallback (if no sprite) - draw a simple rectangle
    var size = Vector2(24, 24)
    var rect = Rect2(-size / 2, size)
    draw_rect(rect, Color(0.2, 0.6, 1.0))

func set_camera_limits(rect: Rect2) -> void:
    # rect is in room-local coordinates; Camera2D as child of Player expects limits in world coords
    if not has_node("Camera2D"):
        return
    var cam := $Camera2D
    cam.limit_left = int(rect.position.x)
    cam.limit_top = int(rect.position.y)
    cam.limit_right = int(rect.position.x + rect.size.x)
    cam.limit_bottom = int(rect.position.y + rect.size.y)
