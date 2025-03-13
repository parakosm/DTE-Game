@icon("../../icons/action.svg")
class_name Partrol extends ActionLeaf
signal Patrol
var Partroling = false
var stop = false
## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func tick(actor: Node, _blackboard: Blackboard) -> int:
	print(Partroling)
	if stop == true:
		return FAILURE
	elif Partroling == true:
		return RUNNING
	else:
		Patrol.emit()
		Partroling = true
		return RUNNING


func _on_navigation_agent_2d_target_reached():
	Partroling = false
	return SUCCESS
	
func _on_enemy_template_player_detected(test):
	if test == true:
		stop = true
	else:
		stop = false
