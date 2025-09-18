extends Area2D


var isColliding = false

func coin():
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	delta = delta
	$AnimatedSprite2D.play("ash")
	
		

#func _on_body_entered(body: Node2D) -> void:
	#if body.has_method("player") and isColliding == false:
		#queue_free()
		#get_tree().get_root().get_node("main").coin()
		#isColliding = true
		#
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		get_tree().get_root().get_node("main").coin()
		call_deferred("queue_free")

	#if body.has_method("player"):
		#queue_free()
		##body.coin()
		#print("+1 coin")
