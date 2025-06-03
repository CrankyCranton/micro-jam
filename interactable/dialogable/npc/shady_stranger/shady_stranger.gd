class_name ShadyStranger extends NPC


func _interact(player: Player) -> void:
	await super(player)
	const ABILITY := preload("res://player/abilities/wand/wand.tscn")
	player.add_ability(ABILITY)
