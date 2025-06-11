class_name Sacrifice extends Ability


func _execute() -> void:
	player.corruption += player.hit_box.max_health - player.hit_box.health
	player.hit_box.health = player.hit_box.max_health
