class_name Player extends CharacterBody2D


@onready var ability_manager:AbilityManager = $AbilityManager

var SPEED := 160.0
const JUMP_VELOCITY := 320.0
const TRACTION := 11.0
const AIR_TRACTION := 4.0
const DEADZONE := 0.2

var corruption := 0:
	set(value):
		corruption = value
var interactable: Interactable = null

@onready var camera: Camera2D = $Camera
@onready var interactor: Area2D = $Interactor


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif Input.is_action_just_pressed(&"jump"):
		velocity.y = -JUMP_VELOCITY

	var direction := Input.get_axis(&"left", &"right")
	if absf(direction) <= DEADZONE:
		direction = 0.0

	var traction := TRACTION if is_on_floor() else AIR_TRACTION
	velocity.x = lerpf(velocity.x , direction * SPEED, traction * delta)

	move_and_slide()
	scan_interactables()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(&"interact") and interactable != null:
		set_enabled(false)
		velocity = Vector2.ZERO
		await interactable._interact(self)
		set_enabled(true)

	for i in ability_manager.abilities.size():
		if event.is_action_pressed(&"Ability_%s" % (i + 1)):
			ability_manager.abilities.values()[i].execute(self)


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


func _on_hit_box_damage_taken(damage: int) -> void:
	corruption += damage


func _on_interactor_area_exited(interactable: Interactable) -> void:
	interactable.set_popup_visible(false)
	if interactable == self.interactable:
		self.interactable = null
