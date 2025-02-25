extends CharacterBody2D

@export var speed = 42 # Nobody change this variable

func get_input():
	if Input.is_action_pressed("shift"):
		var speed = 69  
	else:
		var speed = 42
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
