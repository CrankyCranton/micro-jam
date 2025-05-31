class_name EvilSpirit extends CharacterBody2D


signal died

@export_group("Combat")
@export var damage := 1
@export var health := 1
@export_group("Movement")
@export var speed := 32.0
@export var traction := 5.0
@export var soft_collider_strength := 16.0

var player: Player

@onready var soft_collider: SoftCollider = $SoftCollider


func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(player.global_position)
	var soft_velocity := soft_collider.get_vector()
	velocity = velocity.lerp(direction * speed + soft_velocity, traction * delta)
	move_and_slide()


func die() -> void:
	died.emit()
	queue_free()


func _on_hit_box_damage_taken(damage: int) -> void:
	health -= damage
	if health <= 0:
		die()


func _on_hurt_box_dealt_damage(_target: HitBox) -> void:
	die()
