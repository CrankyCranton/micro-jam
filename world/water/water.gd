class_name Water extends Area2D


#region Functions
func spawn_splash(x: float) -> void:
	const SPLASH := preload("res://world/water/splash.tscn")
	var splash: GPUParticles2D = SPLASH.instantiate()
	splash.position.x = x
	add_child(splash)


#region Callbacks
func _on_body_entered(player: Player) -> void:
	player.set_state(&"water")


func _on_body_exited(player: Player) -> void:
	player.set_state(&"default")
#endregion
#endregion
