extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Keycard Collected")
	Global.KeycardObtained = true
	queue_free()
