class_name ShadyStranger extends NPC


func _interact(player: Player) -> void:
	await super(player)
	if not Global.met_shady_guy:
		const ABILITY_INFO := preload("res://player/abilities/wand/wand_info.tres")
		player.add_ability(ABILITY_INFO)
		Global.met_shady_guy = true
		queue_free()
