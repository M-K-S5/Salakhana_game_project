extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."
@export_category("health")
@export var max_health = 3
var current_health = 3

func take_damage():
	current_health -= 1
	print("health points: " + str(current_health))
