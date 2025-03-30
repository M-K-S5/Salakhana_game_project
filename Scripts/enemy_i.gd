extends CharacterBody2D

@export var speed = 300
@export var boosted_speed = 500
var player_position
var target_position
@onready var player = $"/root/player"
@onready var detection_area = $Area2D
@onready var animated_sprite = $AnimatedSprite2D
var is_player_in_area = false


func _ready():
	
	detection_area.connect("area_entered", Callable(self, "_on_detection_area_area_entered"))
	detection_area.connect("area_exited", Callable(self, "_on_detection_area_area_exited"))
	animated_sprite.play("idle")

func _physics_process(_delta):
	if is_player_in_area:
		if position.x > player.global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

		player_position = player.position
		target_position = (player_position - position).normalized()


		if position.distance_to(player_position) > 3:
			velocity = target_position * speed
			move_and_slide()
			if !animated_sprite.is_playing() or animated_sprite.animation != "run":
				animated_sprite.play("run")
		else:
			if !animated_sprite.is_playing() or animated_sprite.animation != "idle":
				animated_sprite.play("idle")
				velocity = Vector2.ZERO
	else:
		if !animated_sprite.is_playing() or animated_sprite.animation != "idle":
			animated_sprite.play("idle")
		velocity = Vector2.ZERO


	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player:
		print("Player entered detection area")
		is_player_in_area = true
		animated_sprite.play("run")
		velocity = Vector2.ZERO


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		print("Player exited detection area")
		is_player_in_area = false
		animated_sprite.play("idle")
		velocity = Vector2.ZERO
