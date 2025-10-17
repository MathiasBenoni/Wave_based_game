extends Node


var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spawn
var number_of_enemies = 5
var ispostwavetrue = false
var numberOfWaves = 0
var startPos = Vector2(450,280)
var numberOfCoins := 0
var temp_damage := 0.0
var button_minimum_size = Vector2(200, 10)


@export var damage := 10.0



var upgrades_list = [
	{
		"id": 0,
		"name": "Speed Boost",
		"description": "Increases movement speed by 20%",
		"cost": 0,
		"effect": "speed_boost",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 1,
		"name": "Double Jump",
		"description": "Allows double jumping",
		"cost": 3,
		"effect": "sprint, shift to use",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 2,
		"name": "Extra Health",
		"description": "Adds 25 health points",
		"cost": 2,
		"effect": "extra_health",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 4,
		"name": "Damage Boost",
		"description": "Increases damage by 30%",
		"cost": 1,
		"effect": "damage_boost",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 5,
		"name": "Shield",
		"description": "Shield for + 2 hitpoints for the base",
		"cost": 6,
		"effect": "shield",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 6,
		"name": "Defenders",
		"description": "Towers around the base to defend",
		"cost": 10,
		"effect": "towers",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 7,
		"name": "Dash - Enable",
		"description": "Enables dash, right click to use",
		"cost": 15,
		"effect": "dash_cooldown, right click to use",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 8,
		"name": "Dash - cooldown",
		"description": "Decreese cooldown of dash",
		"cost": 10,
		"effect": "dash_cooldown, right click to use",
		"icon": preload("res://assets/sprites/gun/placeholder.png")
	},
	{
		"id": 9,
		"name": "Dash - speed",
		"description": "Increese speed of dash",
		"cost": 1,
		"effect": "dash_speed, right click to use",
		"icon": preload("res://assets/sprites/character/placeholder.png")
	}
]

func set_upgrade_to_button(upgrade_id: int, button_position: int):
	# Validate inputs
	if upgrade_id >= upgrades_list.size() or upgrade_id < 0:
		print("Error: Invalid upgrade_id: ", upgrade_id)
		return "new_id"
	elif upgrade_id == 7:
		return "new_id"
	elif upgrade_id == 8 or upgrade_id == 9:
		if $player.can_dash == false:
			return "new_id"
	if upgrade_id == 7 and $player.can_dash == true:
		randomize_shop()
	
	if button_position < 1 or button_position > 4:
		print("Error: Invalid button_position: ", button_position, " (should be 1-4)")
		return "new_position"
	
		
	var upgrade_data = upgrades_list[upgrade_id]
	
	# Get the button node path based on position
	var button_path = ""
	var texture_rect_path = ""
	match button_position:
		1:
			button_path = "player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/upgrade1"
			texture_rect_path = "player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/TextureRect"
		2:
			button_path = "player/shop/VBoxContainer/VBoxContainer2/VBoxContainer/upgrade2"
			texture_rect_path = "player/shop/VBoxContainer/VBoxContainer2/VBoxContainer/TextureRect"
		3:
			button_path = "player/shop/VBoxContainer/VBoxContainer3/VBoxContainer/upgrade3"
			texture_rect_path = "player/shop/VBoxContainer/VBoxContainer3/VBoxContainer/TextureRect"
		4:
			button_path = "player/shop/VBoxContainer/VBoxContainer4/VBoxContainer/upgrade4"
			texture_rect_path = "player/shop/VBoxContainer/VBoxContainer4/VBoxContainer/TextureRect"
	
	# Get the button node
	var button_node = get_node(button_path)
	var texture_rect = get_node(texture_rect_path)
	
	# Update button text and properties
	button_node.text = str(upgrade_data.cost)
	texture_rect.texture = upgrade_data.icon
	
	# Store upgrade data in the button for later use
	button_node.set_meta("upgrade_data", upgrade_data)
	
	# Connect the pressed signal if not already connected
	if not button_node.pressed.is_connected(_on_upgrade_button_pressed):
		button_node.pressed.connect(_on_upgrade_button_pressed.bind(button_node))
	
	# Connect hover signals for showing description
	if not button_node.mouse_entered.is_connected(_on_upgrade_button_hover_enter):
		button_node.mouse_entered.connect(_on_upgrade_button_hover_enter.bind(button_node))

	
	if not button_node.mouse_exited.is_connected(_on_upgrade_button_hover_exit):
		button_node.mouse_exited.connect(_on_upgrade_button_hover_exit.bind(button_node))

	
	print("Set upgrade '", upgrade_data.name, "' to button position ", button_position)

func _on_upgrade_button_hover_enter(button):
	
		
	var upgrade_data = button.get_meta("upgrade_data")
	print("Upgrade data: ", upgrade_data.name)
	
	# Get the info label - it should be a sibling of the VBoxContainer that contains the buttons
	var info_label = $player/shop/Info
	
	if info_label:
		# Display upgrade name and description
		info_label.text = upgrade_data.name + "\n" + upgrade_data.description
		print("Set info text to: ", info_label.text)
	else:
		# Try alternative path
		var shop_node = button.get_parent()
		while shop_node != null and shop_node.name != "shop":
			shop_node = shop_node.get_parent()
		
		if shop_node and shop_node.has_node("Info"):
			info_label = shop_node.get_node("Info")
			info_label.text = upgrade_data.name + "\n" + upgrade_data.description
			

func _on_upgrade_button_hover_exit(button):
	
	# Same logic as enter function
	var info_label = $player/shop/Info
	
	if not info_label:
		var shop_node = button.get_parent()
		while shop_node != null and shop_node.name != "shop":
			shop_node = shop_node.get_parent()
		
		if shop_node and shop_node.has_node("Info"):
			info_label = shop_node.get_node("Info")
	
	if info_label:
		# Clear the description when mouse leaves
		info_label.text = ""
	

# Helper function to debug scene tree structure
func print_scene_tree(node: Node, indent: int):
	var _indent_str = ""
	for i in range(indent):
		_indent_str += "  "
	for child in node.get_children():
		print_scene_tree(child, indent + 1)

func randomize_shop():
	var available_upgrades = range(upgrades_list.size())  # [0, 1, 2, 3, 4, 5]
	available_upgrades.shuffle()

	for i in range(4):
		var upgrade_id = available_upgrades[i]
		var button_position = i + 1
		set_upgrade_to_button(upgrade_id, button_position)
		if set_upgrade_to_button(upgrade_id, button_position) == "new_id":
			print("invalid id")
			randomize_shop()
		

func _on_upgrade_button_pressed(button):
	var upgrade_data = button.get_meta("upgrade_data")
	
	var player_money = get_player_money() 
	
	if player_money >= upgrade_data.cost:

		spend_money(upgrade_data.cost)
		
		
		apply_upgrade_effect(upgrade_data.effect)
		
		print("Purchased: ", upgrade_data.name)
		
		nextWave()
		
	else:
		print("Not enough money! Need: ", upgrade_data.cost, " Have: ", player_money)


func apply_upgrade_effect(effect: String):
	
	match effect:
		"speed_boost":
			
			get_player().speed_multiplier += 0.02
		"sprint":
			if get_player().can_sprint == true:
				get_player().sprint_multiplier += 0.02
			get_player().can_sprint = true
			
		"extra_health":
			get_player().max_health += 25
			get_player().current_health += 25
		"damage_boost":
			
			get_player().damage_multiplier += 0.3
		"shield":
			
			get_player().activate_shield(5.0)  # 5 seconds
		"dash_speed":
			if get_player().can_dash == false:
				get_player().can_dash = true
			else:
				get_player().dash_speed *= 1.2
				print("Dash speed: " + str(get_player().dash_speed))
		"skip":
			print("Shop skipped")
		_:
			print("Unknown effect: ", effect)

func get_player_money() -> int:
	
	return numberOfCoins

func spend_money(amount: int):
	numberOfCoins -= amount

func get_player():

	return get_tree().get_root().get_node("main/player")




func _ready() -> void:
	randomize_shop()
	$player/gameover.visible = false
	$player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/upgrade1.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer2/VBoxContainer/upgrade2.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer3/VBoxContainer/upgrade3.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer4/VBoxContainer/upgrade4.custom_minimum_size = button_minimum_size

	$player/post_wave.visible = false
	$player/esc_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 

	$player/esc_menu.hide()
	$player/shop.hide()
	nextWave()
	
	

func nextWave():
	print("Wave " + str(numberOfWaves))
	$player/post_wave.visible = false
	$player/esc_menu.hide()
	$player/shop.hide()
	$player.position = Vector2(450,280)
	$player.current_health = $player.max_health
	$player.sprint = 100
	numberOfWaves += 1
	print("HEALTH ", str($player.max_health))
	$player.normal_speed = $player.normal_speed * $player.speed_multiplier
	$player.can_sprint = true
	for n in $coins.get_children():
		$coins.remove_child(n)
		n.queue_free()
	
	for n in $player/gun/bullets.get_children():
		$player/gun/bullets.remove_child(n)
		n.queue_free()
		
	spawnEnemies()



func spawnEnemies():
	for n in number_of_enemies * round(numberOfWaves * 0.5):
		var enemy = enemy_scene.instantiate()
		spawn = randi_range(0, 2)
		if spawn == 1:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn1").position
		else:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn2").position
		$enemies.add_child(enemy)

func _input(event: InputEvent) -> void:
	event = event
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


func coin():
	numberOfCoins += 1
	$player/shop/VBoxContainer2/HBoxContainer/coins.text = str(numberOfCoins)
	print("Coins: " + str(numberOfCoins))


func minus_life():
	$player.take_damage(damage)
		

func post_wave():
	$player/post_wave.visible = true
	ispostwavetrue = true
	pass


func shop():
	randomize_shop()
	$player/shop.visible = true
	# Clear info labeldwawswd when shop opens
	var info_label = $player/shop/Info
	if info_label:
		info_label.text = ""
	pass

func _on_continue_pressed() -> void:
	pause()


func gameover():
	
	get_tree().paused = true
	$player/gameover.visible = true
	
	#get_tree().change_scene_to_file("res://scenes/startscreen.tscn")


func _on_player_i_died() -> void:
	gameover()


func _on_quit_pressed() -> void:
	print("Quit")


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_game_over_restart_pressed() -> void:
	print("RESTART")
	get_tree().paused = false  # Unpause the game first!
	get_tree().reload_current_scene()


func _on_game_over_quit_pressed() -> void:
	print("QUIT")
	get_tree().quit()
