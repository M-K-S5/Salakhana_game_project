extends Node2D
# cards: number and currently selected card
@export var  Selected : int
#var cards_number = [1,2,3]
var current_card = Selected

@onready var anim_card: AnimatedSprite2D = $AnimatedSprite2D

func _Pychics_Process():
	pass
