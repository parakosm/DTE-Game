@icon("../../icons/action.svg")
class_name Follow extends ActionLeaf
signal follow

var PlayerDetected = false
	
## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if PlayerDetected == false:
		return FAILURE
	else:
		follow.emit()
		return SUCCESS


func _on_enemy_template_player_detected(test):
	PlayerDetected = test
	
