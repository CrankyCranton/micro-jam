class_name Boat extends AnimatableBody2D


#region Members
@export var direction := 1
@export var speed := 16.0

@onready var y := global_position.y
@onready var character_collision: AnimatableBody2D = $CharacterCollision
#endregion


func _physics_process(delta: float) -> void:
	var velocity := Vector2(direction * speed, 0.0)
	var collision := move_and_collide(velocity * delta)
	if collision != null:
		direction = -direction
	global_position.y = y
	character_collision.global_transform = global_transform
