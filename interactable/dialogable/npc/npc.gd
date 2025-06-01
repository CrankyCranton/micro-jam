class_name NPC extends Dialogable


@export var enslave_title := ""


func enslave(player: Player) -> void:
	title = enslave_title
	_interact()
