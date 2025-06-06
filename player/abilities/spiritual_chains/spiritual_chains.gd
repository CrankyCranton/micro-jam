class_name SpiritualChains extends Ability


func _execute() -> void:
	await player.interactable.enslave(player)
