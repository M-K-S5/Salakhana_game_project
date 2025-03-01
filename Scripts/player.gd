extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var jump_charges:int = 2

var dashing:bool = false
var falling:bool = false
var jumping:bool = false
var running:bool = false
var jump_after_dash:bool = false
var dash_on_cooldown:bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		falling = true
	else:
		falling = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumping = true
	else:
		jumping = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_Left", "move_Right")
	if direction:
		velocity.x = direction * SPEED
		running = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		running = false

	move_and_slide()
