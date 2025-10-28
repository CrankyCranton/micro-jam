class_name Bullet extends Area2D


#region Members
#region Export
@export var speed := 128.0
@export var shape: Shape2D:
	set(value):
		shape = value
		if not is_node_ready():
			await ready

		collision_shape.shape = shape
		hurt_box.collision_shape.shape = shape
		visibility_notifier.rect.position = -shape.radius
		visibility_notifier.rect.size = Vector2.ONE * shape.radius * 2.0
@export var total_damage: int:
	set(value):
		total_damage = value
		damage = total_damage
@export var wall_damage := 30
#endregion

var damage: float:
	set(value):
		if not is_node_ready():
			await ready
		damage = value
		modulate.a = float(damage) / total_damage
		hurt_box.damage = ceili(damage)
		if damage <= 0:
			delete()

@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var hurt_box: HurtBox = $HurtBox
@onready var visibility_notifier: VisibleOnScreenNotifier2D = $VisibilityNotifier
#endregion


#region Functions
func _physics_process(delta: float) -> void:
	move(delta)


#region Methods
func move(delta: float) -> void:
	position += transform.x * speed * delta
	if get_overlapping_bodies().size() > 0:
		damage -= wall_damage * delta


func delete() -> void:
	queue_free()
#endregion


#region Callbacks
func _on_hurt_box_dealt_damage(_target: HitBox, damage: int) -> void:
	self.damage -= damage


func _on_visibility_notifier_screen_exited() -> void:
	delete()
#endregion
#endregion
