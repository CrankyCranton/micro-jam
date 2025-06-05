class_name Sacrifice extends Ability


func _execute() -> void:
	owner.corruption += owner.max_health - owner.health
	owner.health = owner.max_health
