extends CharacterBody2D

const speed = 40

var direction = 1

@onready var right =  $RayCastright
@onready var left =  $RayCastleft
@onready var animatedSprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	if right.is_colliding():
		direction = -1
		animatedSprite.flip_h = true
		
	if left.is_colliding():
		direction = 1
		animatedSprite.flip_h = false
		
	velocity.x += direction * speed * delta
	move_and_slide()
