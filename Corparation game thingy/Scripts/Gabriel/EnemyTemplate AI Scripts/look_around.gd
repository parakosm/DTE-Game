extends ActionLeaf
var Looking = false
var stop = false
signal lookAround
signal restartPartoal

func tick(actor: Node, _blackboard: Blackboard) -> int:
	print(stop)
	if stop == true:
		stop = false
		Looking = false
		print(Looking, "stop")
		restartPartoal.emit()
		return FAILURE
	elif Looking == false and stop == false:
		print("emited")
		lookAround.emit()
		Looking = true
		stop = false
		return RUNNING
	elif Looking == true and stop == false:
		return RUNNING
	return SUCCESS
		
func _on_enemy_template_look_around_finished():
	Looking = false
	stop = true
	print(stop, "stoped function")
	
