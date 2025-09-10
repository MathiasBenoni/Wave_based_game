extends Area2D

func coin():
	pass

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	delta = delta
	$AnimatedSprite2D.play("ash")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		print("+1 coin")
		queue_free()
		


func _on_timeout_timeout() -> void:
	queue_free()
