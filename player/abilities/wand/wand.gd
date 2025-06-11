class_name Wand extends Ability

@export_group("animate")
@export var speed := 0
@export var damage := 0
@export var laser := false

var holding := false
var cooling := false

@onready var tip: Marker2D = $Tip
@onready var cooldown: Timer = $Cooldown
@onready var explode_delay: Timer = $ExplodeDelay
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shape: Shape2D = %Size.shape
@onready var direction: Sprite2D = $Direction


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"zap") and not cooling:
		holding = true
		animation_player.play(&"charge")
	if event.is_action_released(&"zap") and holding:
		holding = false
		_execute()


func _process(delta: float) -> void:
	var mouse:Vector2 = get_global_mouse_position()
	
	tip.look_at(mouse)
	direction.look_at(mouse)
	direction.global_position = global_position + (mouse - global_position).limit_length(20)

func _execute() -> void:
	explode_delay.stop()
	animation_player.play(&"RESET")
	#transform.x.x = player.last_direction
	cooling = true

	if laser:
		player.turning_enabled = false
		const LASER := preload("res://player/abilities/wand/laser/laser.tscn")
		var laser: Laser = LASER.instantiate()
		add_child(laser)
		await laser.tree_exited
		player.turning_enabled = true
		cooling = false
	else:
		const BULLET := preload("res://player/abilities/wand/bullet/bullet.tscn")
		var bullet: Area2D = BULLET.instantiate()
		bullet.global_rotation = tip.global_rotation
		bullet.position = tip.global_position
		bullet.speed = speed
		get_tree().current_scene.add_child(bullet)
		bullet.total_damage = damage
		bullet.shape = shape.duplicate()

		cooldown.start()


func start_explode_chance(time_range: float) -> void:
	const CHANCE := 0.1
	if randf() <= CHANCE:
		var time := randf_range(0.0, time_range)
		explode_delay.start(time)


func explode() -> void:
	const EXPLOSION := preload("res://player/abilities/wand/explosion/explosion.tscn")
	var explosion: HurtBox = EXPLOSION.instantiate()
	explosion.position = tip.global_position
	get_tree().current_scene.add_child(explosion)

	cooldown.start()
	animation_player.play(&"RESET")
	holding = false


func _on_explode_delay_timeout() -> void:
	explode()


func _on_cooldown_timeout() -> void:
	cooling = false
