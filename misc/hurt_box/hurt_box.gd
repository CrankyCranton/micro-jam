class_name HurtBox extends Area2D


@export var damage := 1
@export var ignored_groups: Array[StringName] = []


func _on_area_entered(hit_box: HitBox) -> void:
	for group in hit_box.get_groups():
		if group in ignored_groups:
			return

	hit_box.take_damage(damage)
