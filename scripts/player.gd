extends CharacterBody2D
@export var sprint := 100.0
@export var max_sprint := 100.0
@export var max_health := 100
var current_health := 100.0
var normal_speed = 100
var boost_speed = 150
var number_of_coins := 0
var move_speed = 0
var speed_multiplier := 1.0

var have_died = false

# Sprint system variables
var sprint_drain_rate = 40.0
var can_sprint = true

# Movement variables
var acceleration = 2000.0
var friction = 1000.0

# Dash system variables
@export var dash_speed := 150.0
@export var dash_duration = 0.2
var dash_cooldown = 0.5
var dash_timer = 0.0
var dash_cooldown_timer = 0.0
var is_dashing = false
var dash_direction = Vector2.ZERO
var can_dash = false
var damage_multiplier := 1.0

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

func _physics_process(delta: float) -> void:
	handle_dash_input()
	handle_dash(delta)
	
	if not is_dashing:
		handle_movement(delta)
		handle_sprint(delta)
	
	# move_and_slide() handles collision detection and response automatically
	# It uses the velocity property and applies it with delta time
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
		# Calculate direction towards mouse
		var mouse_pos = get_global_mouse_position()
		dash_direction = (mouse_pos - global_position).normalized()
		
		# Start dash
		is_dashing = true
		dash_timer = dash_duration
		dash_cooldown_timer = dash_cooldown
		can_dash = false  # Prevent dash spamming
		
		print("Dashing towards mouse!")

func handle_dash(delta: float):
	# Update dash cooldown
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
		
		can_dash = true
	
	if is_dashing:
		if $hitbox.disabled == true:
			$hitbox.disabled = false
		
		# Set velocity directly for dash - move_and_slide() will handle the movement
		velocity = dash_direction * dash_speed
		
		# Update dash timer
		dash_timer -= delta
		
		# End dash when timer expires
		if dash_timer <= 0:
			is_dashing = false
			print("Dash ended")

func handle_movement(delta: float):
	# Get input vector
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	
	# Handle animations
	if input_vector != Vector2.ZERO:
		$sprite.play("walk")
		
		# Calculate target velocity with proper normalization
		var target_velocity = input_vector.normalized() * move_speed * speed_multiplier
		
		# Smooth acceleration towards target velocity using move_toward
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		$sprite.play("default")
		
		# Apply friction when not moving - gradually reduce velocity to zero
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

func handle_sprint(delta: float):
	var is_moving = velocity.length() > 0
	var is_trying_to_sprint = Input.is_action_pressed("sprint") and is_moving
	var can_actually_sprint = can_sprint and sprint > 0
	
	if is_trying_to_sprint and can_actually_sprint:
		# Sprinting - drain sprint energy
		sprint -= sprint_drain_rate * delta
		sprint = max(sprint, 0)
		move_speed = boost_speed
		
		# Disable sprint when empty
		if sprint <= 0:
			can_sprint = false
	else:
		# Not sprinting
		move_speed = normal_speed
		
		# Re-enable sprint when it reaches a threshold
		if sprint >= 20:
			can_sprint = true

func take_damage(damage: float):
	if is_dashing == true:
		$camera.apply_shake(1.5)
		$hitbox.disabled = true
		current_health -= damage * 0.5
		print(current_health)
		await get_tree().create_timer(0.5).timeout
		$hitbox.disabled = false
	else:
		$camera.apply_shake(1)
		$camera/CanvasLayer/damage.visible = true
		$hitbox.disabled = true
		current_health -= damage
		print(current_health)
		await get_tree().create_timer(0.2).timeout
		$camera/CanvasLayer/damage.visible = false
		await get_tree().create_timer(0.8).timeout
		$hitbox.disabled = false
	
	print($camera/CanvasLayer/VBoxContainer/HBoxContainer/health.value)
	if current_health <= 0 and have_died == false:
		die()
		have_died = true

func die():
	print("Player died!")
	get_tree().get_root().get_node("main").gameover()

# Alternative movement function using move_and_collide() if needed
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
	
	# Using move_and_collide() - returns collision info if collision occurs
	var collision = move_and_collide(velocity * delta)
	if collision:
		# Handle collision manually if needed
		print("Collided with: ", collision.get_collider().name)
		# You can add custom collision response here

# Upgrade system integration
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
