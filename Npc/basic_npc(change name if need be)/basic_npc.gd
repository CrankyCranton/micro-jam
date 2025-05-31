extends CharacterBody2D

@onready var player:Player = get_tree().get_first_node_in_group("player")
@onready var nav_agent:NavigationAgent2D = $NavigationAgent2D

@export var speed:int
@export var acceleration:int
@export var max_distance_from_player:int

enum states {
	idle,
	walk_around,
	minion_idle,
	minion_move,
	minion_attack
}

var STATE:states = states.minion_move


func _physics_process(delta: float) -> void:
	match STATE:
		states.idle:
			idle()
		states.walk_around:
			pass
		states.minion_move:
			minion_move()
		states.minion_attack:
			minion_attack()
		states.minion_idle:
			minion_idle()
	move_and_slide()

#region state functions
func idle():
	pass

func minion_move():
	if player:
		var direction = Vector2()

		nav_agent.target_position = player.global_position
		direction = nav_agent.get_next_path_position() - global_position
		direction = direction.normalized()

		velocity = Vector2.ZERO
		velocity = velocity.move_toward(direction * speed,acceleration)

		if nav_agent.distance_to_target() < max_distance_from_player:
			STATE = states.minion_idle

func minion_attack():
	pass

func minion_idle():
	velocity = Vector2.ZERO
	nav_agent.target_position = player.global_position
	if nav_agent.distance_to_target() > max_distance_from_player:
		STATE = states.minion_move
#endregion
