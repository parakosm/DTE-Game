extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Elevator Door Entered")
	Global.GlobalLevel += 1
	if Global.GlobalLevel == 3:
		get_tree().change_scene_to_file(str("res://End Screen.tscn"))
	else:
		print(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
		get_tree().change_scene_to_file(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
