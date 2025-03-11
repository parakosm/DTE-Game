@icon("../../icons/condition.svg")
class_name FollowChecker extends ConditionLeaf
var PlayerDetected = false
func tick(actor: Node, _blackboard: Blackboard) -> int:
	
	if PlayerDetected == false:
		return FAILURE
	else:
		return SUCCESS


func _on_enemy_template_player_detected(test):
	PlayerDetected = test
	
