class_name Spirit extends CharacterBody2D


#region Members
signal died

#region Export
@export_group("Movement")
@export var speed := 32.0
@export var traction := 5.0
@export var soft_collider_strength := 32.0
@export var noise_influence := 10.0
@export var desired_distance := 16.0
#endregion

#region Variables
var player: Player
var dead := false
var facing_left: bool
#endregion

#region Onready
@onready var sprite: Sprite2D = $Sprite
@onready var soft_collider: SoftCollider = $SoftCollider
@onready var navigation:NavigationAgent2D = $NavigationAgent2D
@onready var animation:AnimationPlayer = $AnimationPlayer
@onready var hitbox:HitBox = $HitBox
#endregion
#endregion


#region Functions
func _physics_process(delta: float) -> void:
	assert(player)
	follow_target(player, delta)
	flip()


#region Methods
func follow_target(target: CharacterBody2D, _delta: float):
	var direction = Vector2()

	navigation.target_position = target.global_position
	direction = navigation.get_next_path_position() - global_position
	direction = direction.normalized()

	velocity = velocity.move_toward(direction * speed,traction)
	move_and_slide()


func follow_target_noise(_target: Node2D, delta: float) -> void:

	var direction := Vector2()
	#nav_agent.target_position = target.global_position
	#if nav_agent.distance_to_target() > desired_distance:
		#direction = global_position.direction_to(nav_agent.get_next_path_position())

	var soft_velocity := soft_collider.get_vector() * soft_collider_strength

	var noise_velocity := Vector2()
	#var current_noise := 1.0
	#var total_noise := 0.0
	#var total_noise_vector:Vector2 = Vector2(0,0)
	#for y in range(-1, 2):
		#for x in range(-1, 2):
			#if x == 0 and y == 0: # Skips scanning the spirit's current location
				#continue
			#else:
				#var noise_value: float = get_noise.call(position.x + x, position.y + y)
				#if noise_value < current_noise:
					#current_noise = noise_value
					#noise_velocity = Vector2(x,y)
				#total_noise += noise_value * noise_influence
	#noise_velocity *= total_noise - current_noise

	velocity = velocity.lerp(direction * speed + soft_velocity + noise_velocity, traction * delta)
	move_and_slide()


func die(anim_name: StringName) -> void:
	if not dead:
		animation.play(anim_name)
		dead = true

		await animation.animation_finished
		# Putting it here to reduce redundancy in animations.
		queue_free()
		died.emit()


func flip() -> void:
	if velocity.x < 0 and not facing_left:
		animation.play(&"flip_left")
		facing_left = true

	elif velocity.x > 0 and facing_left:
		animation.play(&"flip_right")
		facing_left = false
#endregion


#region Callbacks
func _on_hurt_box_dealt_damage(_target: HitBox, _damage: int) -> void:
	die(&"attack")


func _on_hit_box_died() -> void:
	die(&"death")


func _on_hit_box_health_changed(_damage: int) -> void:
	if hitbox.health > 0:
		animation.play(&"hit")

#endregion
#endregion
