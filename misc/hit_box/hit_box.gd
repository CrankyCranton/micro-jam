class_name HitBox extends Area2D


#region Members
#region Signals
signal health_changed(damage: int)
signal health_decreased(health: int)
signal health_increased(health: int)
signal died
#endregion

@export var max_health := 1

#region Onready
@onready var health := max_health:
	set(value):
		if value > health:
			health_increased.emit(health)
		elif value < health:
			health_decreased.emit(health)
		health = value
		if health <= 0:
			died.emit()
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var immunity_time: Timer = $ImmunityTime
@onready var immune := false:
	set(value):
		immune = value
		collision_shape.set_deferred(&"disabled", immune)
#endregion
#endregion


#region Functions
func take_damage(damage: int) -> int:
	assert(not immune)
	immune = true
	immunity_time.start()

	var old_health := health
	health -= damage
	health_changed.emit(-damage)
	return mini(old_health, damage)


func _on_immunity_time_timeout() -> void:
	immune = false
#endregion
