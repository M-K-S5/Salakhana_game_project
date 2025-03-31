extends Node

@onready var player = get_parent().get_node("player")
@onready var detection_area = $"fire pit"
@onready var health_bar = $"player/Camera2D/CanvasLayer/health bar"
var is_player_in_fire = false


func _ready() -> void:
	detection_area.connect("area_entered", Callable(self, "_on_detection_area_area_entered"))


func _on_fire_pit_body_entered(body: Node2D) -> void:
	if body == player:
		print("Player is on fire")
		is_player_in_fire = true
		health_bar.take_damage()
