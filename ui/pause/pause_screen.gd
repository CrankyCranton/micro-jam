class_name PauseMenu extends CanvasLayer


#region Members
@onready var pause_menu: PanelContainer = $PauseMenu
@onready var quit: Button = %Quit
@onready var ability_display: VBoxContainer = $AbilityDisplay
@onready var ability_text: RichTextLabel = %AbilityText
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var ok_button: Button = %OKButton
#endregion


#region Functions
#region Overrides
func _ready() -> void:
	if OS.get_name() == "Web":
		quit.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		set_paused(not get_tree().paused)
#endregion


#region Methods
func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	animation.play(&"blur" if paused else &"unblur")
	await animation.animation_finished


func display_ability(ability_info: AbilityInfo) -> void:
	ability_display.show()
	pause_menu.hide()
	ability_text.text = ability_info.get_text()
	await set_paused(true)
	await get_tree().process_frame
	ok_button.grab_focus()
#endregion


func _on_quit_pressed() -> void:
	get_tree().quit()
	#set_paused(false)
	#get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")
#endregion
