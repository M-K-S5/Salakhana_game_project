extends Node2D

var coins_num = 0 
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	GameData.coins += 1
	GameData.score += 100
	#print("coins: " + str(GameData.coins))
	queue_free()
