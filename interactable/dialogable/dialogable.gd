class_name Dialogable extends Interactable


#region Members
@export var dialogue: DialogueResource
@export var title := ""
#endregion


func _interact(_player: Player) -> void:
	const BALLOON := preload("res://dialogue/balloon.tscn")
	DialogueManager.show_dialogue_balloon_scene(BALLOON, dialogue, title)
	await DialogueManager.dialogue_ended
