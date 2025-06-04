class_name Dialogable extends Interactable


@export var dialogue: DialogueResource
@export var title := ""


func _interact(_player: Player) -> void:
	InteractionManager.start_dialogue(dialogue, title)
	await DialogueManager.dialogue_ended
	Global.met_shady_guy = true
	
