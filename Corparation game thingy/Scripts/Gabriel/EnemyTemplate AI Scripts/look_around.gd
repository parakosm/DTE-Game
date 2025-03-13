extends ActionLeaf
var Looking = false
var stop = false
signal lookAround

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if stop == true:
		stop = false
		return FAILURE
	elif Looking == false:
		lookAround.emit()
		Looking = true
		stop = false
		return RUNNING
	elif Looking == true:
		print("IMgoingTOdie")
		return RUNNING
		
	return SUCCESS
		
func _on_enemy_template_look_around_finished():
	Looking = false
	stop = true
	print("WE STOPED SO FUNCI)EGJOOIEGOESOIGF JOESGHOIEHS")
	return FAILURE
