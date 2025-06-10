class_name HitBox extends Area2D


signal damage_taken(damage: int)
signal health_changed(health: int)
signal died

@export var max_health := 1

@onready var health := max_health:
	set(value):
		health = value
		health_changed.emit(health)
		if health <= 0:
			died.emit()
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var immunity_time: Timer = $ImmunityTime
@onready var immune := false:
	set(value):
		immune = value
		collision_shape.set_deferred(&"disabled", immune)


func take_damage(damage: int) -> int:
	assert(not immune)
	immune = true
	immunity_time.start()
	var old_health := health
	health -= damage
	damage_taken.emit(damage)
	return mini(old_health, damage)


func _on_immunity_time_timeout() -> void:
	immune = false
