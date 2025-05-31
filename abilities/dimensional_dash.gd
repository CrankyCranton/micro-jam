extends Node2D

@onready var ray:RayCast2D = $RayCast2D

@export var max_length:int

func _process(delta: float) -> void:
	look_at(to_local(get_global_mouse_position()))
	#ray.target_position.limit_length(max_length)
