extends StaticBody2D
var timer_start := true

func _ready() -> void:
	add_to_group("towers")

func _process(delta: float) -> void:
	delta = delta
	if timer_start == true:
		$cooldown.start()
		timer_start = false

func get_all_enemies():
	var enemies = []
	var enemies_node = get_node("../enemies")  
	
	if enemies_node:
		for child in enemies_node.get_children():
			
			if child is CharacterBody2D:
				enemies.append(child)
	
	return enemies

func _on_cooldown_timeout() -> void:
	var enemies = get_all_enemies()
	
	if enemies.size() > 0:
		var random_enemy = enemies[randi() % enemies.size()]
		var direction = (random_enemy.global_position - global_position).normalized()
		
		var bullet_scene = preload("res://scenes/main_character/bullet.tscn")
		var bullet = bullet_scene.instantiate()
		bullet.position = position
		bullet.piercing = 1
		
		bullet.rotation = direction.angle()
		
		get_parent().add_child(bullet)
	
	timer_start = true
