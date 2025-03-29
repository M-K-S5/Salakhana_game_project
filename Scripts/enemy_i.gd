extends CharacterBody2D

@export var speed = 300
@export var boosted_speed = 500  # Speed when the player enters the area
var player_position
var target_position

@onready var player = get_parent().get_node("player")
@onready var detection_area = $Area2D  # Assuming you have an Area2D node attached to the enemy
@onready var animated_sprite = $AnimatedSprite2D  # Assuming the sprite is AnimatedSprite2D

var is_player_in_area = false  # Track if the player is in the detection area

# Called when the player enters the detection area
func _ready():
	# Connect signals for the area entered and exited events
	detection_area.connect("area_entered", Callable(self, "_on_detection_area_area_entered"))
	detection_area.connect("area_exited", Callable(self, "_on_detection_area_area_exited"))
	
	# Set idle animation on start (enemy should be idle initially)
	animated_sprite.play("idle")

func _physics_process(delta):
	if is_player_in_area:
		# Flip the sprite based on the player's position (x-value)
		if position.x > player.global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

		player_position = player.position
		# Calculate the direction towards the player
		target_position = (player_position - position).normalized()

		# Move the enemy toward the player if they are more than 3px away
		if position.distance_to(player_position) > 3:
			velocity = target_position * speed  # Set the velocity directly
			move_and_slide()  # Move the character based on the velocity
			# Set running animation if moving
			if !animated_sprite.is_playing() or animated_sprite.animation != "run":
				animated_sprite.play("run")
		else:
			# When very close to the player, stop moving and play idle animation
			if !animated_sprite.is_playing() or animated_sprite.animation != "idle":
				animated_sprite.play("idle")
				velocity = Vector2.ZERO  # Stop moving when idle near the player
	else:
		# If the player is not in the area, the enemy stays idle and doesn't move
		if !animated_sprite.is_playing() or animated_sprite.animation != "idle":
			animated_sprite.play("idle")
		velocity = Vector2.ZERO  # Stop moving

	# Apply the velocity (even when idle)
	move_and_slide()

# Called when the player enters the detection area
	
# Called when the player exits the detection area


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		print("Player entered detection area")  # Debug print
		is_player_in_area = true  # Player is now in the detection area
		animated_sprite.play("run")  # Play running animation when player enters
		velocity = Vector2.ZERO  # Ensure the enemy starts at rest when the player enters


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		print("Player exited detection area")  # Debug print
		is_player_in_area = false  # Player is no longer in the detection area
		animated_sprite.play("idle")  # Play idle animation when player exits
		velocity = Vector2.ZERO  # Stop moving when the player leaves
