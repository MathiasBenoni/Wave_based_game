extends Node


var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spawn
var number_of_enemies = 12

func _ready() -> void:
	$player/esc_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	$player/esc_menu.hide()
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

func pause():
	
	if $player/esc_menu.visible:
		$player/esc_menu.hide()
		get_tree().paused = false
	else:
		$player/esc_menu.show()
		get_tree().paused = true

func _process(delta: float) -> void:
	delta = delta
	
	
	
	pass

func minus_life():
	$player.position = $base.position
	print("-1 life")


func _on_continue_pressed() -> void:
	pause()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	print("Test1")
