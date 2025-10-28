extends Control


#region Members
const VOLUME_CURVE := preload("res://ui/settings/volume_curve.tres")

@onready var volume_slider: HSlider = %VolumeSlider
#endregion


#region Functions
func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, VOLUME_CURVE.sample(remap(value,
			volume_slider.min_value, volume_slider.max_value, 0.0, 1.0)))
	#AudioServer.set_bus_volume_db(0, remap(sqrt(value), volume_slider.min_value,
			#sqrt(volume_slider.max_value), -40.0, 0.0))


func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
#endregion
