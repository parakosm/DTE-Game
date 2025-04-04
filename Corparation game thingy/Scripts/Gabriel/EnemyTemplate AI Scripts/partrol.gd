@icon("res://addons/beehave/icons/action.svg")
class_name Partrol extends ActionLeaf
signal Patrol
var Partroling = false
var stop = false
## Actions are leaf nodes that define a task to be performed by an actor.
## Their execution can be long running, potentially being called across multiple
## frame executions. In this case, the node should return `RUNNING` until the
## action is completed.

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if Global.Spotted == true:
		return FAILURE
	elif stop == true:
		print(stop)
		return FAILURE
	elif Partroling == true:
		return RUNNING
	else:
		Patrol.emit()
		Partroling = true
		return RUNNING

func _on_navigation_agent_2d_target_reached():
	Partroling = false


func _on_vision_cone_2d_2_vision_enterd(body):
	stop = true
	return FAILURE


func _on_vision_cone_2d_2_vision_exited(body):
	stop = false
	print(stop, " what")
	return RUNNING
