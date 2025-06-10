class_name Wand extends Ability

@export_group("animate")
@export var speed := 0
@export var damage := 0
@export var laser := false

@onready var tip: Marker2D = $Tip
@onready var cooldown: Timer = $Cooldown
@onready var explode_delay: Timer = $ExplodeDelay
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"zap") and cooldown.is_stopped():
		animation_player.play(&"charge")
	if event.is_action_released(&"zap"):
		_execute()


func _execute() -> void:
	explode_delay.stop()
	transform.x.x = player.last_direction

	if laser:
		const LASER := preload()
	else:
		const BULLET := preload("res://player/abilities/wand/bullet/bullet.tscn")
		var bullet: Area2D = BULLET.instantiate()
		bullet.direction = player.last_direction
		bullet.position = tip.global_position
		get_tree().current_scene.add_child(bullet)

	cooldown.start()
	animation_player.play(&"RESET")


func start_explode_chance(time_range: float) -> void:
	const CHANCE := 0.25
	if randf() <= CHANCE:
		var time := randf_range(0.0, time_range)
		explode_delay.start(time)


func explode() -> void:
	const EXPLOSION := preload()


func _on_explode_delay_timeout() -> void:
	explode()
