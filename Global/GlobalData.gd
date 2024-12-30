extends Node

var score: int = 0:
	set(value):
		score = value
		if score > high_score:
			high_score = score
var high_score: int = 0

func _ready() -> void:
	Events.game_start.connect(on_game_start)
	
func on_game_start():
	if score > high_score:
		high_score = score
	score = 0
