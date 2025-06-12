class_name EvilSpirit extends CharacterBody2D


var facing_left:bool

signal died

@export_group("Movement")
@export var speed := 32.0
@export var traction := 5.0
@export var soft_collider_strength := 32.0
@export var desired_distance := 16.0

var player: Player
var dead := false

@onready var sprite: Sprite2D = $Sprite
@onready var soft_collider: SoftCollider = $SoftCollider
@onready var nav_agent:NavigationAgent2D = $NavigationAgent2D
@onready var animation:AnimationPlayer = $AnimationPlayer
@onready var hitbox:HitBox = $HitBox


func _physics_process(delta: float) -> void:
	assert(player)
	follow_target(player, delta)
	flip()


func follow_target(target: Node2D, delta: float) -> void:
	var direction := Vector2()
	var soft_velocity := soft_collider.get_vector() * soft_collider_strength

	nav_agent.target_position = target.global_position
	if nav_agent.distance_to_target() > desired_distance:
		direction = global_position.direction_to(nav_agent.get_next_path_position())

	velocity = velocity.lerp(direction * speed + soft_velocity, traction * delta)
	move_and_slide()


func die(anim_name: StringName) -> void:
	if not dead:
		animation.play(anim_name)
		dead = true

		await animation.animation_finished
		# Putting it here to reduce redundancy in animations.
		queue_free()
		died.emit()


func _on_hurt_box_dealt_damage(_target: HitBox, _damage: int) -> void:
	die(&"attack")


func _on_hit_box_died() -> void:
	die(&"death")


func _on_hit_box_damage_taken(_damage: int) -> void:
	if hitbox.health > 0:
		animation.play(&"hit")


func flip() -> void:
	if velocity.x < 0 and not facing_left:
		animation.play(&"flip_left")
		facing_left = true

	elif velocity.x > 0 and facing_left:
		animation.play(&"flip_right")
		facing_left = false
