class_name SpiritualChains extends Ability

@onready var cooldown:Timer = $Cooldown

func _execute() -> void:
	if cooldown.is_stopped():
		await owner.interactable.enslave(owner)
		cooldown.start()

func _on_cooldown_timeout() -> void:
	cooldown.stop()
