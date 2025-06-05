extends Node2D

@onready var player:Player = get_tree().get_first_node_in_group("player")
@onready var label:Label = $Label

var active_interactables:Array = []
var can_interact:bool = true

var base_text:String = "E to "


func _process(_delta: float) -> void:
	if active_interactables.size() > 0 and can_interact:
		active_interactables.sort_custom(sort_by_distance) #sorts by closest interactable object -> most distant
		label.text = base_text + active_interactables[0].action_name
		label.global_position = active_interactables[0].get_parent().global_position
		label.show()
	else:
		label.hide()


func start_dialogue(dialogue: DialogueResource, title: String) -> void:
	const BALLOON := preload("res://dialogue/balloon.tscn")
	DialogueManager.show_dialogue_balloon_scene(BALLOON, dialogue, title)
	await DialogueManager.dialogue_ended


func register_interactable(object:Interactable):
	active_interactables.push_back(object)

func unregister_interactable(object:Interactable):
	var index = active_interactables.find(object)
	if index != -1:
		active_interactables.remove_at(index)

func sort_by_distance(interact1,interact2):
	var interact1_to_player = player.global_position.distance_to(interact1.global_position)
	var interact2_to_player = player.global_position.distance_to(interact2.global_position)
	return interact1_to_player > interact2_to_player

func _input(event: InputEvent) -> void: #calls the interact function of the object
	if event.is_action_pressed("interact") and can_interact:
		if active_interactables.size() > 0:
			print('1')
			can_interact = false
			label.hide()

			await active_interactables[0].Interact.call(player)

			can_interact = true
