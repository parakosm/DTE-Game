extends CharacterBody2D
var can_shoot = true
var canShoot = true
var shoot = false
@export_group("settings")
@export var pathName: Path2D
#@export var Follow_Target: CharacterBody2D
@onready var Follow_Target = $"../../World/Player"
var Bullet = preload("res://Scenes/bullet.tscn")
var HP = 100
var Target_Position
var Current_Position
var Movement_Speed = 25
var Next_Step
var Velocity
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var pathOne = pathName.curve
@onready var Path_Length = pathOne.get_point_count()
var lookat = 0
var path_Progress = 0
var angle
var lookSpeed = 4
var AN = false
@onready var progress_bar = $Control/ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	_on_partrol_patrol()# starts partoling

# Called every pysics frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	Pathfind(delta)# will conpute the pathfinding to keep the enemys moving

func Pathfind(delta):
	#moves the enemy closer to the next pathfind point
	Current_Position = self.global_position
	Next_Step = navigation_agent_2d.get_next_path_position()
	Velocity = Current_Position.direction_to(Next_Step) * Movement_Speed
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(Velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(Velocity)
	move_and_slide()
	if lookat == 0:
		#looks at where its going
		angle = (Next_Step - self.global_position).angle()
		$AnimatedSprite2D.play("Idle")
	elif lookat == 1:
		#looks at player
		angle = (Follow_Target.position - self.global_position).angle()
		if shoot == true and can_shoot == true:
			# shoots player if its gun isnt still cooling down and if its in range
			can_shoot = false
			Shoot()
			$CooldownTimer.start()
	lookAt(angle, delta)

func lookAt(angle, delta):
	angle = lerp_angle(self.global_rotation, angle, delta * lookSpeed)
	$Control.rotation =- angle# resets ui rotation to 0
	self.global_rotation = angle# sets the enemys rotaton


func Shoot():
		#spawn a bullet at marker
		var b = Bullet.instantiate()
		b.transform = $Marker2D.global_transform
		$AnimatedSprite2D.play("ShootAN")
		owner.add_child(b)


func Hit(): # On hit by bullet
	HP -= 10 # Reduces HP by 10 when hit by bullet
	progress_bar.visible = true
	progress_bar.value = HP
	if HP <= 0: # If the enemy is dead:
		Follow_Target.Killed_Enemy()
		queue_free() # Destroy the enemy- may change this to stop it moving once we have dead enemies from Sam


func HitMelee():
	Follow_Target.Killed_Enemy()
	queue_free() # Destroy the enemy- may change this to stop it moving once we have dead enemies from Sam



func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_partrol_patrol():
	# if patroaling this will get the next patrol point acording to BeeHave and path2D
	Target_Position = pathOne.get_point_position(path_Progress)
	navigation_agent_2d.target_position = Target_Position
	path_Progress += 1
	if Path_Length == path_Progress:
		path_Progress = 0
	lookat = 0
	Movement_Speed = 25


func _on_vision_cone_2d_2_vision_enterd(body: Node2D) -> void:
	shoot = true # player in view cone
	

func _on_vision_cone_2d_2_vision_exited(body: Node2D) -> void:
	lookat = 0
	shoot = false# player not in vewcone


func _on_follow_follow():
	# will set pathfind desination to player
	if Target_Position != Follow_Target.position:
		Target_Position = Follow_Target.position
		navigation_agent_2d.target_position = Target_Position
		lookat = 1
		Movement_Speed = 40


func _on_cooldown_timer_timeout():
	# gun cooldown
	can_shoot = true


func _on_follow_patrol():
	pass # Replace with function body.
