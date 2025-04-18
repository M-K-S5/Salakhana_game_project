extends Label

@onready var coin: Node2D = $"../../../../coins/coin"

func _physics_process(_delta: float) -> void:
	text = "Gold: " + str(GameData.score)
