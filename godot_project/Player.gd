extends CharacterBody2D

@export var speed: float = 220.0
@export var start_size: float = 24.0

var _velocity: Vector2 = Vector2.ZERO
var _size: float
var _is_dead: bool = false

func _ready() -> void:
    _size = start_size
    update()

func _physics_process(delta: float) -> void:
    if _is_dead:
        return
    
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
    update()

func _draw() -> void:
    # Draw player as a growing square
    var size = _size
    var rect = Rect2(-size / 2, -size / 2, size, size)
    draw_rect(rect, Color(0.2, 0.6, 1.0))

func grow(amount: float = 2.0) -> void:
    _size += amount
    if _size > 100:
        _size = 100  # max size
    update()

func get_size() -> float:
    return _size

func set_dead(dead: bool) -> void:
    _is_dead = dead

func set_camera_limits(rect: Rect2) -> void:
    if not has_node("Camera2D"):
        return
    var cam := $Camera2D
    cam.limit_left = int(rect.position.x)
    cam.limit_top = int(rect.position.y)
    cam.limit_right = int(rect.position.x + rect.size.x)
    cam.limit_bottom = int(rect.position.y + rect.size.y)
