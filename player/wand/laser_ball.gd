extends CharacterBody2D

var direction = Vector2.RIGHT

@export var spd = 300

func _ready():
	direction = Vector2.RIGHT.rotated(global_rotation)

func _physics_process(delta):
	velocity = direction * spd
	move_and_slide()

func _on_hurtbox_component_area_entered(area: Area2D) -> void:
	print(area.get_parent())
	$hurtboxComponent.hurt(area)

func _on_collision_body_entered(body: Node2D) -> void:
	queue_free()

func _on_collision_area_entered(area: Area2D) -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_hurt_box_dealt_damage(target: HitBox) -> void:
	queue_free()
