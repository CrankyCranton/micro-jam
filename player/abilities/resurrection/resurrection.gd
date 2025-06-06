class_name Resurrection extends Ability


func _execute() -> void:
	await player.interactable.resurrect(player)
