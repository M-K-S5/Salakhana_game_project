extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/map.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://User Interface/UI scenes/settings_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
