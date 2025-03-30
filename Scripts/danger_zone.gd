extends Node2D
@onready var timer = $Area2D/Timer

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print ("YOU DIED!!")
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
