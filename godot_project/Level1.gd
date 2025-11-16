extends Node2D

onready var player := $Player
onready var hud_label := $HUD/RoomLabel
var _localization: Node
var _food_list: Array = []
var _spawn_timer: float = 0.0

@export var food_spawn_interval: float = 1.0
@export var level_width: float = 1280.0
@export var level_height: float = 720.0

func _ready() -> void:
    _localization = preload("res://godot_project/Localization.gd").new()
    player.position = Vector2(level_width / 2, level_height / 2)
    hud_label.text = "Size: " + str(int(player.get_size()))
    _spawn_food()

func _physics_process(delta: float) -> void:
    # Update HUD
    if hud_label:
        hud_label.text = "Size: " + str(int(player.get_size()))
    
    # Food spawning
    _spawn_timer += delta
    if _spawn_timer >= food_spawn_interval:
        _spawn_food()
        _spawn_timer = 0.0
    
    # Check collisions with food
    _check_food_collisions()

func _spawn_food() -> void:
    # Create a small food square at random position
    var food = Node2D.new()
    food.position = Vector2(
        randf_range(50, level_width - 50),
        randf_range(50, level_height - 50)
    )
    
    # Store food data: [pos, size, eaten]
    var food_data = {
        "pos": food.position,
        "size": 8.0,
        "eaten": false,
        "id": len(_food_list)
    }
    _food_list.append(food_data)
    add_child(food)
    food.queue_free()  # Don't keep node, just track data
    
    # Limit food to max 50
    if len(_food_list) > 50:
        _food_list.pop_front()

func _check_food_collisions() -> void:
    var player_pos = player.position
    var player_size = player.get_size()
    var player_rect = Rect2(player_pos - Vector2(player_size/2, player_size/2), Vector2(player_size, player_size))
    
    var to_remove = []
    for i in range(len(_food_list)):
        var food = _food_list[i]
        if food["eaten"]:
            continue
        
        var food_rect = Rect2(food["pos"] - Vector2(food["size"]/2, food["size"]/2), Vector2(food["size"], food["size"]))
        if player_rect.intersects(food_rect):
            food["eaten"] = true
            player.grow(1.0)
            to_remove.append(i)
    
    # Remove eaten food
    for i in to_remove.reverse():
        _food_list.remove_at(i)

func _draw() -> void:
    # Draw background
    draw_rect(Rect2(0, 0, level_width, level_height), Color(0.15, 0.15, 0.2))
    
    # Draw food
    for food in _food_list:
        if not food["eaten"]:
            var size = food["size"]
            var rect = Rect2(food["pos"] - Vector2(size/2, size/2), Vector2(size, size))
            draw_rect(rect, Color(1.0, 0.8, 0.2))

