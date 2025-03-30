@icon("../../icons/action.svg")
class_name Follow extends ActionLeaf
signal follow

var PlayerDetected = false
var targetReached = false
## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if Global.Spotted == true:
		follow.emit()
		return SUCCESS
	elif PlayerDetected == false and targetReached == true:
		return FAILURE
	elif PlayerDetected == false:
		return FAILURE
	else:
		follow.emit()
		Global.Spotted = true
		return SUCCESS

func _on_enemy_template_player_detected(detectedPlayer):
	PlayerDetected = detectedPlayer


func _on_navigation_agent_2d_target_reached():
	targetReached = true


func _on_navigation_agent_2d_path_changed():
	targetReached = false
