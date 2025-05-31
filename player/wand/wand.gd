extends Node2D

var bullet_load:PackedScene = preload("res://player/wand/laser_ball.tscn")

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		var bullet:CharacterBody2D = bullet_load.instantiate()
		bullet.global_position = global_position
		bullet.global_rotation = global_rotation
		get_tree().root.add_child(bullet)
