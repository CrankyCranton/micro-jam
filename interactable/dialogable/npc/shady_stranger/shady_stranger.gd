class_name ShadyStranger extends NPC


func _interact(player: Player) -> void:
	await super(player)
	if not Global.met_shady_guy:
		const ABILITY := preload("res://player/abilities/dash/warp/warp.tscn")
		player.add_ability(ABILITY)
		Global.met_shady_guy = true
