class_name Dialogable extends Interactable


@export var dialogue: DialogueResource
@export var title := ""


func _init() -> void:
	interact = func(player: Player) -> void:
		InteractionManager.start_dialogue(dialogue, title)
		player.set_enabled(false)
		player.velocity = Vector2.ZERO
		await DialogueManager.dialogue_ended
		player.set_enabled(true)
