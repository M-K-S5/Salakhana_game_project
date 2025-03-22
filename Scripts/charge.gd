extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."
@export_category("charge")
@export var current_charge = 3 
const Max_charges = 3

func use_charge():
	if Input.is_action_just_pressed("use card"): # press x for testing
		value = current_charge
		current_charge -= 1
		print("charges left " + str(current_charge))
