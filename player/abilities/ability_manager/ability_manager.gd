extends Node2D

var abilities:Array = []

func _ready() -> void:
	for i in get_children():
		abilities.append(i)
