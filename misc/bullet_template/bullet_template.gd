class_name Bullet extends Area2D

var speed: float
var direction = Vector2.RIGHT


func move(_delta:float):
	position += direction.rotated(global_rotation) * speed * _delta
