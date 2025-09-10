extends Node


var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spawn
var number_of_enemies = 12
var ispostwavetrue = false
var numberOfWaves = 0
var startPos = Vector2(450,280)

func _ready() -> void:
	
	$player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/upgrade1.custom_minimum_size = Vector2(179	,10)

	$player/post_wave.visible = false
	$player/esc_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	Node.PROCESS_MODE_WHEN_PAUSED
	$player/esc_menu.hide()
	$player/shop.hide()
	nextWave()
	
	

func nextWave():
	print("Wave " + str(numberOfWaves))
	$player/post_wave.visible = false
	$player/esc_menu.hide()
	$player/shop.hide()
	$player.position = Vector2(450,280)
	$player.health = 100
	$player.sprint = 100
	numberOfWaves += 1
	
	for n in $coins.get_children():
		$coins.remove_child(n)
		n.queue_free()
	
	for n in $player/gun/bullets.get_children():
		$player/gun/bullets.remove_child(n)
		n.queue_free()
		
	spawnEnemies()


func spawnEnemies():
	for n in number_of_enemies:
		var enemy = enemy_scene.instantiate()
		spawn = randi_range(0, 2)
		if spawn == 1:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn1").position
		else:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn2").position
		$enemies.add_child(enemy)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("esc"):
		pause()
		
	if Input.is_action_just_pressed("test_key"):
		$player/shop.show()
	
	if Input.is_action_just_released("test_key"):
		$player/shop.hide()


func _process(delta: float) -> void:
	delta = delta
	
	
	if $enemies.get_child_count() == 0:
		
		post_wave()
		
		
		if Input.is_action_just_pressed("enter"):
			$player/post_wave.visible = false
			ispostwavetrue = false
			print("Shop!")
			shop()


func pause():
	
	if $player/esc_menu.visible:
		$player/esc_menu.hide()
		get_tree().paused = false
	else:
		$player/esc_menu.show()
		get_tree().paused = true



func minus_life():
	$player.health -= 10
	$player/hitbox.disabled = true
	await get_tree().create_timer(1).timeout
	$player/hitbox.disabled = false
	

func post_wave():
	$player/post_wave.visible = true
	ispostwavetrue = true
	pass


func shop():
	$player/shop.visible = true
	pass

func _on_continue_pressed() -> void:
	pause()


func _on_quit_pressed() -> void:
	get_tree().quit()


	
	


func _on_upgrade_1_pressed() -> void:
	print("Button 1 pressed")
	nextWave()

func _on_upgrade_2_pressed() -> void:
	print("Button 2 pressed")
	nextWave()

func _on_upgrade_3_pressed() -> void:
	print("Button 3 pressed")
	nextWave()

func _on_upgrade_4_pressed() -> void:
	print("Button 4 pressed")
	nextWave()
