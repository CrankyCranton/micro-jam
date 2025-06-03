class_name SpiritualChains extends Ability


func _execute() -> void:
	await owner.interactable.enslave(owner)
