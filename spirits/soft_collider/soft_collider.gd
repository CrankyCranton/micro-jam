class_name SoftCollider extends Area2D


@onready var shape: CircleShape2D = $CollisionShape.shape


func get_vector() -> Vector2:
	var vector := Vector2()
	for soft_collider: SoftCollider in get_overlapping_areas():
		var max_distance := shape.radius + soft_collider.shape.radius
		vector += global_position - soft_collider.global_position / max_distance

	vector = vector.limit_length()

	return vector
