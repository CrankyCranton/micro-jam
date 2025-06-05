class_name Player extends CharacterBody2D

@export var max_health:int

const SPEED := 160.0
const JUMP_VELOCITY := 320.0
const TRACTION := 11.0
const AIR_TRACTION := 4.0
const DEADZONE := 0.2

var direction := 0.0:
	set(value):
		direction = value
		if absf(direction) > 0.0:
			last_direction = direction
var last_direction := 1.0
var interactable: Interactable = null
var spiritual_chains: SpiritualChains
var resurrection: Resurrection
var corruption := 0

@onready var sprite: Sprite2D = $Sprite
@onready var camera: Camera2D = $Camera
@onready var interactor: Area2D = $Interactor
@onready var ability_manager: AbilityManager = $AbilityManager
@onready var health := max_health:
	set(value):
		health = value
		if health <= 0:
			die()

func _ready() -> void:
	health = 100


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_VELOCITY

	direction = Input.get_axis(&"left", &"right")
	if absf(direction) <= DEADZONE:
		direction = 0.0

	sprite.flip_h = last_direction < 0.0

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x , direction * SPEED, traction * delta)

	move_and_slide()
	scan_interactables()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"interact") and interactable != null:
		set_enabled(false)
		interactable.set_popup_visible(false)
		velocity = Vector2.ZERO

		if spiritual_chains != null and interactable is NPC:
			await spiritual_chains._execute()
		elif resurrection != null and interactable is Gravestone:
			await resurrection._execute()
		else:
			@warning_ignore("redundant_await")
			await interactable._interact(self)

		set_enabled(true)


func die() -> void:
	get_tree().paused = true # FIXME


func scan_interactables() -> void:
	var interactables := get_interactables()
	interactable = interactables.front() if interactables.size() > 0 else null
	for i in interactables.size():
		interactables[i].set_popup_visible(i == 0)


func get_interactables() -> Array[Area2D]:
	var interactables: Array[Area2D] = interactor.get_overlapping_areas()
	interactables.sort_custom(InteractionManager.sort_by_distance)
	return interactables


func set_enabled(enabled: bool) -> void:
	set_physics_process(enabled)
	set_process_input(enabled)


func add_ability(ABILITY: PackedScene) -> void:
	var ability: Ability = ABILITY.instantiate()
	ability_manager.add_child(ability)
	ability.owner = self

	# There's probably a way to merge these.
	if ability is SpiritualChains:
		spiritual_chains = ability
		for npc: NPC in get_tree().get_nodes_in_group(&"npcs"):
			npc.label.text = "E to spiritually chain"
	#elif ability is Resurrection:
		#resurrection = ability
		#for gravestone: Gravestone in get_tree().get_nodes_in_group(&"gravestones"):
			#gravestone.label.text = "E to resurrect"


func _on_hit_box_damage_taken(damage: int) -> void:
	health -= damage
	if health <= 0:
		get_tree().reload_current_scene()


func _on_interactor_area_exited(interactable: Interactable) -> void:
	interactable.set_popup_visible(false)
	if interactable == self.interactable:
		self.interactable = null
