extends Area2D
class_name Interactable


@onready var label: Label = $Label


func _interact() -> void:
	pass


func set_popup_visible(visible: bool) -> void:
	label.visible = visible
