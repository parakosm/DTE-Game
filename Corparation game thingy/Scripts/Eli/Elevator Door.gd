extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Elevator Door Entered")
	Global.GlobalLevel += 1
	print(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
	get_tree().change_scene_to_file(str("res://level ", Global.GlobalLevel, ".tscn"))
