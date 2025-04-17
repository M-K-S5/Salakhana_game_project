extends TextureProgressBar

@onready var health_bar: TextureProgressBar = $"."
@onready var player = $"../../.."
@export_category("charge")
@export var Max_charges = 3 
var current_charge = 3

func use_charge():
	if not current_charge <= 0:
		current_charge -= 1
		print("charges left " + str(current_charge))
		GameData.charges = current_charge

func _physics_process(_delta: float) -> void:
	if current_charge <= 1:
		GameData.isThereACharge = true
	else :
		GameData.isThereACharge = false
	
	$".".set_value_no_signal(GameData.charges)
	GameData.charges = current_charge
