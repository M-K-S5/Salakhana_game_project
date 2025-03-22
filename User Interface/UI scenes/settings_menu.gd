extends Control


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://User Interface/UI scenes/Main_menu.tscn")


func _on_v_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_volume_db(0, -80)
	else:
		AudioServer.set_bus_volume_db(0, 0)
		
func _on_option_button_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1152,648))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))
