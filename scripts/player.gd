extends CharacterBody2D

var move_speed : int = 100


func _ready() -> void:
	pass

func player():
	pass

func _process(delta: float) -> void:
	
	
############ Snur spritet ####################

	var mouse_position = get_global_mouse_position()
	var object_position = global_position
	
	if mouse_position.x < object_position.x:
		$sprite.flip_h = true
	else:
		$sprite.flip_h = false
	
################# Movement ###################

	if Input.is_action_pressed("move_up"):
		velocity.y = -move_speed * delta
		#print(velocity.y)

	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed * delta

	if Input.is_action_pressed("move_right"):
		velocity.x = move_speed * delta

	if Input.is_action_pressed("move_down"):
		velocity.y = move_speed * delta

		
	move_and_collide(velocity)
	velocity = Vector2.ZERO
	
##############################################


################# REMOVABLE ##################
