class_name Boss extends HitBox


@export var rampage_hp := 300

@onready var hit_box: HitBox = $HitBox
@onready var animation_tree: AnimationTree = $AnimationTree


#region Functions
func activate() -> void:
	animation_tree.active = true


func spawn_bullet(bullet_transform: Transform2D, BULLET: PackedScene) -> void:
	var bullet: Node2D = BULLET.instantiate()
	bullet.global_transform = bullet_transform
	get_tree().current_scene.add_child(bullet)


func spawn_bullet_at_node(node: Node2D, BULLET: PackedScene) -> void:
	spawn_bullet(node.global_transform, BULLET)


func die() -> void:
	died.emit()
	queue_free()
#endregion
