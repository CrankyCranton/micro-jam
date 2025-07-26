class_name DimensionalDash extends Ability


const MARGIN := 1.0

@onready var projector: ShapeCast2D = $Projector


func _ready() -> void:
	#print(player.collision_shape)
	await player.ready
	projector.shape = player.collision_shape.shape.duplicate()
	projector.shape.radius -= MARGIN / 2.0
	projector.shape.height -= MARGIN
	projector.position = player.collision_shape.position


func _execute() -> void:
	var mouse:Vector2 = get_global_mouse_position()
	#projector.target_position.x = absf(projector.target_position.x) * player.last_direction
	projector.target_position = mouse
	projector.force_shapecast_update()
	var dash_length := projector.get_closest_collision_safe_fraction() \
			* projector.target_position.length()
	player.position.x += dash_length * player.last_direction
