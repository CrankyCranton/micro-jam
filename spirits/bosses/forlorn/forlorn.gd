class_name Forlorn extends Boss


@onready var mouth: Marker2D = $Mouth


func scream(BULLET: PackedScene, bullet_count := 8, spin_speed := 20.0) -> void:
	var spin := deg_to_rad(spin_speed) * Time.get_ticks_msec() / 1000.0
	for i in bullet_count:
		mouth.rotation = TAU * (float(i) / bullet_count) + spin
		spawn_bullet_at_node(mouth, BULLET)
