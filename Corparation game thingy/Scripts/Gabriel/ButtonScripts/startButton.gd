extends Button


func _on_pressed():
	# swiches the game to the first level
	get_tree().change_scene_to_file("res://Scenes/level 1.tscn")
	Global.GlobalLevel = 1
	Global.Experience = 0
	Global.PlayerHealth=10
	Global.Spotted = false
	Global.KeycardObtained = false
