extends Node
class_name Interactable


var interact:Callable = func(_player: Player):
	pass #Callable func that gets overriden by the actual function to be called by the actual Interactable object

@onready var label: Label = $Label


func set_popup_visible(visible: bool) -> void:
	label.visible = visible
