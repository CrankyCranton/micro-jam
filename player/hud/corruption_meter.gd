class_name CorruptionMeter extends TextureRect


var max_value := 50

@onready var value := 0:
	set(new_value):
		value = new_value
		@warning_ignore("integer_division")
		for i in value / max_value * get_child_count():
			get_child(i).play(&"light")
