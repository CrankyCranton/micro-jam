class_name EvilSpirit extends CharacterBody2D


signal died

@export_group("Movement")
@export var speed := 32.0
@export var traction := 5.0
@export var soft_collider_strength := 32.0
@export var desired_distance := 16.0

var player: Player

@onready var sprite: Sprite2D = $Sprite
@onready var soft_collider: SoftCollider = $SoftCollider
@onready var nav_agent:NavigationAgent2D = $NavigationAgent2D


func _physics_process(delta: float) -> void:
	assert(player)
	follow_target(player, delta)
	sprite.flip_h = velocity.x < 0


func follow_target(target: Node2D, delta: float) -> void:
	var direction := Vector2()
	var soft_velocity := soft_collider.get_vector() * soft_collider_strength

	nav_agent.target_position = target.global_position
	if nav_agent.distance_to_target() > desired_distance:
		direction = global_position.direction_to(nav_agent.get_next_path_position())

	velocity = velocity.lerp(direction * speed + soft_velocity, traction * delta)
	move_and_slide()


func die() -> void:
	queue_free()
	died.emit()


func _on_hurt_box_dealt_damage(_target: HitBox, _damage: int) -> void:
	die()


func _on_hit_box_died() -> void:
	die()


func _on_hit_box_damage_taken(_damage: int) -> void:
	pass # Replace with function body.
