extends Node2D
class_name Ability


@export var corruption := 0
@export var action := &""

@onready var player: Player = owner


func _ready() -> void:
	set_process_input(false) # Disable


func _process(delta: float) -> void:
	if _trigger():
		pass


func _trigger() -> bool:
	return Input.is_action_just_pressed(action)
