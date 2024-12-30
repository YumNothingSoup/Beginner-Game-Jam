extends Node

var score: int = 0

func _ready() -> void:
	Events.game_start.connect(on_game_start)
	
func on_game_start():
	score = 0
