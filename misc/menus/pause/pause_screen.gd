class_name PauseMenu extends CanvasLayer


const ABILITY_DATA := {
	preload("res://player/abilities/wand/wand.tscn"):
		"",
	preload("res://player/abilities/dash/warp/warp.tscn"):
		"",
	preload("res://player/abilities/sacrifice/sacrifice.tscn"):
		"",
	preload("res://player/abilities/spiritual_chains/spiritual_chains.tscn"):
		"",
	preload("res://player/abilities/resurrection/resurrection.gd"):
		"",
}

@onready var pause_menu: PanelContainer = $PauseMenu
@onready var quit: Button = %Quit
@onready var ability_display: VBoxContainer = $AbilityDisplay
@onready var ability_text: RichTextLabel = %AbilityText
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var ok_button: Button = %OKButton


func _ready() -> void:
	if OS.get_name() == "Web":
		quit.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		set_paused(not get_tree().paused)


func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	animation.play(&"blur" if paused else &"unblur")
	await animation.animation_finished
	ok_button.grab_focus()


func display_ability(ABILITY: PackedScene) -> void:
	ability_display.show()
	pause_menu.hide()
	ability_text.text = ABILITY_DATA[ABILITY]
	await set_paused(true)


func _on_quit_pressed() -> void:
	get_tree().quit()
	#set_paused(false)
	#get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
