# TBD Perhaps make Interactable intitiate the ineraction if force_interaction == true
# If so, Interactable should also handle showing it's label locally.
class_name Interactable extends Area2D


#region Members
@export var force_interaction := false

@onready var label: Label = $Label
#endregion


#region Functions
func _interact(_player: Player) -> void:
	pass


@warning_ignore("shadowed_variable_base_class")
func set_popup_visible(visible: bool) -> void:
	label.visible = visible
#endregion
