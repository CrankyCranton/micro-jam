class_name HitBox extends Area2D


signal damage_taken(damage: int)

@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var immunity_time: Timer = $ImmunityTime


func take_damage(damage: int) -> void:
	damage_taken.emit(damage)
	collision_shape.set_deferred(&"disabled", true)
	immunity_time.start()


func _on_immunity_time_timeout() -> void:
	collision_shape.set_deferred(&"disabled", false)
