extends CharacterBody2D

var SPEED : int = 50
var base
var target
var coin_scene = preload("res://scenes/coin.tscn")
var spredning = 20
var max_health := 100.0
var health = max_health

var damage_multiplier := 1.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func enemy():
	pass

func _ready() -> void:
	add_to_group("enemies")
	SPEED = randi_range(30, 100)
	target = randi_range(0, 2)
	
	# Setup navigation agent
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	# Wait for navigation to be ready
	call_deferred("setup_navigation")

func setup_navigation():
	# Wait for navigation map to be ready
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	# Make sure navigation agent is ready
	if not navigation_agent.is_inside_tree():
		await navigation_agent.ready
	
	update_target_position()

func update_target_position():
	if target == 1:
		base = get_tree().get_root().get_node("main/base").position
	else:
		base = get_tree().get_root().get_node("main/player").position
	
	navigation_agent.target_position = base
	

func _physics_process(delta: float) -> void:
	delta = delta
	# Update target every frame for dynamic following
	update_target_position()
	
	# Check if navigation is working
	if not navigation_agent.is_navigation_finished():
		# Get next position in path
		var next_path_position = navigation_agent.get_next_path_position()
		var direction = (next_path_position - global_position).normalized()
		
		velocity = direction * SPEED
		move_and_slide()
	else:
		# If finished navigating, just stop
		velocity = Vector2.ZERO
	
	# Check for player collision
	check_player_presense()

func check_player_presense():
	var area = $Area2D

	for overlapped_body in area.get_overlapping_bodies():
		if overlapped_body.name == "player":
			if overlapped_body.is_invincible == true:
				return
			if overlapped_body.is_dashing == true:
				die()
			
			attack()
			
			

func attack():
	
	
	
	player_minuslife()

func player_minuslife():
	get_tree().get_root().get_node("main").minus_life()

func die():
	var coin = coin_scene.instantiate()
	coin.position = Vector2(position.x + randf_range(-spredning, spredning), position.y + randf_range(-spredning, spredning))
	get_tree().get_root().get_node("main/coins").call_deferred("add_child", coin)
	queue_free()

func take_damage(body):
	var damage = body.damage
	health -= damage
	$health.value = health
	
	body.piercing -= 1
	
	#body.queue_free()
	
	if health <= 0:
		die()
		
	$AnimatedSprite2D.play("damaged")
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.has_method("bullet"):
		take_damage(body)


func _process(_delta: float) -> void:
	
	if entered_base == true and cooldown == false:
		$cooldown.start()
		cooldown = true
		get_tree().get_root().get_node("main").minus_base_life()

var cooldown := false
var entered_base := false

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	if area.has_method("base"):
		entered_base = true
		


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_method("base"):
		entered_base = false


func _on_cooldown_timeout() -> void:
	cooldown = false
