extends CharacterBody2D
@export_group("settings")
@export var pathName: Path2D
@export var Follow_Target: CharacterBody2D
var HP = 100
signal Health_Changed
signal PlayerDetected(True_False)
var Target_Position
var Current_Position
var Movement_Speed = 50
var Next_Step
var Velocity
var True_False
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var pathOne = pathName.curve
@onready var Path_Length = pathOne.get_point_count()

var path_Progress = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Hit()
	_on_partrol_patrol()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta) -> void:
	
	Current_Position = self.global_position
	Next_Step = navigation_agent_2d.get_next_path_position()
	Velocity = Current_Position.direction_to(Next_Step) * Movement_Speed
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(Velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(Velocity)
	move_and_slide()
	var angle = (Next_Step - self.global_position).angle()
	self.global_rotation = lerp_angle(self.global_rotation, angle, delta * 4)

func Pathfind():
	pass #PathFind To Cords Specified by BeeHaveTree

func Shoot():
	pass #Shoot Spot Specified by BeeHaveTree
	
func Face():
	pass #Face Derection spesifide by Other Functions AND Swivile as spesifide by BeeHaveTree

func Hit():
	Health_Changed.emit(HP)

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity


func _on_partrol_patrol():
	Target_Position = pathOne.get_point_position(path_Progress)
	navigation_agent_2d.target_position = Target_Position
	path_Progress += 1
	if Path_Length == path_Progress:
		path_Progress = 0


func _on_vision_cone_2d_vision_enterd():
	True_False = true
	PlayerDetected.emit(True_False)


func _on_vision_cone_2d_vision_exited(body):
	True_False = false
	PlayerDetected.emit(True_False)


func _on_follow_follow():
	if Target_Position != Follow_Target.position:
		Target_Position = Follow_Target.position
		navigation_agent_2d.target_position = Target_Position
