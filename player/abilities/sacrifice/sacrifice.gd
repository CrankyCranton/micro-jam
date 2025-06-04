extends Ability
class_name Sacrifice


func _execute():
	var new_value:int = owner.max_health
	owner.health = new_value
	owner.corruption += new_value
	await get_tree().create_timer(0.1)
	queue_free() # one time use, await so it doesnt instantly remove itself and looks nice, 
	#probably not needed
