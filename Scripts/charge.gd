extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."
@onready var player = $"../../.."
@export_category("charge")
@export var Max_charges = 3 
var current_charge = 3

func use_charge():
	current_charge -= 1
	print("charges left " + str(current_charge))

func _physics_process(_delta: float) -> void:
	if player.is_on_floor():
		current_charge = Max_charges
