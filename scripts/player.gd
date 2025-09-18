extends CharacterBody2D

#@onready var sprint = $camera/CanvasLayer/sprint

@export var sprint := 100.0
@export var max_health := 100

var current_health := 100.0
var normal_speed = 100
var boost_speed = 150
var number_of_coins := 0
var move_speed = 0


func _ready() -> void:
	move_speed = normal_speed
	pass
	
	
func coin():
	get_tree().get_root().get_node("main").coin()

func player():
	pass

func _process(delta: float) -> void:
	
	$camera/CanvasLayer/sprint.value = sprint
	$camera/CanvasLayer/health.value = current_health

	
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
	
	######################### Sprint #############################
	
	if Input.is_action_pressed("sprint") and (velocity.x != 0 or velocity.y != 0):
			sprint -= 40 * delta
			move_speed = boost_speed
	if Input.is_action_just_released("sprint") or sprint == 0:
		move_speed = normal_speed
	
		

		

##############################################



################# REMOVABLE ##################
