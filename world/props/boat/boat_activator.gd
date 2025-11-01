class_name BoatActivator extends Area2D


@export var boats: Array[Boat]


func _ready() -> void:
	set_active(false)


func set_active(active: bool) -> void:
	for boat in boats:
		boat.set_physics_process(active)


func _on_body_entered(_body: Node2D) -> void:
	set_active(true)
