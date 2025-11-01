class_name Player extends CharacterBody2D


#region Members
#region Signals
signal fully_corrupted
signal ability_gained(ability_info: AbilityInfo)
#endregion

const MAX_CORRUPTION := 5

#region Variables
var speed := Vector2(128.0, 320.0)
var interactable: Interactable = null
var spiritual_chains: SpiritualChains
var resurrection: Resurrection
var can_turn := true
var direction := 0.0:
	set(value):
		direction = value
		if absf(direction) > 0.0 and can_turn:
			last_direction = 1 if direction > 0 else -1
#endregion

#region Onready
@onready var collision_shape: CollisionShape2D = $CollisionShape
@onready var center: Marker2D = $Center
@onready var state_chart: StateChart = $StateChart
@onready var sprite: Sprite2D = $Sprite
@onready var hit_box: HitBox = $HitBox
@onready var interactor: Area2D = $Interactor
@onready var abilities: Node2D = $Abilities
@onready var corruption_meter: CorruptionMeter = %CorruptionMeter
@onready var health_bar: HealthBar = %HealthBar
@onready var grass_footsteps: AudioStreamPlayer2D = %GrassFootsteps
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var corruption := 0:
	set(value):
		corruption = value
		corruption_meter.value = corruption
		if corruption >= MAX_CORRUPTION:
			fully_corrupted.emit()
@onready var last_direction := 1:
	set(value):
		last_direction = value
		sprite.flip_h = last_direction < 0
#endregion
#endregion


#region Functions
#region Overrides
func _ready() -> void:
	health_bar.percent = 1.0
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	corruption_meter.max_value = MAX_CORRUPTION
	DialogueManager.dialogue_started.connect(_on_dialogue_manager_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact") and interactable != null:
		interact()
#endregion


#region Methods
func set_state(state: StringName) -> void:
	state_chart.send_event(state)


func set_immune(immune: bool) -> void:
	hit_box.immune = immune
	if immune:
		hit_box.immunity_time.stop()


func interact(interactable := self.interactable) -> void:
	interactable.set_popup_visible(false)

	if spiritual_chains != null and interactable is NPC:
		spiritual_chains._execute()
	elif resurrection != null and interactable is Gravestone:
		resurrection._execute()
	else:
		interactable._interact(self)


func die() -> void:
	get_tree().paused = true # FIXME
	#get_tree().reload_current_scene()


func scan_interactables() -> void:
	var interactables := get_interactables()
	interactable = interactables.front() if interactables.size() > 0 else null
	for i in interactables.size():
		interactables[i].set_popup_visible(i == 0)


func get_interactables() -> Array[Area2D]:
	var interactables: Array[Area2D] = interactor.get_overlapping_areas()
	interactables.sort_custom(sort_by_distance)
	return interactables


#func set_enabled(enabled: bool) -> void:
	#self.enabled = enabled
	#set_process_input(enabled)
	#for ability in abilities.get_children():
		#ability.set_process_input(enabled)
	#if not enabled:
		#velocity.x = 0.0


func add_ability(ability_info: AbilityInfo) -> void:
	var ability: Ability = ability_info.scene.instantiate()
	abilities.add_child(ability)
	ability.owner = self
	ability._initialize()

	# Perhaps move into the ability scripts
	if ability is SpiritualChains:
		spiritual_chains = ability
		change_interactable_labels(&"npcs", "E to spiritually chain")
	elif ability is Resurrection:
		resurrection = ability
		change_interactable_labels(&"gravestones", "E to resurrect")

	ability_gained.emit(ability_info)


func change_interactable_labels(group: StringName, message: String) -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group(group):
		interactable.label.text = message


func sort_by_distance(a: Node2D, b: Node2D) -> bool:
	return global_position.distance_squared_to(a.global_position) \
			> global_position.distance_squared_to(b.global_position)
#endregion


#region Callbacks
func _on_default_state_physics_processing(delta: float) -> void:
	const TRACTION := 11.0
	const AIR_TRACTION := 4.0

	if is_on_floor():
		scan_interactables()
		if Input.is_action_just_pressed(&"jump"):
			velocity.y = -speed.y
	else:
		interactable = null
		velocity += get_gravity() * delta

	var new_direction = Input.get_axis(&"left", &"right")
	var old_direction := direction
	direction = new_direction
	if direction != 0.0 and is_on_floor():
		if old_direction == 0.0 or not grass_footsteps.playing:
			grass_footsteps.play()

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x, direction * speed.x, traction * delta)

	move_and_slide()


func _on_in_water_state_physics_processing(delta: float) -> void:
	var direction := Input.get_vector(&"left", &"right", &"jump", &"drop")
	velocity = velocity.lerp(direction * speed.x * 0.2, delta)

	move_and_slide()


func _on_combat_state_entered() -> void:
	animation_player.play(&"show_health")
	set_immune(false)


func _on_combat_state_exited() -> void:
	hit_box.health = hit_box.max_health
	await health_bar.tween_finished
	animation_player.play(&"hide_health")


func _on_peace_state_entered() -> void:
	set_immune(true)


func _on_dialogue_manager_dialogue_started(_resource: DialogueResource) -> void:
	set_state(&"dialogue")


func _on_dialogue_manager_dialogue_ended(_resource: DialogueResource) -> void:
	set_state(&"movement")


func _on_interactor_area_exited(interactable: Interactable) -> void:
	interactable.set_popup_visible(false)
	if interactable == self.interactable:
		self.interactable = null


func _on_hit_box_died() -> void:
	die()


func _on_hit_box_health_decreased(_health: int) -> void:
	animation_player.play(&"hit")


func _on_hit_box_health_changed(_damage: int) -> void:
	health_bar.percent = float(hit_box.health) / hit_box.max_health
#endregion
#endregion
