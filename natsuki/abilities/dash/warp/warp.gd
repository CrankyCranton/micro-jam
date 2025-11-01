class_name Warp extends Ability


#region Members
const MARGIN := 1.0

@export var slow_speed := 0.1

var cooling := false

#region Onready
@onready var projector: ShapeCast2D = $Projector
@onready var cooldown: Timer = $Cooldown
#endregion
#endregion


#region Functions
#region Overrides
func _initialize() -> void:
	projector.shape = owner.collision_shape.shape.duplicate()
	projector.shape.radius -= MARGIN / 2.0
	projector.shape.height -= MARGIN
	projector.position = owner.collision_shape.position


func _execute() -> void:
	if cooling:
		return
	cooling = true
	cooldown.start()

	var mouse := get_global_mouse_position()
	owner.global_position = mouse + projector.position
	owner.velocity = Vector2.ZERO
	Engine.time_scale = slow_speed
	get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_STOP).tween_property(
			Engine, ^"time_scale", 1.0, cooldown.wait_time)
	#projector.target_position.x = absf(projector.target_position.x) * player.last_direction
	#projector.target_position = mouse
	#projector.force_shapecast_update()
	#owner.position += projector.target_position * projector.get_closest_collision_safe_fraction()
#endregion


func _on_cooldown_timeout() -> void:
	cooling = false
#endregion
