class_name Player extends CharacterBody2D

@onready var AbilityManager:Node2D = $AbilityManager

var SPEED := 160.0
const JUMP_VELOCITY := 320.0
const TRACTION := 11.0
const AIR_TRACTION := 4.0
const DEADZONE := 0.2

var corruption := 0:
	set(value):
		corruption = value

@onready var camera: Camera2D = $Camera


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_VELOCITY

	var direction := Input.get_axis(&"left", &"right")
	if absf(direction) <= DEADZONE:
		direction = 0.0

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x , direction * SPEED, traction * delta)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Ability_1") and AbilityManager.abilities[0]:
		AbilityManager.abilities[0].execute(self)

	elif event.is_action_pressed("Ability_2") and AbilityManager.abilities[1]:
		AbilityManager.abilities[1].execute(self)

	elif event.is_action_pressed("Ability_3") and AbilityManager.abilities[2]:
		print("pressed")
		AbilityManager.abilities[2].execute(self)

func _on_hit_box_damage_taken(damage: int) -> void:
	corruption += damage
