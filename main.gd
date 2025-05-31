class_name Main extends Node


func _ready() -> void:
	const DIALOGUE := preload("res://dialogue/main.dialogue")
	DialogueManager.show_dialogue_balloon(DIALOGUE)
	await DialogueManager.dialogue_ended
	get_tree().quit()#get_tree().change_scene_to_file()
