class_name AbilityManager extends Node2D

var abilities:Dictionary = {}

func _ready() -> void:
	for i in get_children():
		abilities[i.corruption] = i
