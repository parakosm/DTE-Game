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
		Global.Experience = config.get_value("save", "experience")
		Global.GlobalLevel = config.get_value("save", "globalLevel")
	get_tree().change_scene_to_file(str("res://Scenes/level ", Global.GlobalLevel, ".tscn"))
