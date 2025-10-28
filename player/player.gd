class_name Player extends CharacterBody2D


#region Members
#region Signals
signal fully_corrupted
signal ability_gained(ability_info: AbilityInfo)
#endregion

#region Constants
const TRACTION := 11.0
const AIR_TRACTION := 4.0
const MAX_CORRUPTION := 5
const MIN_HEALTH_BAR_VALUE := 13
const MAX_HEALTH_BAR_VALUE := 46
#endregion

#region Variables
var speed := Vector2(64.0, 256.0)
var interactable: Interactable = null
var spiritual_chains: SpiritualChains
var resurrection: Resurrection
var enabled := true
var turning_enabled := true
var direction := 0.0:
	set(value):
		direction = value
		if absf(direction) > 0.0 and turning_enabled:
			last_direction = 1 if direction > 0 else -1
#endregion

#region Onready
@onready var sprite: Sprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var hit_box: HitBox = $HitBox
@onready var interactor: Area2D = $Interactor
@onready var ability_manager: AbilityManager = $AbilityManager
@onready var corruption_meter: CorruptionMeter = %CorruptionMeter
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var collision_shape: CollisionShape2D = $CollisionShape
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
	corruption_meter.max_value = MAX_CORRUPTION
	DialogueManager.dialogue_started.connect(_on_dialogue_manager_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_manager_dialogue_ended)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if enabled:
		movement_input(delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact") and interactable != null:
		interact()
#endregion


#region Methods
func movement_input(delta: float) -> void:
	if Input.is_action_just_pressed(&"jump") and is_on_floor():
		velocity.y = -speed.y
	var new_direction = Input.get_axis(&"left", &"right")
	var old_direction := direction
	direction = new_direction
	if direction != 0.0 and is_on_floor():
		if old_direction == 0.0 or not grass_footsteps.playing:
			grass_footsteps.play()

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x , direction * speed.x, traction * delta)
	scan_interactables()


func reset_health() -> void:
	hit_box.health = hit_box.max_health


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


func set_enabled(enabled: bool) -> void:
	self.enabled = enabled
	set_process_input(enabled)
	for ability in ability_manager.get_children():
		ability.set_process_input(enabled)
	if not enabled:
		velocity.x = 0.0


func add_ability(ability_info: AbilityInfo) -> void:
	var ability: Ability = ability_info.scene.instantiate()
	ability_manager.add_child(ability)
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
	enabled = true
	hit_box.health = hit_box.max_health


func change_interactable_labels(group: StringName, message: String) -> void:
	for interactable: Interactable in get_tree().get_nodes_in_group(group):
		interactable.label.text = message


func sort_by_distance(a: Node2D, b: Node2D) -> bool:
	return global_position.distance_squared_to(a.global_position) \
			> global_position.distance_squared_to(b.global_position)
#endregion


#region Callbacks
func _on_dialogue_manager_dialogue_started(_resource: DialogueResource) -> void:
	set_enabled(false)


func _on_dialogue_manager_dialogue_ended(_resource: DialogueResource) -> void:
	set_enabled(true)


func _on_interactor_area_exited(interactable: Interactable) -> void:
	interactable.set_popup_visible(false)
	if interactable == self.interactable:
		self.interactable = null


func _on_hit_box_died() -> void:
	die()


func _on_hit_box_health_decreased(_health: int) -> void:
	animation_player.play(&"hit")


func _on_hit_box_health_changed(_damage: int) -> void:
	health_bar.value = remap(hit_box.health, 0, hit_box.max_health,
			MIN_HEALTH_BAR_VALUE, MAX_HEALTH_BAR_VALUE)
#endregion
#endregion
