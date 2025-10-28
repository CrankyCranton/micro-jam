class_name Sacrifice extends Ability


func _execute() -> void:
	owner.corruption += owner.hit_box.max_health - owner.hit_box.health
	owner.hit_box.health = owner.hit_box.max_health
