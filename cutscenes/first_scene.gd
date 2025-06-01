extends Node2D

#var dialogue:Resource = preload("res://dialogue/first_scene_dream.dialogue")

func _ready() -> void:
	#DialogueManager.show_dialogue_balloon(dialogue)
	pass

func change_scene_to_world():
	get_tree().change_scene_to_file("res://world/world.tscn")
