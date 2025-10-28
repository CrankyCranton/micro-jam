class_name TheDream extends Control


#region Functions
func load_world() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


#region Callbacks
func _on_skip_button_pressed() -> void:
	load_world()


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	load_world()
#endregion
#endregion
