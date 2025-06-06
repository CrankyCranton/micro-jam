class_name CorruptionMeter extends TextureRect


var max_corruption := 50

@onready var corruption := 0:
	set(value):
		corruption = value
		@warning_ignore("integer_division")
		for i in corruption / max_corruption * get_child_count():
			get_child(i).play(&"light")
