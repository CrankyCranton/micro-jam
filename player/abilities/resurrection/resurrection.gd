class_name Resurrection extends Ability


func _execute() -> void:
	owner.interactable.resurrect(owner)
