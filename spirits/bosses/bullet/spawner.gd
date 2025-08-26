class_name Spawner extends Node2D


@export var bullet_scene: PackedScene
@onready var shoot_timer: Timer = $ShootTimer
@export_group("bullet")
@export var rotate_speed: int
@export var shoot_timer_wait_time: float
@export_group("spawning")
@export var spawn_point_count: int
@export var radius: int

@onready var bullets: Marker2D = %Bullets


func _ready() -> void:
	var step: float = TAU / spawn_point_count

	for i in range(spawn_point_count):
		var spawn_point: Node2D = Node2D.new()
		var Position: Vector2 = Vector2(radius,0).rotated(step * i)
		spawn_point.global_position = Position
		spawn_point.global_rotation = Position.angle()
		bullets.add_child(spawn_point)

	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()


func _physics_process(delta: float) -> void:
	var new_rotation = bullets.rotation_degrees + rotate_speed * delta
	bullets.rotation_degrees = fmod(new_rotation, 360)


func _on_shoot_timer_timeout() -> void:
	for s in bullets.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
	shoot_timer.start()
