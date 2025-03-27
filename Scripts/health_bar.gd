extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."
@export_category("health")
@export var current_health = 3
const Max_health = 3

func take_damage():
	if Input.is_action_just_pressed("take_damage"): # press x for testing
		value = current_health
		current_health -= 1
		print("health points: " + str(current_health))
