extends Area2D
@export var keyType = 1
signal visibleKeyCard(keyType)

func _ready():
	visibleKeyCard.emit(keyType)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.KeycardObtained = true
		queue_free()
