extends Control

#-- definitions :

#---
var dashisready : bool = true

var potionisready : bool = true


func _process(delta):
	var time_left_health : int = $"Health_cooldown/TimerH".time_left
	var time_left_Dash : int = $"Dash_cooldown/TimerD".time_left
	$Dash_cooldown.set_value_no_signal(time_left_Dash)
	$Health_cooldown.set_value_no_signal(time_left_health)
	
	if Input.is_action_just_pressed("dash") and dashisready:
		dashisready = false
		$"Dash_cooldown/TimerD".start()
		print ("dash done")
		
		
	if Input.is_action_just_pressed("healPotion") and potionisready:
		potionisready = false
		$"Health_cooldown/TimerH".start()
		print ("heal done")
		
	




func _on_timer_timeout() -> void:
	dashisready = true


func _on_timer_h_timeout() -> void:
	potionisready = true
