@icon("../../icons/condition.svg")
class_name PartrolChecker extends ConditionLeaf
var PlayerDetected = false
func tick(actor: Node, _blackboard: Blackboard) -> int:
	
	if PlayerDetected == false:
		return SUCCESS
	else:
		return FAILURE
