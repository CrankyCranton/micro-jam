class_name Interactable extends Area2D


@export var force_interaction := false

@onready var label: Label = $Label


func _interact(_player: Player) -> void:
	pass


@warning_ignore("shadowed_variable_base_class")
func set_popup_visible(visible: bool) -> void:
	label.visible = visible
