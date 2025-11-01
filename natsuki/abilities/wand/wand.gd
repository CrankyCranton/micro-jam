class_name Wand extends Ability


#region Members
#region Export
@export_group("animate")
@export var speed := 0
@export var damage := 0
@export var laser := false
#endregion

#region Variables
var holding := false
var cooling := false
#endregion

#region Onready
@onready var tip: Marker2D = $Tip
@onready var shape: Shape2D = %Size.shape
@onready var cooldown: Timer = $Cooldown
@onready var explode_delay: Timer = $ExplodeDelay
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#endregion
#endregion


#region Functions
#region Overrides
func _initialize() -> void:
	position = owner.center.position


func _input(event: InputEvent) -> void:
	if event.is_action_released(&"zap") and holding:
		holding = false
		_execute()


func _process(_delta: float) -> void:
	if Input.is_action_pressed(&"zap") and not (cooling or holding):
		holding = true
		animation_player.play(&"charge")

	if owner.can_turn:
		const ORBIT_DISTANCE := 16.0
		var mouse := get_global_mouse_position()
		tip.global_transform = global_transform.looking_at(mouse)
		tip.position = global_position.direction_to(mouse) * ORBIT_DISTANCE


func _execute() -> void:
	explode_delay.stop()
	animation_player.play(&"RESET")
	cooling = true
	const KICKBACK := 200.0
	owner.velocity += KICKBACK * (global_position - get_global_mouse_position()).normalized()

	if laser:
		owner.can_turn = false
		const LASER := preload("res://natsuki/abilities/wand/laser/laser.tscn")
		var laser: Laser = LASER.instantiate()
		tip.add_child(laser)
		await laser.tree_exited
		owner.can_turn = true
		cooling = false
	else:
		const BULLET := preload("res://natsuki/abilities/wand/witch_bolt/witch_bolt.tscn")
		var bullet: Area2D = BULLET.instantiate()
		bullet.transform = tip.global_transform
		bullet.speed = speed
		get_tree().current_scene.add_child(bullet)
		bullet.total_damage = damage
		bullet.shape = shape.duplicate()

		cooldown.start()
#endregion


#region Methods
func start_explode_chance(time_range: float) -> void:
	const CHANCE := 0.15
	if randf() <= CHANCE:
		var time := randf_range(0.0, time_range)
		explode_delay.start(time)


func explode() -> void:
	const EXPLOSION := preload("res://natsuki/abilities/wand/explosion/explosion.tscn")
	var explosion: HurtBox = EXPLOSION.instantiate()
	explosion.position = tip.global_position
	get_tree().current_scene.add_child(explosion)

	cooldown.start()
	animation_player.play(&"RESET")
	holding = false
#endregion


#region Callbacks
func _on_explode_delay_timeout() -> void:
	explode()


func _on_cooldown_timeout() -> void:
	cooling = false
#endregion
#endregion
