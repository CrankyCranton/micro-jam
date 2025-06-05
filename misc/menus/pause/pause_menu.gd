class_name PauseMenu extends CanvasLayer


@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var quit: Button = %Quit


func _ready() -> void:
	if OS.get_name() == "Web":
		quit.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		set_paused(not get_tree().paused)


func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	animation.play(&"blur" if paused else &"unblur")


func _on_resume_pressed() -> void:
	set_paused(false)


func _on_quit_pressed() -> void:
	get_tree().quit()
	#set_paused(false)
	#get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
