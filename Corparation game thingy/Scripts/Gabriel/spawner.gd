extends Marker2D
var rng = RandomNumberGenerator.new()
const ENEMY_TEMPLATE_RENFORCEMENTS = preload("res://Scenes/EnemyTemplateRenforcements.tscn")
var cooldown = false
@export_category("Settings")
@export var maxEnemys = 15
@export var minEnemys = 5

func _physics_process(delta):
	if Global.Spotted == true:
		if cooldown == false:
			$Timer.start()
			cooldown = true
			for I in range(rng.randf_range(minEnemys, maxEnemys)):
				var selected = rng.randf_range(1, 1)
				if selected == 1:
					var instance = ENEMY_TEMPLATE_RENFORCEMENTS.instantiate()
					instance.global_position = self.global_position
					add_sibling(instance)
				await get_tree().create_timer(0.5).timeout


func _on_timer_timeout():
	cooldown = false
