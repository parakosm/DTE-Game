extends Button


func _on_pressed():
	var score_data = {}
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://save.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Iterate over all sections.
	for save in config.get_sections():
		#sets the global varibles
		Global.Experience = config.get_value("save", "experience")
		Global.GlobalLevel = config.get_value("save", "globalLevel")
	# starts the game at the last level enterd
	get_tree().change_scene_to_file(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
