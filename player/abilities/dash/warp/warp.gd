class_name Warp extends Ability


#region Members
const MARGIN := 1.0

@onready var projector: ShapeCast2D = $Projector
#endregion


#region Functions
func _initialize() -> void:
	projector.shape = owner.collision_shape.shape.duplicate()
	projector.shape.radius -= MARGIN / 2.0
	projector.shape.height -= MARGIN
	projector.position = owner.collision_shape.position


func _execute() -> void:
	var mouse:Vector2 = get_global_mouse_position()
	#projector.target_position.x = absf(projector.target_position.x) * player.last_direction
	projector.target_position = mouse
	projector.force_shapecast_update()
	var dash_length := projector.get_closest_collision_safe_fraction() \
			* projector.target_position.length()
	owner.position.x += dash_length * owner.last_direction


#endregion
