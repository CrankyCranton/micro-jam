extends Area2D

var player:Player

var old_speed:float

@export var new_speed:float

func _on_body_entered(body: Node2D) -> void:
	player = body
	old_speed = player.SPEED
	var pos:Vector2 = player.global_position

	enable_particles(pos)

	player.SPEED = new_speed


func _on_body_exited(body: Node2D) -> void:
	player = body
	player.SPEED = old_speed

	var pos:Vector2 = player.global_position
	enable_particles(pos)

func enable_particles(pos:Vector2):
	$GPUParticles2D.global_position = pos
	$GPUParticles2D.emitting = true
