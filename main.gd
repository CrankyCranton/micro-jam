class_name Main extends Node


#func _ready() -> void:
	#const DIALOGUE := preload("res://dialogue/main.dialogue")
	#await InteractionManager.start_dialogue(DIALOGUE, "dream")
	#get_tree().change_scene_to_file("res://world/world.tscn")


func _on_video_finished() -> void:
	pass#get_tree().change_scene_to_file("res://world/world.tscn")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
