extends Node

@onready var multiplier_label: Label = %MultiplierLabel

# The combos you can get
var combos: Dictionary = {
	"Base": {
		"Text": "",
		"Multiplier": 1,
		"Kills to Activate": 0
		},
	
	"Combo2": {
		"Text": "Good!",
		"Multiplier": 2,
		"Kills to Activate": 3
		},
		
	"Combo3": {
		"Text": "Great!",
		"Multiplier": 3,
		"Kills to Activate": 6
		},
		
	"Combo4": {
		"Text": "DELIVARY!",
		"Multiplier": 4,
		"Kills to Activate": 10
		}
	}

# For combos when they get implemented (this currently doesn't do anything)
# Set function that calls handle_combos every time this value changes
var enemies_killed: int = 0:
	set(value):
		enemies_killed = value
		handle_combos()

var score_multiplier: int = 1

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)

func gain_score(value: int):
	GlobalData.score += value * score_multiplier
	enemies_killed += 1
	
func on_player_turn_start():
	enemies_killed = 0
	
func handle_combos():
	# Iterate through combos dictionary to find the highest combo that the player got, then assign it
	# to a variable
	var current_combo
	for combo in combos:
		if enemies_killed >= combos[combo]["Kills to Activate"]:
			current_combo = combo
	
	# Combo takes effect, updating multiplier and label
	score_multiplier = combos[current_combo]["Multiplier"]
	if multiplier_label != null:
		multiplier_label.update_label(combos[current_combo]["Text"], score_multiplier)
