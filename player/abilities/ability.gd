class_name Ability extends Node2D


#region Members
signal executed(ability_name: StringName)

@export var action := &""
#endregion


#region Functions
func _ready() -> void:
	if owner != null:
		_initialize()


func _input(event: InputEvent) -> void:
	if action != &"" and event.is_action_pressed(action):
		_execute()
		executed.emit(name)


func _execute() -> void:
	pass


func _initialize() -> void:
	pass
#endregion
