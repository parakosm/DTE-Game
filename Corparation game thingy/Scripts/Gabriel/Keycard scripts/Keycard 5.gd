extends Sprite2D


func _on_objective_visible_key_card(keyType):
	if keyType == 5:
		self.visible = true
