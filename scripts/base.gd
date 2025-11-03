extends Area2D

@export var health := 100.0

func base():
	pass

func _ready() -> void:
	$AnimatedSprite2D.play("100")



func _process(delta: float) -> void:
	
	if health <= 100 and health > 75:
		$AnimatedSprite2D.play("100")
	elif health <= 75 and health > 50:
		$AnimatedSprite2D.play("75")
	elif health <= 50 and health > 40:
		$AnimatedSprite2D.play("50")
	elif health <= 40 and health > 20:
		$AnimatedSprite2D.play("40")
	elif health <= 20 and health > 10:
		$AnimatedSprite2D.play("20")
	else:
		$AnimatedSprite2D.play("10")
