extends Node


var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spawn
var number_of_enemies = 12
var n = true
var ispostwavetrue = false


func _ready() -> void:
	
	$player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/upgrade1.custom_minimum_size = Vector2(179	,10)

	$player/post_wave.visible = false
	$player/esc_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	Node.PROCESS_MODE_WHEN_PAUSED
	$player/esc_menu.hide()
	$player/shop.hide()
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
	
	if $enemies.get_child_count() == 0 and n == true: 
		print("Shop!")
		post_wave()
		
		n = false
		
	if Input.is_action_just_pressed("enter"):
		$player/post_wave.visible = false
		ispostwavetrue = false
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
	print("-1 life")


func new_wave():
	n = true
	pass

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


func _on_upgrade_2_pressed() -> void:
	print("Button 2 pressed")


func _on_upgrade_3_pressed() -> void:
	print("Button 3 pressed")


func _on_upgrade_4_pressed() -> void:
	print("Button 4 pressed")
