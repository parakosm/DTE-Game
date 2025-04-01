extends Button

var experience = Global.Experience
var globalLevel = Global.GlobalLevel


func _on_pressed():
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("save", "experience", experience) 
	config.set_value("save", "globalLevel", globalLevel)

	# Save it to a file (overwrite if already exists).
	config.save("user://save.cfg")
