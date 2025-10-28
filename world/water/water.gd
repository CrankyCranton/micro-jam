class_name Water extends Area2D


@export var speed_modifier := 0.5


#region Functions
func spawn_splash(x: float) -> void:
	const SPLASH := preload("res://world/water/splash.tscn")
	var splash: GPUParticles2D = SPLASH.instantiate()
	splash.position.x = x
	add_child(splash)


#region Callbacks
func _on_body_entered(body: Node2D) -> void:
	body.speed *= speed_modifier
	spawn_splash(to_local(body.global_position).x)


func _on_body_exited(body: Node2D) -> void:
	body.speed /= speed_modifier
#endregion
#endregion
