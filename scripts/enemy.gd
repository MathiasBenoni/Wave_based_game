extends Area2D

var SPEED : int = 50
var base
var target
var coin_scene = preload("res://scenes/coin.tscn")
var spredning = 20

signal minus_life

func enemy():
	pass

func _ready() -> void:
	SPEED = randi_range(30, 100)
	target = randi_range(0, 2)
	


func _process(delta: float) -> void:
	if target == 1:
		base = get_tree().get_root().get_node("main/base").position
	else:
		base = get_tree().get_root().get_node("main/player").position
	position = position.move_toward(base, SPEED * delta)
	
	#velocity = Vector2(get_tree().get_root().get_node("main/player").position.x, 0).normalized() * SPEED
	
	#velocity = move_toward(position.x, get_tree().get_root().get_node("main/player").position.x, delta)
	#velocity.x = move_toward(velocity.x, get_tree().get_root().get_node("main/player").position.x, SPEED)
	#velocity.y = move_toward(velocity.y, get_tree().get_root().get_node("main/player").position.y, SPEED)
	#
	#move_and_slide()
	#position += velocity * delta


	for overlapped_body in get_overlapping_bodies():
		if overlapped_body.name == "player":
			get_tree().get_root().get_node("main").minus_life()
		#print("hit: ", overlapped_body.name)




func _on_body_entered(body: Node2D) -> void:
	
	if body.has_method("bullet"):
		body.queue_free()
		
		var coin = coin_scene.instantiate()
		coin.position = Vector2(position.x + randf_range(-spredning, spredning), position.y + randf_range(-spredning, spredning))
		get_tree().get_root().get_node("main/coins").call_deferred("add_child", coin)
				
		queue_free()
