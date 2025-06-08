class_name Main extends Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact"):
		get_tree().change_scene_to_file("res://world/world.tscn")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
