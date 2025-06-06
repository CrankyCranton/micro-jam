class_name DimensionalDash extends Ability


const MARGIN := 1.0

@onready var projector: ShapeCast2D = $Projector


func _ready() -> void:
	projector.shape = player.collision_shape.shape.duplicate()
	projector.shape.radius -= MARGIN / 2.0
	projector.shape.height -= MARGIN
	projector.position = player.collision_shape.position


func _execute() -> void:
	projector.target_position.x = absf(projector.target_position.x) * player.last_direction
	projector.force_shapecast_update()
	var dash_length := projector.get_closest_collision_safe_fraction() \
			* projector.target_position.length()
	player.position.x += dash_length * player.last_direction
