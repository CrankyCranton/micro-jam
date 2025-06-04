extends Ability
class_name Resurrection

@onready var cooldown:Timer = $Timer

@export var percentage:float

func _ready() -> void:
	_execute()

func _execute():
	if cooldown.is_stopped():
		print("yo yo yo")
		var new_health:int = (percentage/100) * owner.health
		owner.health = new_health
		cooldown.start()

func _on_timer_timeout() -> void:
	cooldown.stop() # I have to put something man
