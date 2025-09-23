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
var can_dash = true

func _ready() -> void:
	move_speed = normal_speed

func coin():
	get_tree().get_root().get_node("main").coin()

func player():
	pass

func screen_shake(x):
	$camera.apply_shake(x)

func _process(delta: float) -> void:
	delta = delta
	$camera/CanvasLayer/VBoxContainer/HBoxContainer/health.max_value = max_health
	update_ui()
	handle_sprite_direction()

func _physics_process(delta: float) -> void:
	handle_dash_input()
	handle_dash(delta)
	
	if not is_dashing:
		handle_movement(delta)
		handle_sprint(delta)
	
	# Use move_and_slide() instead of move_and_collide() for better collision handling
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
	# Check for dash input (you can change this to any key you prefer)
	if Input.is_action_just_pressed("right_click") and can_dash:  # Space bar by default
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
		
		print("Dashing towards mouse!")

func handle_dash(delta: float):
	# Update dash cooldown
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	if is_dashing:
		if $hitbox.disabled == true:
			$hitbox.disabled = false
			
			
		# Apply dash velocity
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
		
		# Smooth acceleration towards target velocity
		var target_velocity = input_vector.normalized() * move_speed * speed_multiplier
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
	else:
		$sprite.play("default")
		
		# Apply friction when not moving
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
func handle_sprint(delta: float):
	var is_moving = velocity.length() > 0
	var is_trying_to_sprint = Input.is_action_pressed("sprint") and is_moving
	var can_actually_sprint = can_sprint and sprint > 0
	
	# Update sprint regen timer
	
	if is_trying_to_sprint and can_actually_sprint:
		# Sprinting
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
		current_health = max(current_health, 0)
		await get_tree().create_timer(0.5).timeout
		$hitbox.disabled = false
	else:
		$camera.apply_shake(1)
		$camera/CanvasLayer/damage.visible = true
		$hitbox.disabled = true
		current_health -= damage
		current_health = max(current_health, 0)
		await get_tree().create_timer(0.2).timeout
		$camera/CanvasLayer/damage.visible = false
		await get_tree().create_timer(0.8).timeout
		$hitbox.disabled = false
	
	if current_health <= 0:
		die()

func die():
	print("Player died!")
	get_tree().get_root().get_node("main").gameover()
	# Add death logic here

# Upgrade system integration
func apply_speed_boost(multiplier: float):
	speed_multiplier += multiplier
	print("Speed boost applied! New multiplier: ", speed_multiplier)

func increase_max_health(amount: int):
	max_health += amount
	current_health += amount  # Also heal when gaining max health
	print("Max health increased to: ", max_health)

# Dash upgrade functions
func upgrade_dash_speed(amount: float):
	dash_speed += amount
	print("Dash speed increased to: ", dash_speed)

func upgrade_dash_cooldown(reduction: float):
	dash_cooldown -= reduction
	dash_cooldown = max(dash_cooldown, 0.5)  # Minimum cooldown
	print("Dash cooldown reduced to: ", dash_cooldown)
