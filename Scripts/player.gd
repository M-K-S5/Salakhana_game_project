extends CharacterBody2D



@onready var health_bar: TextureProgressBar = $"Camera2D/CanvasLayer/health bar"
@onready var charge: TextureProgressBar = $Camera2D/CanvasLayer/charge

# Grapple hook
const ACC = 0.1
const DACC = 0.1


@export_category("Movement")
@export var move_speed = 2500.0
@export var acceleration = 450.0
@export var floor_friction:float = 1

@export_category("Jump")
@export var jump_charges_max:int = 2
@onready var jump_charges = jump_charges_max
@onready var jump_velocity = ((1 * jump_height) / jump_time_to_peak) * -1
@export var jump_height:float = 50
@export var jump_time_to_peak:float = 0.5
@export var jump_time_to_descend:float = 0.25

@export_category("Dash")
@export var dash_force:float = 200

@onready var jump_gravity = ((-2 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity = ((-2 * jump_height) / (jump_time_to_descend * jump_time_to_descend)) * -1

@onready var friction_coeff:float = acceleration / move_speed
@onready var external_force:float = 0


var direction := Input.get_axis("move_Left", "move_Right")

var gravity:float
var friction:float
var running_speed:float = 0.0
var dash_speed:float = 0.0

var dashing:bool = false
var falling:bool = false
var jumping:bool = false
var running:bool = false
var dead:bool = false # add as condition for input detection

var can_dash:bool = false
var can_jump:bool = false
var have_charge:bool = true # if false can't dash nor double jump

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
	if GameData.isThereACharge == true: # hzm added this
		velocity.y = jump_velocity
		if not GameData.charges <= 0: # hzm added this
			if not is_on_floor():
				charge.use_charge()
				print("Mid-Air Jump")
			else:
				print("Jump")

func dash():
	if GameData.isThereACharge == true: # hzm added this
		print("Dash")
		dashing = true
		velocity.y = 0
		dash_speed = (dash_force * scale.y * 10)
		charge.use_charge()
		await $AnimatedSprite2D.animation_finished
		dash_speed = 0
		dashing = false

func _physics_process(delta: float) -> void:
	
	if is_on_floor() and GameData.charges < 3:
		charge.current_charge = 3
	else:
		pass
	
	# Add the gravity.
	friction = running_speed * friction_coeff * floor_friction
	if not is_on_floor():
		get_var_gravity()
		velocity.y += gravity * delta
	else:
		jump_charges = jump_charges_max

	# Handle jump.
	if is_on_floor() || charge.current_charge > 0:
		if not dashing:
			can_jump = true
		else:
			can_jump = false
	else:
		can_jump = false
	
	if charge.current_charge > 0 && not charge.current_charge ==0:
		can_dash = true
	else:
		can_dash = false

	if Input.is_action_just_pressed("dash") && can_dash:
		if GameData.dashisready :  # hzm added this
			if not GameData.charges <= 0: # hzm added this
				dash()
	
	if Input.is_action_just_pressed("jump") && can_jump :
		if GameData.isThereACharge == true: # hzm added this
			jump()



	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_Left", "move_Right")
	running_speed += direction * acceleration - friction
	if abs(running_speed) < 50:
		running_speed = 0
	velocity.x = running_speed + dash_speed + external_force
	
	if direction:
		velocity.x = lerp(velocity.x ,move_speed * direction , ACC)
		running = true
	else:
		velocity.x = lerp(velocity.x ,0.0 , DACC)
		running = false

	move_and_slide()

#-------------hzm added this-------------#

#---------------------------------------#

# hadeel added health func
#-------------------------
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		print("health decreased")
		health_bar.take_damage()
