extends Area2D

var speed = 123

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("Hit"):
		body.Hit()
	queue_free()
