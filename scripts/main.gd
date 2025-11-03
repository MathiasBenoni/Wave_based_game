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

var base_health := 100.0

var towers := 0

@export var damage := 10.0



var upgrades_list = [
	{
		"id": 0,
		"name": "Speed Boost",
		"description": "Increases movement speed by 20%",
		"cost": 0,
		"effect": "speed_boost",
		"icon": preload("res://assets/sprites/upgrades/move_upgrade.png")
	},
	{
		"id": 1,
		"name": "Pierceing",
		"description": "Adds +1 pierce to bullets",
		"cost": 3,
		"effect": "piercing",
		"icon": preload("res://assets/sprites/upgrades/piercing.png")
	},
	{
		"id": 2,
		"name": "Extra Health",
		"description": "Adds 25 health points",
		"cost": 2,
		"effect": "extra_health",
		"icon": preload("res://assets/sprites/upgrades/card_health_upgrade.png")
	},
	{
		"id": 4,
		"name": "Damage Boost",
		"description": "Increases damage by 30%",
		"cost": 1,
		"effect": "damage_boost",
		"icon": preload("res://assets/sprites/upgrades/damage_boost.png")
	},
	{
		"id": 5,
		"name": "Firerate",
		"description": "Increse the firerate",
		"cost": 5,
		"effect": "firerate",
		"icon": preload("res://assets/sprites/upgrades/firerate.png")
	},
	{
		"id": 6,
		"name": "Defenders",
		"description": "Towers around the base to defend",
		"cost": 10,
		"effect": "towers",
		"icon": preload("res://assets/sprites/upgrades/tower.png")
	},
	{
		"id": 7,
		"name": "Dash",
		"description": "Enables dash, right click to use",
		"cost": 1,
		"effect": "Dash",
		"icon": preload("res://assets/sprites/upgrades/dash.png")
	},
	{
		"id": 8,
		"name": "Dash - cooldown",
		"description": "Decreese cooldown of dash",
		"cost": 10,
		"effect": "dash_cooldown, right click to use",
		"icon": preload("res://assets/sprites/upgrades/dash.png")
	},
	{
		"id": 9,
		"name": "Dash - speed",
		"description": "Increese speed of dash",
		"cost": 1,
		"effect": "dash_speed, right click to use",
		"icon": preload("res://assets/sprites/upgrades/dash.png")
	},
	{
		"id": 10,
		"name": "Sprint",
		"description": "Adds sprint, shift to use",
		"cost": 3,
		"effect": "sprint",
		"icon": preload("res://assets/sprites/character/sprint_upgrade.png")
	},
	{
		"id": 11,
		"name": "Heal",
		"description": "Get 100% health",
		"cost": 5,
		"effect": "heal",
		"icon": preload("res://assets/sprites/upgrades/card_health_upgrade.png")
	},
]

func set_upgrade_to_button(upgrade_id: int, button_position: int):

	
	if upgrade_id >= upgrades_list.size() or upgrade_id < 0:
		print("Error: Invalid upgrade_id: ", upgrade_id)
		return "new_id"
	

	if upgrade_id == 7 and $player.can_dash == true:
		print("new_id")
		return "new_id"
	if $player.can_dash == false:
		if (upgrade_id == 8 or upgrade_id == 9):
				return "new_id"
	
	if button_position < 1 or button_position > 4:
		print("Error: Invalid button_position: ", button_position, " (should be 1-4)")
		return "new_position"
	
	
	var upgrade_data = upgrades_list[upgrade_id]
	

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
	
	
	var button_node = get_node(button_path)
	var texture_rect = get_node(texture_rect_path)
	

	button_node.text = str(upgrade_data.cost)
	texture_rect.texture = upgrade_data.icon
	

	button_node.set_meta("upgrade_data", upgrade_data)
	
	
	if not button_node.pressed.is_connected(_on_upgrade_button_pressed):
		button_node.pressed.connect(_on_upgrade_button_pressed.bind(button_node))
	
	
	if not button_node.mouse_entered.is_connected(_on_upgrade_button_hover_enter):
		button_node.mouse_entered.connect(_on_upgrade_button_hover_enter.bind(button_node))

	
	if not button_node.mouse_exited.is_connected(_on_upgrade_button_hover_exit):
		button_node.mouse_exited.connect(_on_upgrade_button_hover_exit.bind(button_node))

	
	print("Set upgrade '", upgrade_data.name, "' to button position ", button_position)

func _on_upgrade_button_hover_enter(button):
	
		
	var upgrade_data = button.get_meta("upgrade_data")
	print("Upgrade data: ", upgrade_data.name)
	
	
	var info_label = $player/shop/Info
	
	if info_label:
		
		info_label.text = upgrade_data.name + "\n" + upgrade_data.description
		print("Set info text to: ", info_label.text)
	else:
		
		var shop_node = button.get_parent()
		while shop_node != null and shop_node.name != "shop":
			shop_node = shop_node.get_parent()
		
		if shop_node and shop_node.has_node("Info"):
			info_label = shop_node.get_node("Info")
			info_label.text = upgrade_data.name + "\n" + upgrade_data.description
			

func _on_upgrade_button_hover_exit(button):
	
	
	var info_label = $player/shop/Info
	
	if not info_label:
		var shop_node = button.get_parent()
		while shop_node != null and shop_node.name != "shop":
			shop_node = shop_node.get_parent()
		
		if shop_node and shop_node.has_node("Info"):
			info_label = shop_node.get_node("Info")
	
	if info_label:
		
		info_label.text = ""
	


func print_scene_tree(node: Node, indent: int):
	var _indent_str = ""
	for i in range(indent):
		_indent_str += "  "
	for child in node.get_children():
		print_scene_tree(child, indent + 1)






func randomize_shop():
	var available_upgrades = range(upgrades_list.size())
	available_upgrades.shuffle()
	
	var selected_upgrades = []
	var dash_unlock_id = 7  
	var player = get_player()
	
	
	if not player.can_dash:
		
		if dash_unlock_id in available_upgrades:
			available_upgrades.erase(dash_unlock_id)
			available_upgrades.insert(0, dash_unlock_id) 
	
	
	while selected_upgrades.size() < 4:
		if available_upgrades.is_empty():
			print("Warning: Ran out of upgrades to pick from — rerolling entire shop.")
			available_upgrades = range(upgrades_list.size())
			available_upgrades.shuffle()
			
			
			if not player.can_dash and dash_unlock_id in available_upgrades:
				available_upgrades.erase(dash_unlock_id)
				available_upgrades.insert(0, dash_unlock_id)
		
		var upgrade_id = available_upgrades.pop_front()  
		var upgrade_data = upgrades_list[upgrade_id]
		
		if upgrade_data["effect"] == "Dash" and player.can_dash:
			print("Skipping Dash unlock - already unlocked")
			continue 
	
		if not player.can_dash and ("dash_speed" in upgrade_data["effect"] or "dash_cooldown" in upgrade_data["effect"]):
			print("Skipping dash upgrade - player doesn't have dash yet. Effect: ", upgrade_data["effect"])
			continue  
		
		var button_position = selected_upgrades.size() + 1
		var result = set_upgrade_to_button(upgrade_id, button_position)
		

		if result == "new_id":
			print("set_upgrade_to_button rejected upgrade_id: ", upgrade_id)
			continue
		
		selected_upgrades.append(upgrade_id)
	
	print("Shop randomized successfully with valid upgrades.")




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
			get_player().can_sprint = true
			
		"extra_health":
			get_player().max_health += 25
			
		"damage_boost":
			
			$player/gun.damage_multiplier += 0.3
		"firerate":
			
			if $player/gun.firerate > 0.01:
				$player/gun.firerate -= 0.01
			
		"Dash":
			get_player().can_dash = true
			print("Dash = true")
			
		"dash_speed":
			get_player().dash_speed *= 1.2
			print("Dash speed: " + str(get_player().dash_speed))
			
		"towers":
			towers += 1
			print("towers")
		
		"piercing":
			$player/gun.piercing += 1
			
		"heal":
			$player.current_health = $player.max_health
			
		"skip":
			print("Shop skipped")
		_:
			print("Unknown effect: ", effect)

func get_player_money() -> int:
	
	return numberOfCoins

func spend_money(amount: int):
	numberOfCoins -= amount
	$player/shop/VBoxContainer2/HBoxContainer/coins.text = str(numberOfCoins)
	
	
func get_player():

	return get_tree().get_root().get_node("main/player")




func _ready() -> void:
	randomize()
	randomize_shop()
	$player/gameover.visible = false
	$player/shop/VBoxContainer/VBoxcontainer/VBoxContainer/upgrade1.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer2/VBoxContainer/upgrade2.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer3/VBoxContainer/upgrade3.custom_minimum_size = button_minimum_size
	$player/shop/VBoxContainer/VBoxContainer4/VBoxContainer/upgrade4.custom_minimum_size = button_minimum_size
	$base.health = base_health
	$player/post_wave.visible = false
	$player/esc_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED 

	$player/esc_menu.hide()
	$player/shop.hide()
	nextWave()
	
var tower_previous = 0

func nextWave():
	
	if towers != tower_previous:
		
		spawn_towers(towers - tower_previous)
		tower_previous = towers
	
	
	print("Wave " + str(numberOfWaves))
	$player/post_wave.visible = false
	$player/esc_menu.hide()
	$player/shop.hide()
	$player.position = Vector2(450,280)
	$player.sprint = 100
	numberOfWaves += 1
	print("HEALTH ", str($player.max_health))
	$player.normal_speed = $player.normal_speed * $player.speed_multiplier
	
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
		$enemies.add_child(enemy)
		
		spawn = randi_range(0, 2)
		if spawn == 1:
			enemy.global_position = $spawns/spawn1.global_position
		else:
			enemy.global_position = $spawns/spawn2.global_position

func _input(event: InputEvent) -> void:
	event = event
	if Input.is_action_just_pressed("esc"):
		pause()


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
	
	var info_label = $player/shop/Info
	if info_label:
		info_label.text = ""
	pass

func _on_continue_pressed() -> void:
	pause()

func gameover():
	get_tree().paused = true
	$player/gameover.visible = true

func _on_player_i_died() -> void:
	gameover()
func _on_quit_pressed() -> void:
	print("Quit")
func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
func _on_game_over_restart_pressed() -> void:
	print("RESTART")
	get_tree().paused = false  
	get_tree().reload_current_scene()
func _on_game_over_quit_pressed() -> void:
	print("QUIT")
	get_tree().quit()
func _on_button_pressed() -> void:
	print("Skip")
	apply_upgrade_effect("skip")
	nextWave()
	

func spawn_towers(number_of_towers):
	var tower_scene = preload("res://scenes/tower.tscn")
	var min_distance = 50.0
	var max_distance = 100.0
	var min_tower_spacing = 30.0 
	var max_attempts = 100 
	
	var tower_positions = [] 
	
	for n in number_of_towers:
		var tower_instantiated = tower_scene.instantiate()
		var valid_position = false
		var attempts = 0
		var new_position = Vector2.ZERO


		while not valid_position and attempts < max_attempts:

			var angle = randf() * TAU
			var distance = randf_range(min_distance, max_distance)
			
		
			var offset = Vector2(cos(angle), sin(angle)) * distance
			new_position = $base.position + offset
			
			valid_position = true
			for existing_pos in tower_positions:
				if new_position.distance_to(existing_pos) < min_tower_spacing:
					valid_position = false
					break
			
			attempts += 1
		
		if valid_position:
			tower_instantiated.position = new_position
			tower_positions.append(new_position)
			add_child(tower_instantiated)
		else:
			print("Warning: Could not find valid position for tower after ", max_attempts, " attempts")
			tower_instantiated.queue_free() 



func minus_base_life():
	base_health -= damage * 0.8
	$base.health = base_health
	print(base_health)
	
	pass
