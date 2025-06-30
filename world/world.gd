extends Node2D

@export var noise:FastNoiseLite

var max_distance:int = 32

func _ready() -> void:
	pass
	#var image:Image = noise.get_image(200,200)
	#var tex = ImageTexture.create_from_image(image)
	#$Noose.texture = tex

func get_haga(pos:Vector2):
	var wth = noise.get_noise_2d(pos.x,pos.y)
	if wth < 0:
		print("This is black")
		return false
	else:
		print("this is white or gray")
		return true

func move(pos, enemy_i_guess:EvilSpirit):
	var vector:Vector2 = Vector2.ZERO
	vector += (global_position - pos) / max_distance
	enemy_i_guess.velocity = vector
