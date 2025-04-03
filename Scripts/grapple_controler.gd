extends Node2D

@export var rest_lenght = 2.0
@export var rope_tin = 10.0
@export var damping = 2.0

@onready var rope := $Line2D
@onready var player: CharacterBody2D = $".."
@onready var ray: RayCast2D = $RayCast2D

var is_launched = false
var target: Vector2

func _physics_process(delta: float) -> void:
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		launch()
	if Input.is_action_just_released("grapple"):
		retract()
	if is_launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		is_launched = true
		target = ray.get_collision_point()

func retract():
	is_launched = false

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_distance = player.global_position.distance_to(target)
	var displacement = target_distance - rest_lenght
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_mag = rope_tin * displacement
		var spring_force = target_dir * spring_force_mag
		
		var vel_dot = player.velocity.dot(target_dir)
		damping = - damping * vel_dot * target_dir
		force = spring_force + damping 
	player.velocity += force * delta
	update_rope()

func update_rope():
	rope.set_point_position(1,to_local(target))
