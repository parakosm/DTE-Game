@icon("res://addons/beehave/icons/action.svg")
class_name Follow extends ActionLeaf
signal follow
signal Patrol
var PlayerDetected = false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if PlayerDetected == true:
		follow.emit()
		Global.Spotted = true
		return SUCCESS
	elif Global.Spotted == true:
		follow.emit()
		return SUCCESS
	else:
		Patrol.emit()
		return FAILURE


func _on_vision_cone_2d_2_vision_enterd(body):
	PlayerDetected = true


func _on_vision_cone_2d_2_vision_exited(body):
	PlayerDetected = false
