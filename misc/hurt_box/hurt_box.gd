class_name HurtBox extends Area2D


#region Members
signal dealt_damage(target: HitBox, damage: int)

#region Export
@export var damage := 10
@export var ignored_groups: Array[StringName] = []
@export var deny_double_hit := true
#endregion

var hit_list: Array[HitBox] = []

@onready var collision_shape: CollisionShape2D = $CollisionShape
#endregion


func _on_area_entered(hit_box: HitBox) -> void:
	for group in hit_box.get_groups():
		if group in ignored_groups:
			return
	if hit_box.immune or (hit_box in hit_list and deny_double_hit):
		return

	hit_list.append(hit_box)
	dealt_damage.emit(hit_box, hit_box.take_damage(damage))
