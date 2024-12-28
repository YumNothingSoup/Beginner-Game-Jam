extends Node

# For combos when they get implemented (this currently doesn't do anything)
var enemies_killed: int = 0

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)

func gain_score(value: int):
	GlobalData.score += value
	enemies_killed += 1
	
func on_player_turn_start():
	enemies_killed = 0
