extends Node2D
@export var fall_speed: float = 1000.0

var falling: bool = false

@onready var killbox = $killbox
@onready var trigger_area = $"trigger area"
@onready var self_destruct = $"self destruct"

func _physics_process(delta: float) -> void:
	if falling:
		global_position.y += fall_speed * delta

func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player detected, rock falling!")
		falling = true
		self_destruct.start()
		
func _on_killbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("player hit by rock!")
		get_tree().reload_current_scene()
		

func _on_self_destruct_timeout() -> void:
	print("rock vanished")
	queue_free()
