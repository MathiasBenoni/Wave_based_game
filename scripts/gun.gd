extends Area2D

var bullet_scene = preload("res://scenes/main_character/bullet.tscn")

@export var firerate := 0.5



var is_hot = false

func _ready() -> void:
	$cooldown.wait_time = firerate
	pass


func _process(delta: float) -> void:
	delta = delta
	
################ SER PÅ CURSOREN ################

	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 && rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

#################################################

	if Input.is_action_pressed("shoot"):
		if !is_hot:
			is_hot = true
			shoot()
			$cooldown.start()
		

func shoot():
	

	var bullet = bullet_scene.instantiate()
	bullet.global_position = $barrel.global_position
	bullet.rotation = rotation
	$bullets.add_child(bullet)
	


func _on_cooldown_timeout() -> void:
	is_hot = false
