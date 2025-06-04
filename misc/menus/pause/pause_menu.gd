extends Control

@onready var animation:AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	hide()

func pause():
	show()
	$AnimationPlayer.play("blur")
	get_tree().paused = true

func unpause():
	get_tree().paused = false
	hide()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			pause()
		elif get_tree().paused == true:
			unpause()

func _on_resume_pressed() -> void:
	unpause()

func _on_quit_pressed() -> void:
	unpause()
	get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
