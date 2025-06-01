class_name NPC extends Dialogable


@export var enslave_title := ""


func enslave(player: Player) -> void:
	title = enslave_title
	await _interact()

	const SLAVE := preload("res://spirits/evil_spirit/slave/slave.tscn")
	var slave: Slave = SLAVE.instantiate()
	slave.player = player
	slave.global_position = global_position
	add_sibling(slave)

	queue_free()
