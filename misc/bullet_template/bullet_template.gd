class_name Bullet extends Area2D

var speed: float
var direction = Vector2.RIGHT

@export var hurt_box:HurtBox

@onready var total_damage: int:
	set(value):
		total_damage = value
		damage = total_damage
@onready var damage: int:
	set(value):
		damage = value
		modulate.a = float(damage) / total_damage
		hurt_box.damage = damage
		if damage <= 0:
			delete()

func move(_delta:float):
	position += direction.rotated(global_rotation) * speed * _delta

func delete() -> void:
	queue_free()
