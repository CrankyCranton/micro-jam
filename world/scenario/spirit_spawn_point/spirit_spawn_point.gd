@tool
class_name SpiritSpawnPoint extends Marker2D


signal spawned(spawn: EvilSpirit)

@export var spawn := false:
	set(_value):
		if not Engine.is_editor_hint():
			const EVIL_SPIRIT := preload("res://spirits/evil_spirit/evil_spirit.tscn")
			var evil_spirit: EvilSpirit = EVIL_SPIRIT.instantiate()
			evil_spirit.player = player
			add_child(evil_spirit)
			spawned.emit(evil_spirit)

var player

@onready var label: Label = $Label


func _ready() -> void:
	if not Engine.is_editor_hint():
		label.hide()
		set_process(false)


func _process(_delta: float) -> void:
	label.text = str(get_index())
	#name = str(get_index())
