class_name Main extends Node


#func _ready() -> void:
	#const DIALOGUE := preload("res://dialogue/main.dialogue")
	#await InteractionManager.start_dialogue(DIALOGUE, "dream")
	#get_tree().change_scene_to_file("res://world/world.tscn")


func _on_video_finished() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
