class_name Main extends Node


func _ready() -> void:
	const DIALOGUE := preload("res://dialogue/main.dialogue")
	InteractionManager.start_dialogue(DIALOGUE, "start")

	get_tree().change_scene_to_file("res://world/world.tscn")
