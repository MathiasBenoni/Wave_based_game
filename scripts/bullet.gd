extends Node2D

@export var SPEED : int = 300
var speed_mult = 1

var piercing = 1

@export var damage := 10


func bullet():
	pass

func _ready() -> void:
	$MeshInstance2D.modulate = Color(0, 0, 0)

func _process(delta: float) -> void:
	
	
	if piercing == 0:
		queue_free()
	
	SPEED = SPEED * speed_mult
	
	

	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
