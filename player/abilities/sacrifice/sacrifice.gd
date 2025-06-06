class_name Sacrifice extends Ability


func _execute() -> void:
	player.corruption += player.max_health - player.health
	player.health = player.max_health
