extends StaticBody2D
@onready var move = self.global_position
var speed = 256

func _physics_process(delta):
	move += transform.x * speed * delta
	move_and_collide(move)
