class_name DrumEnemy extends CharacterBody2D


var facing_left:bool
var direction:int = 1

signal died

@export_group("Movement")
@export var speed := 32.0
@export var traction := 5.0
@export var soft_collider_strength := 32.0
@export var desired_distance := 16.0

@onready var player: Player = get_tree().get_first_node_in_group("player")
var dead := false

@onready var sprite: Sprite2D = $Sprite2D
#@onready var soft_collider: SoftCollider = $SoftCollider
@onready var nav_agent:NavigationAgent2D = $NavigationAgent2D
@onready var animation:AnimationPlayer = $AnimationPlayer
@onready var hitbox:HitBox = $HitBox


func _process(delta: float) -> void:
	assert(player)
	move(delta)
	flip()
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func flip() -> void:
	if player.global_position.x < global_position.x and not facing_left:
		direction = -1
		animation.play(&"flip_left")
		facing_left = true
		print(speed * direction)

	elif player.global_position.x > global_position.x and facing_left:
		direction = 1
		animation.play(&"flip_right")
		facing_left = false
		print(speed * direction)

func move(_delta):
	velocity.x = speed * direction
