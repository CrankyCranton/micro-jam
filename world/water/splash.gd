class_name Splash extends GPUParticles2D


#region Functions
func _ready() -> void:
	emitting = true


func _on_finished() -> void:
	queue_free()
#endregion
