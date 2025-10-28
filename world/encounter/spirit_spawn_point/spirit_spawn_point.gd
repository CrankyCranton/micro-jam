@tool
class_name SpiritSpawnPoint extends Marker2D


#region Members
signal spawned(spawn: Spirit)

@export var spawn := false:
	set(_value):
		if not Engine.is_editor_hint():
			const SPIRIT := preload("res://spirits/spirit/spirit.tscn")
			var spirit: Spirit = SPIRIT.instantiate()
			spirit.player = player
			add_child(spirit)
			spawned.emit(spirit)

var player: Player

@onready var label: Label = $Label
#endregion


#region Functions
func _ready() -> void:
	if not Engine.is_editor_hint():
		label.hide()
		set_process(false)


func _process(_delta: float) -> void:
	label.text = str(get_index())
	#name = str(get_index())
#endregion
