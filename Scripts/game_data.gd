extends Node
var coins = 0
var score = 0 
var gems = 0


#-------------hzm added this-------------#
var health = 3
var charges : int = 3
var isThereACharge :bool 

	#----------cooldowns
var dashisready : bool = true
var potionisready : bool = true

#---------------------------------------#

func _physics_process(delta: float) -> void:
	if score == 3000 : # replace with the number of coins * 10
		get_tree().reload_current_scene()
