class_name Barrier extends CollisionShape2D


#region Functions
func _ready() -> void:
	set_deferred(&"disabled", true)


func set_enabled(enabled: bool) -> void:
	set_deferred(&"disabled", not enabled)
	# Do animation stuff.
#endregion
