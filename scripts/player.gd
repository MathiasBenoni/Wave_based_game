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
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"):
		$sprite.play("walk")
	else:
		$sprite.play("default")
	
	velocity = input_vector.normalized() * move_speed
	move_and_collide(velocity * delta)
	
	

##############################################


################# REMOVABLE ##################
