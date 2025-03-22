extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://User Interface/UI scenes/Main_menu.tscn")
