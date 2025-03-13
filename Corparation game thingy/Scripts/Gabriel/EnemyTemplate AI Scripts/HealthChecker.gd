@icon("../../icons/condition.svg")
class_name HealthChecker extends ConditionLeaf
var HP = 100

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if HP <= 0:
		return SUCCESS
	else:
		return FAILURE


func _on_enemy_template_health_changed(NewHealth):
	HP = NewHealth
