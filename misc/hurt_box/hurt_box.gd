class_name HurtBox extends Area2D


signal dealt_damage(target: HitBox, damage: int)

@export var damage := 1
@export var ignored_groups: Array[StringName] = []

@onready var collision_shape: CollisionShape2D = $CollisionShape


func _on_area_entered(hit_box: HitBox) -> void:
	for group in hit_box.get_groups():
		if group in ignored_groups:
			return
	if hit_box.immune:
		return

	dealt_damage.emit(hit_box, hit_box.take_damage(damage))
