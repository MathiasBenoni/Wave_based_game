extends CharacterBody2D

@export var SPEED : int = 300
var speed_mult = 1


@export var damage := 10


func bullet():
	pass

func _process(delta: float) -> void:
	
	
	SPEED = SPEED * speed_mult
	
	
	
	
	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
