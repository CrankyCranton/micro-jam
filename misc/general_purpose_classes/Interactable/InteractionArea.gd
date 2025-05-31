extends Node
class_name InteractionArea

@export var action_name:String # check process function of InteractionManager to see its use

var Interact:Callable = func():
	pass #Callable func that gets overriden by the actual function to be called by the actual Interactable object


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_interactable(self)

func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_interactable(self)
