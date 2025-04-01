@icon("res://addons/beehave/icons/action.svg")
class_name Follow extends ActionLeaf
signal follow
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
		return FAILURE


func _on_vision_cone_2d_2_vision_enterd(body):
	PlayerDetected = true
