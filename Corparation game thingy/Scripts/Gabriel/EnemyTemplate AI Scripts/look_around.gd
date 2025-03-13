extends ActionLeaf
var Looking = false
var stop = false
signal lookAround

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if stop == true:
		stop = false
		print("if you spam this ill atack eric")
		return FAILURE
		
	elif Looking == false:
		lookAround.emit()
		Looking = true
		stop = false
		return RUNNING
	elif Looking == true:
		return RUNNING
	return SUCCESS
		
func _on_enemy_template_look_around_finished():
	Looking = false
	stop = true	
	return FAILURE
