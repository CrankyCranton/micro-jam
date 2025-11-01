class_name Dash extends Ability


#region Members
@export var dash_speed: float

var can_dash: bool = true

#region Onready
@onready var cooldown: Timer = $DashCooldown
@onready var ghost_timer: Timer = $GhostTimer
#endregion
#endregion


#region Functions
func _execute() -> void:
	if can_dash == true:
		executed.emit(action)
		var original_speed: float = owner.SPEED

		ghost_timer.start()
		owner.velocity = Vector2.ZERO
		owner.velocity += owner.global_position.direction_to(get_global_mouse_position()) * dash_speed
		print(owner.velocity.direction_to(get_global_mouse_position()))

		await get_tree().create_timer(0.1).timeout

		ghost_timer.stop()
		owner.SPEED = original_speed
		can_dash = false
		$DashCooldown.start()


func add_trail() -> void:
	const DASH_TRAIL := preload("res://natsuki/abilities/dash/dash_trail/dash_trail.tscn")
	var dash_trail = DASH_TRAIL.instantiate()
	dash_trail.set_property(get_parent().global_position, 0.1)
	get_tree().current_scene.add_child(dash_trail)


#region Callbacks
func _on_ghost_timer_timeout() -> void:
	add_trail()


func _on_dash_cooldown_timeout() -> void:
	can_dash = true
#endregion
#endregion
