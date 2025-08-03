class_name Spawner extends Node2D


@export var loaded_bullet:PackedScene

@export_group("bullet_characteristics")
@export var number_of_bullets:int
@export var angle:int


func spawn():
	var bullet:Area2D = loaded_bullet.instantiate()
	
