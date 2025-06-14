extends Camera2D

@export var decay : float = 0.8 # Time it takes to reach 0% of trauma
@export var max_offset : Vector2 = Vector2(100, 75) # Max hor/ver shake in pixels
@export var max_roll : float = 0.1 # Maximum rotation in radians (use sparingly)

var trauma : float = 0.0 # Current shake strength
var trauma_power : int = 2 # Trauma exponent. Increase for more extreme shaking

func _process(delta : float) -> void:
	if trauma: # If the camera is currently shaking
		trauma = max(trauma - decay * delta, 0) # Decay the shake strength
		shake()
	var mouse_pos:Vector2 = get_global_mouse_position()
	drag_horizontal_offset = (mouse_pos.x - get_parent().global_position.x) / (1920.0/ 2.0)
	drag_vertical_offset = (mouse_pos.y - get_parent().global_position.y) / (1080 / 2.0)

## The function to use for adding trauma (screen shake)
func add_trauma(amount : float) -> void:
	trauma = min(trauma + amount, 1.0) # Add the amount of trauma (capped at 1.0)

func shake() -> void:
	#? Set the camera's rotation and offset based on the shake strength
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)
