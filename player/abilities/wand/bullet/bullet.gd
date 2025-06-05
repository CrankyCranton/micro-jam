class_name Bullet extends Area2D


@export var spd := 300.0

var direction: float


func _physics_process(delta: float) -> void:
	position.x += direction * spd * delta


func delete(_collider: Node = null) -> void:
	queue_free()
