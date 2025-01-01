extends Node

var score: int = 0:
	set(value):
		score = value
		if score > high_score:
			high_score = score
var high_score: int = 0

# So people don't submit their scores multiple times
var has_submitted: bool = false

func _ready() -> void:
	Events.game_start.connect(on_game_start)
	
func on_game_start():
	if score > high_score:
		high_score = score
	score = 0
	has_submitted = false
