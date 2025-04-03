extends Button

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main Menu.tscn")
	Global.PlayerHealth = 100
	Global.Spotted = false
	Global.KeycardObtained = false
