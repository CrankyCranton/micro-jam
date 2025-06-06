class_name Scenario extends Area2D


signal finished

const FINAL_NAME := &"final"

@export var max_spawns := 1
@export var ability: PackedScene
@export_group("Dialogue")
@export var dialogue: DialogueResource
@export var title := ""

var total_spawned := 0
var current_spawned := 0
var animations: PackedStringArray
var has_final := false
var player: Player

@onready var spawn_points: Node2D = $SpawnPoints
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var spawn_patterns: AnimationPlayer = $SpawnPatterns
@onready var barriers:StaticBody2D = $Barriers


func _ready() -> void:
	animations = spawn_patterns.get_animation_list()
	if animations.has(FINAL_NAME):
		has_final = true
		animations.remove_at(animations.find(FINAL_NAME))

	for spirit_spawn_point: SpiritSpawnPoint in spawn_points.get_children():
		spirit_spawn_point.spawned.connect(_on_spirit_spawn_point_spawned)


func end() -> void:
	if ability != null:
		player.add_ability(ability)
	set_barriers_enabled(false)

	player.set_enabled(false)
	# TODO: Make a few seconds delay to transition to daytime and stuff.
	if title != "":
		await InteractionManager.start_dialogue(dialogue, title)
	finished.emit()
	#queue_free()


func play_random() -> void:
	spawn_patterns.play(animations[randi() % animations.size()])


func _on_body_entered(player: Player) -> void:
	if Global.met_shady_guy:
		self.player = player
		collision_shape.set_deferred(&"disabled", true)
		#max_spawns += player.corruption

		for spirit_spawn_point: SpiritSpawnPoint in spawn_points.get_children():
			spirit_spawn_point.player = player
		set_barriers_enabled(true)

		play_random()


func _on_spirit_spawn_point_spawned(spawn: EvilSpirit) -> void:
	total_spawned += 1
	current_spawned += 1
	spawn.died.connect(_on_evil_spirit_died)


func _on_evil_spirit_died() -> void:
	current_spawned -= 1
	# This could be prone to errors of the final animation caontains whitespace at the end.
	# It assumes that if spawn_patterns is playing, there must be more to be spawned.
	if current_spawned <= 0 and not spawn_patterns.is_playing():
		end()


func _on_spawn_patterns_animation_finished(anim_name: StringName) -> void:
	if anim_name != FINAL_NAME:
		if total_spawned >= max_spawns:
			if has_final:
				spawn_patterns.play(FINAL_NAME)
		else:
			play_random()


func set_barriers_enabled(enabled: bool) -> void:
	for barrier: CollisionShape2D in barriers.get_children():
		barrier.set_enabled(enabled)
