extends StaticBody2D

@onready var interact:InteractionArea = $InteractableArea


func _ready() -> void:
	interact.Interact = Callable(self, "print_lol")

func print_lol():
	print("LOL")
