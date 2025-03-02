extends AnimatedSprite2D

#DO NOT TOUCH THIS SCRIPT UNLESS ABSOLUTELY NECESSARY!!!!
#DO NOT TOUCH THIS SCRIPT UNLESS ABSOLUTELY NECESSARY!!!!
#DO NOT TOUCH THIS SCRIPT UNLESS ABSOLUTELY NECESSARY!!!!

@onready var player = $".."

enum AnimationState {
	RUN,
	JUMP,
	FALL,
	DASH,
	IDLE
}
var current_state: AnimationState = AnimationState.IDLE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_Left") || Input.is_action_pressed("move_Right"):
		print("Flip Check")
		flip_check() #makes the player look left if moving left and right if moving right
	
	match current_state:
		AnimationState.DASH:
			player.can_jump = false
			await animation_finished
			player.can_jump = true
			if player.jump_after_dash && player.jump_charges_max > 0:
				change_State(AnimationState.JUMP)
			elif not player.is_on_floor() && not player.jump_after_dash:
				change_State(AnimationState.FALL)
			elif  player.is_on_floor() && player.velocity.x != 0:
				change_State(AnimationState.RUN)
			elif player.is_on_floor() && player.velocity.x == 0:
				change_State(AnimationState.IDLE)
		
		AnimationState.FALL:
			if not player.dash_on_cooldown && Input.is_action_pressed("dash"):
				change_State(AnimationState.DASH)
			elif player.jump_charges_max > 0 && Input.is_action_pressed("jump"):
				change_State(AnimationState.JUMP)
			elif player.is_on_floor() && player.velocity.x != 0:
				change_State(AnimationState.RUN)
			elif player.is_on_floor() && player.velocity.x == 0:
				change_State(AnimationState.IDLE)
		
		AnimationState.JUMP:
			if not player.dash_on_cooldown && Input.is_action_pressed("dash"):
				change_State(AnimationState.DASH)
			elif player.jump_charges_max > 0 && Input.is_action_pressed("jump"):
				change_State(AnimationState.JUMP)
			elif player.velocity.y > 0 && not player.is_on_floor():
				change_State(AnimationState.FALL)
			elif player.is_on_floor() && player.velocity.x != 0:
				change_State(AnimationState.RUN)
			elif player.is_on_floor() && player.velocity.x == 0:
				change_State(AnimationState.IDLE)
			
		AnimationState.RUN:
			if not player.dash_on_cooldown && Input.is_action_pressed("dash"):
				change_State(AnimationState.DASH)
			elif player.jump_charges_max > 0 && Input.is_action_pressed("jump"):
				change_State(AnimationState.JUMP)
			elif player.velocity.y > 0 && not player.is_on_floor():
				change_State(AnimationState.FALL)
			elif player.is_on_floor() && player.velocity.x == 0:
				change_State(AnimationState.IDLE)
			
		AnimationState.IDLE:
			if not player.dash_on_cooldown && Input.is_action_pressed("dash"):
				change_State(AnimationState.DASH)
			elif player.jump_charges_max > 0 && Input.is_action_pressed("jump"):
				change_State(AnimationState.JUMP)
			elif player.velocity.y > 0 && not player.is_on_floor():
				change_State(AnimationState.FALL)
			elif player.is_on_floor() && player.velocity.x != 0:
				change_State(AnimationState.RUN)
			
	
	if player.dashing:
		current_state = AnimationState.DASH
	elif player.falling:
		current_state = AnimationState.FALL
	elif player.jumping:
		current_state = AnimationState.JUMP
	elif player.running:
		current_state = AnimationState.RUN
	

func flip_check():
	if player.velocity.x > 0 && player.scale.y < 0:
		player.scale.x *= -1
		print("Flipped")
		
	elif player.velocity.x < 0 && player.scale.y > 0:
		player.scale.x *= -1
		print("Flipped")

func change_State(new_state:AnimationState):
	if current_state == new_state:
		return
	current_state = new_state
	match new_state:
		AnimationState.DASH:
			play("Dash")
			player.dashing = true
			player.falling = false
			player.jumping = false
			player.running = false
		AnimationState.FALL:
			play("Fall")
			player.dashing = false
			player.falling = true
			player.jumping = false
			player.running = false
			print("Fall")
		AnimationState.JUMP:
			play("Jump")
			player.dashing = false
			player.falling = false
			player.jumping = true
			player.running = false
		AnimationState.RUN:
			play("Run")
			player.dashing = false
			player.falling = false
			player.jumping = false
			player.running = true
			print("Run")
		AnimationState.IDLE:
			play("Idle")
			player.dashing = false
			player.falling = false
			player.jumping = false
			player.running = false
			print("Idle")
