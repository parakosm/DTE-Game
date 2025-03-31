@icon("res://addons/beehave/icons/action.svg")
class_name Follow extends ActionLeaf
signal follow
var PlayerDetected = false

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if Global.Spotted == true:
		follow.emit()
		return SUCCESS
	elif PlayerDetected == false:
		return FAILURE
	else:
		follow.emit()
		Global.Spotted = true
		return SUCCESS


func _on_enemy_template_player_detected(detectedPlayer):
	PlayerDetected = detectedPlayer
