class_name Blockade extends StaticBody2D


func _on_hit_box_died() -> void:
	queue_free()
