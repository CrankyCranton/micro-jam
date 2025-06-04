extends Control

@onready var animation:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()

func pause():
	$AnimationPlayer.play("blur")
	get_tree().paused = true

func unpause():
	get_tree().paused = false
	hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()
	if Input.is_action_just_pressed("pause") and get_tree().paused == true:
		unpause()
