class_name Resurrection extends Ability


func _execute() -> void:
	await owner.interactable.resurrect(owner)
