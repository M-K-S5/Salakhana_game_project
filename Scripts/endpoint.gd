extends Area2D
@onready var player = $"../player"
@onready var enemy = $"../enemies/chasing enemy"



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		enemy.velocity = Vector2.ZERO
