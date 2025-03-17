extends ActionLeaf
var Looking = false
var stop = false
signal lookAround
signal restartPartoal

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if stop == true:
		stop = false
		Looking = false
		print(Looking, "stop")
		restartPartoal.emit()
		return FAILURE
	elif Looking == false:
		print("emited")
		lookAround.emit()
		Looking = true
		stop = false
		return SUCCESS
	elif Looking == true:
		return RUNNING
		await get_tree().create_timer(4).timeout
		Looking = false
		stop = true
	return SUCCESS
		
func _on_enemy_template_look_around_finished():
	Looking = false
	print(stop, "stoped function")
	stop = true	
	
	return FAILURE
