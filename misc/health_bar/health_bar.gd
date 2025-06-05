extends ProgressBar

@onready var timer:Timer = $Timer
@onready var second_bar:ProgressBar = $SecondBar

var value_bar:int : set = _set_value

func _ready() -> void:
	_init_value(value_bar)
	value_bar = 20

func _set_value(_new_value:int):
	var previous_value:int = value_bar
	value_bar = min(max_value, _new_value)
	value = value_bar

	if value_bar < previous_value:
		timer.start()
	else:
		value = value_bar

func _init_value(_value:int):
	value_bar = _value
	max_value = _value
	value = _value
	second_bar.max_value = _value
	second_bar.value = _value

func _on_timer_timeout() -> void:
	second_bar.value = value_bar
