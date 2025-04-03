extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") == true:
		if Global.KeycardObtained == true:
			Global.GlobalLevel += 1
			Global.Spotted = false
			if Global.GlobalLevel == Global.MaxLevel:
				get_tree().change_scene_to_file(str("res://End Screen.tscn"))
			else:
				Global.KeycardObtained = false
				get_tree().change_scene_to_file(str("res://Scenes/elevator.tscn"))
