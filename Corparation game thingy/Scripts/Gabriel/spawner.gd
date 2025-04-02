extends Marker2D
var rng = RandomNumberGenerator.new()
const ENEMY_TEMPLATE_RENFORCEMENTS = preload("res://Scenes/EnemyTemplateRenforcements.tscn")
const MACHINE_GUN_ENEMY_RENFORCEMENTS = preload("res://Scenes/EnemyTypes/Machine Gun Enemy Renforcements.tscn")
const SHOTGUN_ENEMY_RENFORCEMENTS = preload("res://Scenes/EnemyTypes/Shotgun Enemy Renforcements.tscn")
var cooldown = false
@export_category("Settings")
@export var maxEnemys = 15
@export var minEnemys = 5

func _physics_process(delta):
	if Global.Spotted == true: # if player spotted itll start renforceing 
		if cooldown == false:# renforces every x seconds
			$Timer.start()
			cooldown = true
			for I in range(rng.randf_range(minEnemys, maxEnemys)):# spawns the enmy renforcements 
				var selected = rng.randf_range(1, 2)
				selected = roundf(selected)
				print(selected)
				if selected == 1:
					var instance = MACHINE_GUN_ENEMY_RENFORCEMENTS.instantiate()
					instance.global_position = self.global_position
					add_sibling(instance)
					print("wut")
				if selected == 2:
					var instance = SHOTGUN_ENEMY_RENFORCEMENTS.instantiate()
					instance.global_position = self.global_position
					add_sibling(instance)
				print("somthing not good")
				await get_tree().create_timer(0.5).timeout# adds a delay between spawning to decrese lag


func _on_timer_timeout():
	cooldown = false
