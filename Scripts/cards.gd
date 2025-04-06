extends Node2D

@export var Selected : int
var current_card = Selected

@onready var anim_card: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_card2: AnimatedSprite2D = $AnimatedSprite2D2 

func _ready():
	anim_card.play("default")  
	anim_card2.play(anim_card.animation)  

func _process(_delta):
	if anim_card2.animation != anim_card.animation:
		anim_card2.play(anim_card.animation)
