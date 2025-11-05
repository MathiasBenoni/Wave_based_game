extends Node2D

@export var particle_count: int = 20
@export var emission_duration: float = 0.5
@export var initial_velocity_min: Vector2 = Vector2(-200, -150)
@export var initial_velocity_max: Vector2 = Vector2(200, -250)
@export var gravity: float = 500.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var particles: Array = []
var emission_timer: float = 0.0
var available_animations: PackedStringArray = []

class Particle:
	var position: Vector2
	var velocity: Vector2
	var animation_name: String
	var rotation: float
	var rotation_speed: float
	
	func _init(vel: Vector2, anim: String):
		position = Vector2.ZERO
		velocity = vel
		animation_name = anim
		rotation = randf_range(0, TAU)
		rotation_speed = randf_range(-5.0, 5.0)

func _ready() -> void:
	$death.start()
	available_animations = animated_sprite.sprite_frames.get_animation_names()
	animated_sprite.visible = false

func _process(delta: float) -> void:
	
	if emission_timer < emission_duration:
		var count = ceil(particle_count * delta / emission_duration)
		for i in count:
			spawn_particle()
		emission_timer += delta
	
	
	for p in particles:
		p.velocity.y += gravity * delta
		p.position += p.velocity * delta
		p.rotation += p.rotation_speed * delta
	
	queue_redraw()

func spawn_particle() -> void:
	var vel = Vector2(
		randf_range(initial_velocity_min.x, initial_velocity_max.x),
		randf_range(initial_velocity_min.y, initial_velocity_max.y)
	)
	var anim = available_animations[randi() % available_animations.size()]
	particles.append(Particle.new(vel, anim))

func _draw() -> void:
	for p in particles:
		var texture = animated_sprite.sprite_frames.get_frame_texture(p.animation_name, 0)
		if texture:
			draw_set_transform(p.position, p.rotation, Vector2.ONE)
			draw_texture(texture, -texture.get_size() / 2)
	draw_set_transform(Vector2.ZERO, 0, Vector2.ONE)

func _on_death_timeout() -> void:
	queue_free()
