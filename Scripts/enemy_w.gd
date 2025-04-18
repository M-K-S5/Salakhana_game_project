extends CharacterBody2D

const speed = 60

var direction = 1

@onready var right =  $RayCastright
@onready var left =  $RayCastleft
@onready var animatedSprite = $AnimatedSprite2D
@onready var player = get_parent().get_node("player")
@onready var health = $"player/Camera2D/CanvasLayer/health bar"

func _process(delta: float) -> void:
	if right.is_colliding():
		direction = -1
		animatedSprite.flip_h = true
		
	if left.is_colliding():
		direction = 1
		animatedSprite.flip_h = false
		
	velocity.x += direction * speed * delta
	move_and_slide()
