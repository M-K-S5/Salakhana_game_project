extends CharacterBody2D

@export var move_distance: float = 1015
@export var move_speed: float = 150

var original_position: Vector2
var target_position: Vector2
var moving_up: bool = false
var has_moved: bool = false

func _ready():
	original_position = global_position
	target_position = original_position - Vector2(0, move_distance)

func _process(delta):
	if moving_up:
		var new_position = global_position.move_toward(target_position, move_speed * delta)
		global_position = new_position
		if global_position == target_position:
			moving_up = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not has_moved:
		moving_up = true
		has_moved = true
