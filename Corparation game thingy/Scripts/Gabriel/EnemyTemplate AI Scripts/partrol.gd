@icon("../../icons/action.svg")
class_name Partrol extends ActionLeaf
signal Patrol
var Partroling = false
## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if Partroling == true:
		return SUCCESS
	else:
		Patrol.emit()
		Partroling = true
		return SUCCESS


func _on_navigation_agent_2d_target_reached():
	Partroling = false
	return SUCCESS
