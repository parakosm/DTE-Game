extends CharacterBody2D

@export var speed = 42 # Nobody change this variable

func get_input():
	if Input.is_action_pressed("shift"): # If the shift key is held down, the player speed is increased. Otherwise, the else sets speed to the normal value.
		speed = 69
	else:
		speed = 42
	var input_direction = Input.get_vector("left", "right", "up", "down") #Ensures the player's movement is in the direction that the player chose.
	velocity = input_direction * speed

func _physics_process(delta):
	get_input() 
	move_and_slide()
	look_at(get_global_mouse_position()) # Sets player facing, determineds by the mouse position function.
