class_name Boss extends HitBox


#region Members
@export var rampage_hp := 300

#region Onready
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var health_bar: ProgressBar = %HealthBar
#endregion
#endregion


#region Functions
func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = health


#region Methods
func activate() -> void:
	animation_tree.active = true


func spawn_bullet(bullet_transform: Transform2D, BULLET: PackedScene) -> void:
	var bullet: Node2D = BULLET.instantiate()
	bullet.global_transform = bullet_transform
	get_tree().current_scene.add_child(bullet)


func spawn_bullet_at_node(node: Node2D, BULLET: PackedScene) -> void:
	spawn_bullet(node.global_transform, BULLET)
#endregion


func _on_health_changed(_damage: int) -> void:
	health_bar.value = health
#endregion
