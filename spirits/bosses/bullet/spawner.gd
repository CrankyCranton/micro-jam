class_name Spawner extends Node2D

@onready var spawn:PackedScene = preload("res://spawn.tscn")
@export var bullet_scene:PackedScene
@onready var shoot_timer:Timer = $ShootTimer

@export_group("bullet")
@export var rotate_speed:int
@export var shoot_timer_wait_time:int

@export_group("spawning")
@export var spawn_point_count:int
@export var radius:int

func _ready():
	var step = 2 * PI / spawn_point_count
	print(global_position)
	
	var pos:Vector2
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.rotation = pos.angle()
		%Bullets.add_child(spawn_point)

	await get_tree().create_timer(1).timeout
	for i in %Bullets.get_children():
		i.position = pos
		if i.position != global_position:
			i.global_position = pos
			print("noo")
		print(i.global_position)

	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()


func _process(delta):
	var new_rotation = rotation_degrees + rotate_speed * delta
	rotation_degrees = fmod(new_rotation, 360)
	

func _on_shoot_timer_timeout() -> void:
	for s in %Bullets.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
	shoot_timer.start()
