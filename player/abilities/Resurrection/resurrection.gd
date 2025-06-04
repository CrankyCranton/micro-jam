extends Ability
class_name RessurectAbility

@export var percentage:int

func _ready() -> void:
	_execute()

func _execute():
	var new_health:int = (percentage/100) * owner.health
	print(new_health)
