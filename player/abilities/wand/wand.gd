class_name Wand extends Ability


@onready var tip: Marker2D = $Tip
@onready var cooldown: Timer = $Cooldown


func _process(_delta: float) -> void:
	tip.transform.x.x = player.last_direction
	if Input.is_action_pressed(&"zap") and cooldown.is_stopped():
		_execute()


func _input(_event: InputEvent) -> void:
	pass


func _execute() -> void:
	cooldown.start()
	var BULLET := preload("res://player/abilities/wand/bullet/bullet.tscn")
	var bullet: Area2D = BULLET.instantiate()
	bullet.direction = tip.transform.x.x
	bullet.position = tip.global_position
	get_tree().current_scene.add_child(bullet)
