extends Node2D

@export var noise:FastNoiseLite

func _ready() -> void:
	var image:Image = noise.get_image(200,200)
	var tex = ImageTexture.create_from_image(image)
	$Noose.texture = tex

	get_tree().get_first_node_in_group("evil_spirits").get_haga(noise)
