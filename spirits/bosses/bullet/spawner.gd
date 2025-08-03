class_name Spawner extends Node2D


@export var loaded_bullet:PackedScene

@export_group("bullet_characteristics")
@export var number_of_bullets:int
@export var total_spread_degrees:int

func _ready() -> void:
	spawn()

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("ui_accept"):
		spawn()

func spawn():
	for i in number_of_bullets:
		print(i)
		var bullet:Area2D = loaded_bullet.instantiate()
		get_tree().root.call_deferred("add_child", bullet)

		#var angle:int = total_spread_degrees/number_of_bullets
		bullet.global_rotation_degrees = global_rotation
		bullet.global_position = global_position
		
