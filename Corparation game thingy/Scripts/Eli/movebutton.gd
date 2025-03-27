extends Button

func _on_pressed() -> void:
	print(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
	get_tree().change_scene_to_file(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
