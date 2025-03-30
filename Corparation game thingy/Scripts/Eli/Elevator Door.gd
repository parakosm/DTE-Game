extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Elevator Door Entered")
	if Global.KeycardObtained == true:
		Global.GlobalLevel += 1
		Global.Spotted = false
		if Global.GlobalLevel == 3:
			get_tree().change_scene_to_file(str("res://End Screen.tscn"))
		else:
			Global.KeycardObtained = false
			get_tree().change_scene_to_file(str("res://Scenes/elevator.tscn"))
