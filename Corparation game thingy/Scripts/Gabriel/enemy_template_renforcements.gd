extends CharacterBody2D
var can_shoot = true
var shoot = false
@onready var Follow_Target = $"../../World/Player"
var Bullet = load("res://Scenes/bullet.tscn")
var HP = 100
var Target_Position
var Current_Position
var Movement_Speed = 40
var Next_Step
var Velocity
@onready var navigation_agent_2d = $NavigationAgent2D
var path_Progress = 0
var angle
var lookSpeed = 4
@onready var progress_bar = $Control/ProgressBar

# Called every pysics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	Pathfind(delta)

func Pathfind(delta):#moves the enemy closer to the next pathfind point
	Current_Position = self.global_position
	Next_Step = navigation_agent_2d.get_next_path_position()
	Velocity = Current_Position.direction_to(Next_Step) * Movement_Speed
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(Velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(Velocity)
	move_and_slide()
	angle = (Follow_Target.position - self.global_position).angle()
	if shoot == true and can_shoot == true:# shoots player if its gun isnt still cooling down and if its in range
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
		get_parent().add_child(b)
		b.transform = $Marker2D.global_transform
		$AnimatedSprite2D.play("ShootAN")


func Hit(): # On hit by bullet
	HP -= 10 # Reduces HP by 10 when hit by bullet
	progress_bar.visible = true
	progress_bar.value = HP
	if HP <= 0: # If the enemy is dead:
		Follow_Target.Killed_Enemy()
		queue_free() # Destroy the enemy- may change this to stop it moving once we have dead enemies from Sam


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_vision_cone_2d_2_vision_enterd(body):
	if body == Follow_Target:# player in view cone
		shoot = true
	

func _on_vision_cone_2d_2_vision_exited(body):
	# player not in vewcone
	if body == Follow_Target:
		shoot = false
		$AnimatedSprite2D.play("Idle")


func _on_follow_follow():
	# will set pathfind desination to player
	if Target_Position != Follow_Target.position:
		Target_Position = Follow_Target.position
		navigation_agent_2d.target_position = Target_Position
		Movement_Speed = 40


func _on_cooldown_timer_timeout():
	# gun cooldown
	can_shoot = true
