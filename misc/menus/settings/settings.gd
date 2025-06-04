extends Control


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value/5)

func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
