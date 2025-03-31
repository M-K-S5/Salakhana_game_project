extends Area2D
@onready var player = $player
@onready var detection_area = $"."
@onready var label = $Label
@onready var cenemy = $"../enemies/chasing enemy"
var is_player_in_area = false

func _ready() -> void:
	label.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print("Player entered detection area")
		is_player_in_area = true
		label.visible = true
		cenemy.velocity = Vector2.ZERO
