extends Button



func _on_pressed():
	get_tree().change_scene_to_file(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
	Global.PlayerHealth = 100
	Global.Spotted = false
