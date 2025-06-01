extends Node2D

@onready var ray:RayCast2D = $RayCast2D
@export var max_length:int


func _process(delta: float) -> void:
	ray.target_position = ray.to_local(get_global_mouse_position()).limit_length(max_length)


func execute(player:Player):
	if ray.is_colliding():
		print("is colliding")
		var npc = ray.get_collider()
		npc.STATE = npc.states.minion_move
