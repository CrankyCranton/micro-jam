class_name Dialogable extends InteractionArea


@export var dialogue: DialogueResource
@export var title := ""


func _init() -> void:
	Interact = func(player: Player) -> void:
		InteractionManager.start_dialogue(dialogue, title)
		player.set_enabled(false)
		await DialogueManager.dialogue_ended
		player.set_enabled(true)
