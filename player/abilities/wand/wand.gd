class_name Wand extends Ability


func _execute() -> void:
	var BULLET := preload("res://player/abilities/wand/bullet/bullet.tscn")
	var bullet: Area2D = BULLET.instantiate()
	bullet.direction = owner.direction
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
