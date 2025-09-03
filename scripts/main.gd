extends Node


var enemy_scene = preload("res://scenes/enemy/enemy.tscn")
var spawn
var number_of_enemies = 12

func _ready() -> void:
	for n in number_of_enemies:
		var enemy = enemy_scene.instantiate()
		spawn = randi_range(0, 2)
		if spawn == 1:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn1").position
		else:
			enemy.position = get_tree().get_root().get_node("main/spawns/spawn2").position
		$enemies.add_child(enemy)


func _process(delta: float) -> void:
	delta = delta
	
	if Input.is_action_just_pressed("esc"):
		if $player/esc_menu.visible:
			$player/esc_menu.hide()
		else:
			$player/esc_menu.show()
	
	pass

func minus_life():
	$player.position = $base.position
	print("-1 life")
