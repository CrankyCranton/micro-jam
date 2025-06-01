extends Ability

@onready var ray:RayCast2D = $RayCast2D
@onready var cooldown:Timer = $Cooldown

@export var max_length:int

var can_dash:bool = true

func _process(delta: float) -> void:
	if can_dash == true:
		ray.target_position = ray.to_local(get_global_mouse_position()).limit_length(max_length)


func execute(player:Player):
	if ray.is_colliding() == false and can_dash == true:
		can_dash = false
		player.global_position = ray.target_position
		cooldown.start()

func _on_cooldown_timeout() -> void:
	can_dash = true
