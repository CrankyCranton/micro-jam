class_name Laser extends HurtBox


func _on_timer_timeout() -> void:
	queue_free()
