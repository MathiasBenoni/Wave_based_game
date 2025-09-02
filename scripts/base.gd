extends Area2D

func base():
	pass

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	delta = delta
	pass


func _on_body_entered(body: Node2D) -> void:
	
	if body.has_method("enemy"):
		print("DEAD")
