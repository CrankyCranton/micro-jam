class_name HitBox extends Area2D


signal damage_taken(damage: int)

@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var immunity_time: Timer = $ImmunityTime
@onready var immune := false:
	set(value):
		immune = value
		collision_shape.set_deferred(&"disabled", immune)


func take_damage(damage: int) -> void:
	assert(not immune)
	damage_taken.emit(damage)
	immune = true
	immunity_time.start()


func _on_immunity_time_timeout() -> void:
	immune = false
