@icon("../../icons/condition.svg")
class_name PartrolChecker extends ConditionLeaf
var PlayerDetected = false
func tick(actor: Node, _blackboard: Blackboard) -> int:
	
	if PlayerDetected == false:
		return SUCCESS
	else:
		return FAILURE


func _on_enemy_template_player_detected(test):
	PlayerDetected = test
	print(test)
	
