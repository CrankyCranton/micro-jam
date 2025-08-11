class_name Spawner extends Node2D

@onready var spawn:PackedScene = preload("res://spawn.tscn")
@export var bullet_scene:PackedScene
@onready var shoot_timer:Timer = $ShootTimer

@export_group("bullet")
@export var rotate_speed:int
@export var shoot_timer_wait_time:int

@export_group("spawning")
@export var spawn_point_count:int
@export var increment:int

func _ready() -> void:
	var step:float = TAU / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point:Node2D = spawn.instantiate()
		var Position:Vector2 = Vector2(increment,0).rotated(step * i)
		spawn_point.global_position = Position
		spawn_point.global_rotation = Position.angle()
		%Bullets.add_child(spawn_point)
	
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()

func _physics_process(delta: float) -> void:
	var new_rotation = %Bullets.rotation_degrees + rotate_speed * delta
	%Bullets.rotation_degrees = fmod(new_rotation, 360)

func _on_shoot_timer_timeout() -> void:
	for s in %Bullets.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
	shoot_timer.start()
