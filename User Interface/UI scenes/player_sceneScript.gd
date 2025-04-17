extends Control

#-- definitions :
@onready var map: Node2D = $"../../../.."
@onready var health_bar_fMAp: TextureProgressBar = $"../health bar"

#---
var CDValueD : int = 3
var CDValueH : int = 15
var IsDRready : bool = GameData.dashisready
var IsHready : bool = GameData.potionisready



func _process(delta):
	
	var time_left_health : int = $"Health_cooldown/TimerH".time_left
	var time_left_Dash : int = $"Dash_cooldown/TimerD".time_left
	$Dash_cooldown.set_value_no_signal(CDValueD - time_left_Dash)
	$Health_cooldown.set_value_no_signal(CDValueH - time_left_health)
	
	if Input.is_action_just_pressed("dash") and GameData.dashisready:
		GameData.dashisready = false
		$"Dash_cooldown/TimerD".start()
		print ("dash done-----------------")
		
		
	if Input.is_action_just_pressed("healPotion") and GameData.potionisready:
		GameData.potionisready = false
		health_bar_fMAp.current_health += 1 
		$"Health_cooldown/TimerH".start()
		print ("heal done---------------")
		
	





func _on_timer_d_timeout() -> void:
	GameData.dashisready = true
	$Dash_cooldown/TimerD.stop()



func _on_timer_h_timeout() -> void:
	GameData.potionisready = true
	$Health_cooldown/TimerH.stop()
