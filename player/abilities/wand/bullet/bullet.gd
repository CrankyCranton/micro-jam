class_name Bullet extends Area2D


var speed: float
var direction = Vector2.RIGHT

@onready var hurt_box: HurtBox = $HurtBox
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
@onready var shape: Shape2D:
	set(value):
		shape = value
		hurt_box.collision_shape.shape = shape


func _physics_process(delta: float) -> void:
	position += direction.rotated(global_rotation) * speed * delta


func delete() -> void:
	queue_free()


func _on_hurt_box_dealt_damage(_target: HitBox, damage: int) -> void:
	self.damage -= damage


func _on_collision_detection_timer_timeout() -> void:
	if get_overlapping_bodies().size() > 0:
		const WALL_DAMAGE := 10
		damage -= WALL_DAMAGE
