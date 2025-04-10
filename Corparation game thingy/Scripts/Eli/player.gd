extends CharacterBody2D

var Bullet = preload("res://Scenes/bullet FOR PLAYER.tscn")
@onready var camera_2d = $Camera2D

@onready var XP = Global.Experience
var Health = Global.PlayerHealth

var speed = 42 # Nobody change this variable
@export_group("settings")
@export var TilesRight = 39
@export var TilesDown = 20
@export var LevelTime = 60
@onready var xp = $Camera2D/CanvasLayer/Control/XP
@onready var timer = $Camera2D/CanvasLayer/Control/Timer
@onready var time_remainig = $TimeRemainig
@onready var health = $Camera2D/CanvasLayer/Control/Health

func _ready():
	# loads in the camra limits and defolt xp values
	# camra limiting stops camra from seaing outside the map
	camera_2d.limit_right = TilesRight*16
	camera_2d.limit_bottom = TilesDown*16
	time_remainig.wait_time = LevelTime
	time_remainig.start()
	xp.text = str("XP: ", XP)

func get_input():
	if Input.is_action_pressed("shift"): # If the shift key is held down, the player speed is increased. Otherwise, the else sets speed to the normal value.
		speed = 69
	else:
		speed = 42
	var input_direction = Input.get_vector("left", "right", "up", "down") #Ensures the player's movement is in the direction that the player chose.
	velocity = input_direction * speed
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	LevelTime = time_remainig.time_left
	LevelTime = roundi(LevelTime)
	timer.text = str("Time Remaning: ", LevelTime , " Seconds")
	get_input() 
	move_and_slide()
	look_at(get_global_mouse_position()) # Sets player facing, determineds by the mouse position function.

func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform

func Killed_Enemy(): # When an enemy is killed, the player gets 10XP and the console notes the current XP total.
	XP += 10
	xp.text = str("XP: ", XP)
	Global.Experience = XP
	
func Hit():# lowers hp when hit
	Health -= 10
	health.text = str("HP: ", Health)# sets the ui to the corect values
	if Health <= 0:
		get_tree().change_scene_to_file(str("res://Scenes/Death Screen.tscn"))
		

func player():# used so other scrpits knows this is the player
	pass


func _on_time_remainig_timeout():
	get_tree().change_scene_to_file("res://Scenes/Death Screen.tscn")# change to end game screen when added
