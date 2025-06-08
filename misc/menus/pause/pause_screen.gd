class_name PauseMenu extends CanvasLayer


var ability_data := {
	preload("res://player/abilities/wand/wand.tscn"):
		get_ability_description("Wand", "Hold down [img]res://assets/inputs_b.png[/img] to charge. Release to fire."),
	preload("res://player/abilities/dash/warp/warp.tscn"):
		get_ability_description("Warp", "Press [img]res://assets/inputs_v.png[/img] to warp forwards.",  "With this newfound power, I will chase after you to the ends of the earth"),
	preload("res://player/abilities/sacrifice/sacrifice.tscn"):
		get_ability_description("sacrifice", "Press [img]res://assets/inputs_c.png[/img] to sacrifice corruption for health."),
	preload("res://player/abilities/spiritual_chains/spiritual_chains.tscn"):
		get_ability_description("Spiritual Chains", "Press [img]res://assets/inputs_e.png[/img] to enslave a nearby NPC, at the cost of corruption."),
	preload("res://player/abilities/resurrection/resurrection.gd"):
		get_ability_description("Resurrection", "Press [img]res://assets/inputs_e.png[/img] to resurrect from the grave."),
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


func display_ability(ABILITY: PackedScene) -> void:
	ability_display.show()
	pause_menu.hide()
	ability_text.text = ability_data[ABILITY]
	await set_paused(true)
	await get_tree().process_frame
	ok_button.grab_focus()


func _on_quit_pressed() -> void:
	get_tree().quit()
	#set_paused(false)
	#get_tree().change_scene_to_file("res://misc/menus/main/main_menu.tscn")


static func get_ability_description(title: String, instructions := "",
		flavor_text := "",) -> String:
	title = "[font_size=16][center][b]%s[/b][/center][/font_size]\n\n" % title
	flavor_text = "[i]%s[/i]\n\n" % flavor_text
	instructions = "%s" % instructions
	return title + flavor_text + instructions
