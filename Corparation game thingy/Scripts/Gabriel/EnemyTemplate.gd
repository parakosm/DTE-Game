extends CharacterBody2D
var can_shoot = true
@export_group("settings")
@export var pathName: Path2D
@export var Follow_Target: CharacterBody2D
@export var Bullet : PackedScene
var HP = 100
var canShoot = true
signal Health_Changed
signal PlayerDetected(True_False)
signal LookAroundFinished
var Target_Position
var Current_Position
var Movement_Speed = 25
var Next_Step
var Velocity
var True_False
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var pathOne = pathName.curve
@onready var Path_Length = pathOne.get_point_count()
var lookat = 0
var path_Progress = 0
var angle
@onready var look_point_two = $LookPointTwo
@onready var look_point_one = $LookPointOne
var DelayLooking = false
var LookingOrMoving = "Looking"
var lookSpeed = 4
var NavFinished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Hit()
	_on_partrol_patrol()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	if LookingOrMoving == "Moving":
		Pathfind(delta)
		lookSpeed = 4
		NavFinished= false
	elif LookingOrMoving == "Looking":
		lookSpeed = 0.5
		lookAt(angle, delta)

func Pathfind(delta):
	Current_Position = self.global_position
	Next_Step = navigation_agent_2d.get_next_path_position()
	Velocity = Current_Position.direction_to(Next_Step) * Movement_Speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(Velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(Velocity)
	move_and_slide()
	if lookat == 0:
		angle = (Next_Step - self.global_position).angle()
	elif lookat == 1:
		angle = (Follow_Target.position - self.global_position).angle()
	lookAt(angle, delta)

func lookAt(angle, delta):
	self.global_rotation = lerp_angle(self.global_rotation, angle, delta * lookSpeed)


func Shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Marker2D.global_transform
	
func Face():
	pass #Face Derection spesifide by Other Functions AND Swivile as spesifide by BeeHaveTree

func Hit(): # On hit by bullet- had to rewrite this because Gabriel didn't github good :(
	HP -= 10 # Reduces HP by 10 when hit by bullet
	print(str(HP)) # Prints current HP to console- for ease of debugging
	Health_Changed.emit(HP) # This was in Gabriel's original hit function. I beelieve it's for beehave.
	if HP <= 0: # If the enemy is dead:
		Follow_Target.Killed_Enemy()
		queue_free() # Destroy the enemy- may change this to stop it moving once we have dead enemies from Sam

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_partrol_patrol():
	LookingOrMoving = "Moving"
	Target_Position = pathOne.get_point_position(path_Progress)
	navigation_agent_2d.target_position = Target_Position
	path_Progress += 1
	if Path_Length == path_Progress:
		path_Progress = 0
	lookat = 0
	Movement_Speed = 25


func _on_vision_cone_2d_2_vision_enterd(body):
	if body == Follow_Target:
		True_False = true
		PlayerDetected.emit(True_False)
	

func _on_vision_cone_2d_2_vision_exited(body):
	if body == Follow_Target:
		lookat = 0
		True_False = false
		PlayerDetected.emit(True_False)


func _on_follow_follow():
	if Target_Position != Follow_Target.position:
		Target_Position = Follow_Target.position
		navigation_agent_2d.target_position = Target_Position
		lookat = 1
		Movement_Speed = 40
		LookingOrMoving = "Moving"
		if can_shoot:
			can_shoot = false
			Shoot()
			$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	can_shoot = true


func _on_look_around_look_around():
	LookingOrMoving = "Looking"
	print("start")
	print(LookingOrMoving, " lookwww")
	print(NavFinished)
	#while NavFinished == false:
	#	await get_tree().create_timer(0.1).timeout
	if NavFinished == true:
		print("done3")
		angle = (look_point_one.global_position - self.global_position).angle()
		var angle2 = (look_point_two.global_position - self.global_position).angle()
		print("done2")
		await get_tree().create_timer(2).timeout
		angle = angle2
		print("done1")
		await get_tree().create_timer(2).timeout
		LookAroundFinished.emit()
		print("done")
	else:
		LookAroundFinished.emit()
		print("failed")


func _on_navigation_agent_2d_target_reached():
	await get_tree().create_timer(0.5).timeout
	NavFinished = true
	print(NavFinished, " finished")
	print(LookingOrMoving, " shuld be looking")
	if LookingOrMoving == "Looking":
		print("called look")
		_on_look_around_look_around()


func _on_navigation_agent_2d_path_changed():
	#print(navigation_agent_2d.get_current_navigation_path_index())
	if navigation_agent_2d.get_current_navigation_path_index() > 8:
		LookAroundFinished.emit()
