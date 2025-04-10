extends Area2D

var speed = 256

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void: # On a hit, the bullet looks to see if the object collided into does anything when hit and if so runs that function, before destroying it
	if body.has_method("Hit"):
		call_deferred_thread_group("main")
		body.Hit()
	queue_free() 
