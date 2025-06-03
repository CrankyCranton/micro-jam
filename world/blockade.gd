class_name Blockade extends StaticBody2D


func _on_hit_box_damage_taken(_damage: int) -> void:
	queue_free()
