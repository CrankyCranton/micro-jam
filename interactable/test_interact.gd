extends StaticBody2D

@onready var interact_area:Interactable = $InteractableArea


func _ready() -> void:
	interact_area.interact = Callable(self, "print_lol")

func print_lol(_player: Player):
	print("LOL")
