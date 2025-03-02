extends CharacterBody2D

@export var move_speed = 2500.0
@export var acceleration = 450.0
@export var floor_friction:float = 1

@export var jump_charges_max:int = 2
@export var jump_height:float = 300
@export var jump_time_to_peak:float = 0.5
@export var jump_time_to_descend:float = 0.25

@export var dash_force:float = 200

@onready var jump_velocity = ((2 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity = ((-2 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity = ((-2 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1
@onready var jump_charges = jump_charges_max

@onready var friction_coeff:float = acceleration / move_speed
@onready var external_force:float = 0

var direction := Input.get_axis("move_Left", "move_Right")

var gravity:float
var friction:float
var running_speed:float
var dash_speed:float = 0.0

var dashing:bool = false
var falling:bool = false
var jumping:bool = false
var running:bool = false

var can_dash:bool = false
var can_jump:bool = false

var jump_after_dash:bool = false
var dash_on_cooldown:bool = false

func get_var_gravity():
	if dashing:
		gravity = 0.0
	elif velocity.y < 0.0:
		gravity = jump_gravity
	else:
		gravity = fall_gravity

func jump():
	velocity.y = jump_velocity
	if not is_on_floor():
		jump_charges = jump_charges -1
		print("Mid-Air Jump")
	else:
		print("Jump")

func dash():
	print("Dash")
	velocity.y = 0
	dash_speed = (dash_force * scale.y * 10)
	await $AnimatedSprite2D.animation_finished
	dash_speed = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	friction = velocity.abs().x * friction_coeff * floor_friction + 1
	if not is_on_floor():
		get_var_gravity()
		velocity.y += gravity * delta
	else:
		jump_charges = jump_charges_max

	# Handle jump.
	if is_on_floor() || jump_charges > 0:
		can_jump = true
	else:
		can_jump = false
	
	if not dash_on_cooldown:
		can_dash = true
	
	if Input.is_action_just_pressed("dash") && can_dash:
		dash()
	
	if Input.is_action_just_pressed("jump") && can_jump :
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_Left", "move_Right")
	running_speed = move_toward(running_speed,0,friction)
	running_speed += direction * acceleration
	velocity.x = running_speed + dash_speed + external_force
	
	if direction:
		running = true
	else:
		running = false

	move_and_slide()
