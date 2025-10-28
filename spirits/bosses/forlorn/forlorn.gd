class_name Forlorn extends Boss


@onready var mouth: Marker2D = $Mouth


func scream(BULLET: PackedScene, spin_speed := 15.0) -> void:
	var spin := deg_to_rad(spin_speed) * Time.get_ticks_msec() / 1000.0
	const BULLET_COUNT := 10
	for i in BULLET_COUNT:
		mouth.rotation = TAU * (float(i) / BULLET_COUNT) + spin
		spawn_bullet_at_node(mouth, BULLET)
