extends Node
var HP = 100
signal Health_Changed
# Called when the node enters the scene tree for the first time.
func _ready():
	Hit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Pathfind():
	pass #PathFind To Cords Specified by BeeHaveTree

func Shoot():
	pass #Shoot Spot Specified by BeeHaveTree
	
func Face():
	pass #Face Derection spesifide by Other Functions AND Swivile as spesifide by BeeHaveTree

func Hit():
	Health_Changed.emit(HP)
