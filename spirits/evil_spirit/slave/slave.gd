class_name Slave extends EvilSpirit


@onready var hit_box: HitBox = $HitBox


func _ready() -> void:
	hit_box.remove_from_group(&"evil_spirits")


func _physics_process(delta: float) -> void:
	if get_tree().get_node_count_in_group(&"evil_spirits") > 0:
		var spirits: Array[Node] = get_tree().get_nodes_in_group(&"evil_spirits")
		spirits.sort_custom(InteractionManager.sort_by_distance) # Used your code :p
		follow_target(spirits.front(), delta)
	else:
		follow_target(player, delta)


func die() -> void:
	pass # Slaves can't die.
