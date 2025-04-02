extends Button


func _on_pressed():
	# swiches the game to the first level
	get_tree().change_scene_to_file("res://Scenes/level 1.tscn")
