class_name electroBall extends Bullet


@onready var shape: Shape2D:
	set(value):
		shape = value
		hurt_box.collision_shape.shape = shape


func _physics_process(delta: float) -> void:
	move(delta)
	speed = 200

func _on_hurt_box_dealt_damage(_target: HitBox, damage: int) -> void:
	self.damage -= damage

func _on_collision_detection_timer_timeout() -> void:
	if get_overlapping_bodies().size() > 0:
		const WALL_DAMAGE := 10  
		damage -= WALL_DAMAGE
