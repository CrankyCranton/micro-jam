class_name Dash extends Ability


@export var dash_speed: float

@onready var cooldown: Timer = $DashCooldown
@onready var ghost_timer: Timer = $GhostTimer


func _execute() -> void:
	var original_speed: float = owner.SPEED

	ghost_timer.start()
	owner.SPEED = dash_speed

	await get_tree().create_timer(0.1).timeout

	ghost_timer.stop()
	owner.SPEED = original_speed


func add_trail() -> void:
	const DASH_TRAIL := preload("res://player/abilities/dash/dash_trail/dash_trail.tscn")
	var dash_trail = DASH_TRAIL.instantiate()
	dash_trail.set_property(get_parent().global_position, 0.1)
	get_tree().current_scene.add_child(dash_trail)


func _on_ghost_timer_timeout() -> void:
	add_trail()
