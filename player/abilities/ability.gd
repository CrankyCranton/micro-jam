class_name Ability extends Node2D


@export var action := &""


func _input(event: InputEvent) -> void:
	if action != &"" and event.is_action_pressed(action):
		_execute()


func _execute() -> void:
	pass
