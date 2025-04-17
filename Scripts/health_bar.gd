extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."

@export_category("health")
@export var max_health = 3
var current_health = 3

func _process(delta):
	$".".set_value_no_signal(current_health)
	GameData.health = current_health

func take_damage():
	current_health -= 1
	print("health points: " + str(current_health))
	if current_health <= 0:
		print("YOU DIED!!")
		get_tree().reload_current_scene()
