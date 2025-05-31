class_name HitBox extends Area2D


signal damage_taken(damage: int)


func take_damage(damage: int) -> void:
	damage_taken.emit(damage)
