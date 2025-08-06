class_name Spawner extends Node2D


@export var bullet_scene:PackedScene
@onready var shoot_timer = $ShootTimer

@export_group("bullet")
@export var rotate_speed = 100
@export var shoot_timer_wait_time = 0.2

@export_group("spawning")
@export var spawn_point_count = 4
@export var radius = 100

func _ready():	
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		add_child(spawn_point)
		
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()


func _process(delta):
	var new_rotation = rotation_degrees + rotate_speed * delta
	rotation_degrees = fmod(new_rotation, 360)
	

func _on_ShootTimer_timeout() -> void:
	for s in get_children():
		var bullet = bullet_scene.instance()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation	
		
