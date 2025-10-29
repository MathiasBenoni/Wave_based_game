extends CharacterBody2D

var current_health := 100.0

var number_of_coins := 0
var move_speed = 0


# Upgrades
@export var sprint := 100.0
@export var max_sprint := 100.0
@export var max_health := 100
var speed_multiplier := 1.0
var sprint_drain_rate = 40.0
var can_sprint = true
var normal_speed = 100
var boost_speed = 150

var sprint_multiplier := 1.0


# Dash system variables
@export var dash_speed := 150.0
@export var dash_duration = 0.2
var dash_cooldown = 0.5
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var is_dashing = false
var dash_direction = Vector2.ZERO
var can_dash = false


var have_died = false

# Invincibility system
var is_invincible = false
var invincibility_duration = 0.8

# Sprint system variables


# Movement variables
var acceleration = 2000.0
var friction = 1000.0




var temp_enemy_damage_mult


func _ready() -> void:
	move_speed = normal_speed
	$camera/CanvasLayer/VBoxContainer/HBoxContainer/health.max_value = max_health

func coin():
	get_tree().get_root().get_node("main").coin()

func player():
	pass

func screen_shake(x):
	$camera.apply_shake(x)

func _process(delta: float) -> void:
	delta = delta
	if current_health <= 0 and have_died == false:
		die()
		have_died = true
	
	$camera/CanvasLayer/VBoxContainer/HBoxContainer/health.max_value = max_health
	update_ui()
	handle_sprite_direction()

	#if is_invincible == true:
		#$damagebox.disabled = true
	#else:
		#$damagebox.disabled = false

func _physics_process(delta: float) -> void:
	handle_dash_input()
	handle_dash(delta)
	
	if not is_dashing:
		handle_movement(delta)
		handle_sprint(delta)
	
	move_and_slide()

func update_ui():
	$camera/CanvasLayer/VBoxContainer/HBoxContainer2/sprint.value = sprint
	$camera/CanvasLayer/VBoxContainer/HBoxContainer/health.value = current_health

func handle_sprite_direction():
	var mouse_position = get_global_mouse_position()
	var object_position = global_position
	
	if mouse_position.x < object_position.x:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false

func handle_dash_input():
	if Input.is_action_just_pressed("right_click") and can_dash == true:
		start_dash()

func start_dash():
	if dash_cooldown_timer <= 0:
		var mouse_pos = get_global_mouse_position()
		dash_direction = (mouse_pos - global_position).normalized()
		
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		can_dash = false
		
		print("Dashing towards mouse!")

func handle_dash(delta: float):
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		can_dash = true
	
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		
		if dash_timer <= 0:
			is_dashing = false
			print("Dash ended")

func handle_movement(delta: float):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		$sprite.play("walk")
		var target_velocity = input_vector.normalized() * move_speed * speed_multiplier
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		$sprite.play("default")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func handle_sprint(delta: float):
	var is_moving = velocity.length() > 0
	var is_trying_to_sprint = Input.is_action_pressed("sprint") and is_moving
	var can_actually_sprint = can_sprint and sprint > 0
	
	if is_trying_to_sprint and can_actually_sprint:
		sprint -= sprint_drain_rate * delta
		sprint = max(sprint, 0)
		move_speed = boost_speed * sprint_multiplier
		
		if sprint <= 0:
			can_sprint = false
	else:
		move_speed = normal_speed
		
		if sprint >= 20:
			can_sprint = true

func take_damage(damage: float):
	
	if is_invincible:
		return
	
	var actual_damage = damage
	
	if is_dashing:
		$camera.apply_shake(1.5)
		actual_damage = damage * 0.5
	else:
		$camera.apply_shake(1)
	
		current_health -= actual_damage
	
	print("Took damage: ", actual_damage, " | Current health: ", current_health)
	

	start_invincibility()
	
	# Show damage overlay
	$camera/CanvasLayer/damage.visible = true
	await get_tree().create_timer(0.2).timeout
	$camera/CanvasLayer/damage.visible = false
	
	if current_health <= 0 and have_died == false:
		die()
		have_died = true

func start_invincibility():
	is_invincible = true
	
	# Visual feedback - flash the sprite
	var flash_count = 6
	for i in range(flash_count):
		$sprite.modulate.a = 0.3
		await get_tree().create_timer(invincibility_duration / (flash_count * 2)).timeout
		$sprite.modulate.a = 1.0
		await get_tree().create_timer(invincibility_duration / (flash_count * 2)).timeout
	
	is_invincible = false

func die():
	print("Player died!")
	get_tree().get_root().get_node("main").gameover()

func handle_movement_with_collide(delta: float):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	if input_vector != Vector2.ZERO:
		$sprite.play("walk")
		var target_velocity = input_vector.normalized() * move_speed * speed_multiplier
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		$sprite.play("default")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("Collided with: ", collision.get_collider().name)

func apply_speed_boost(multiplier: float):
	speed_multiplier += multiplier
	print("Speed boost applied! New multiplier: ", speed_multiplier)

func increase_max_health(amount: int):
	max_health += amount
	current_health += amount
	print("Max health increased to: ", max_health)

func upgrade_dash_speed(amount: float):
	dash_speed += amount
	print("Dash speed increased to: ", dash_speed)

func upgrade_dash_cooldown(reduction: float):
	dash_cooldown -= reduction
	dash_cooldown = max(dash_cooldown, 0.1)
	print("Dash cooldown reduced to: ", dash_cooldown)
