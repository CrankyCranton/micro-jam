class_name Ability extends Node2D


signal executed(ability_name: StringName)

@export var action := &""

@onready var player: Player = get_tree().get_first_node_in_group(&"player")


func _input(event: InputEvent) -> void:
	if action != &"" and event.is_action_pressed(action):
		_execute()
		executed.emit(name)


func _execute() -> void:
	pass
