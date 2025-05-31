extends Node2D

@onready var cooldown:Timer = $DashCooldown
@onready var ghost_timer:Timer = $GhostTimer

var ghost:PackedScene = preload("res://abilities/ghost.tscn")

@export var dash_speed:int

func execute(object:Player):
	var original_speed:int = object.SPEED

	ghost_timer.start()
	object.SPEED = dash_speed

	await get_tree().create_timer(0.1).timeout

	ghost_timer.stop()
	object.SPEED = original_speed

func add_ghost(): #adds ghost and sets it properties, see ghost.gd
	var ghost_ins = ghost.instantiate()
	ghost_ins.set_property(get_parent().global_position, 0.1)
	get_tree().current_scene.add_child(ghost_ins)

func _on_ghost_timer_timeout() -> void:
	add_ghost()
