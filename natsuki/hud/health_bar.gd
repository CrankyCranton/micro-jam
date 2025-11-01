class_name HealthBar extends MarginContainer


#region Members
signal tween_finished

#region Constants
const MIN_HEALTH_BAR_VALUE := 13
const MAX_HEALTH_BAR_VALUE := 46
const HEALTH_BAR_RANGE := MAX_HEALTH_BAR_VALUE - MIN_HEALTH_BAR_VALUE
const LOSS_DURATION := 0.5
const GAIN_SPEED := 32.0
#endregion

#region Onready
@onready var under: TextureProgressBar = $Under
@onready var over: TextureProgressBar = $Over
@onready var percent := 0.0:
	set(value):
		var remapped := remap(value, 0.0, 1.0, MIN_HEALTH_BAR_VALUE, MAX_HEALTH_BAR_VALUE)
		if value > percent:
			var distance := (value - percent) * HEALTH_BAR_RANGE
			var time := distance / GAIN_SPEED
			var tween := create_tween().set_trans(Tween.TRANS_SINE).tween_property(
					over, ^"value", remapped, time)
			percent = value
			await tween.finished
			under.value = remapped
		elif value < percent:
			percent = value
			over.value = remapped
			await create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CIRC).tween_property(
					under, ^"value", remapped, LOSS_DURATION).finished
		tween_finished.emit()
#endregion
#endregion
