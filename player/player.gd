class_name Player extends CharacterBody2D


const SPEED := 160.0
const JUMP_VELOCITY := 320.0
const TRACTION := 11.0
const AIR_TRACTION := 4.0
const DEADZONE := 0.2


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_VELOCITY

	var direction := Input.get_axis(&"left", &"right")
	if absf(direction) <= DEADZONE:
		direction = 0.0

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x, direction * SPEED, traction * delta)

	move_and_slide()
