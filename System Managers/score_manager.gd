extends Node

const SCORE_POPUP = preload("res://UI/score_popup.tscn")
@onready var combo_sfx: AudioStreamPlayer2D = $ComboSFX

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
		"Text": "DELIVERY!",
		"Multiplier": 4,
		"Kills to Activate": 10
		}
	}
	
var current_combo: String

var enemies_killed: int = 0

var score_multiplier: int = 1

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)

func gain_score(value: int, pos: Vector2):
	var total_score: int = value * score_multiplier
	GlobalData.score += total_score
	
	# Handle score popups
	var popup = SCORE_POPUP.instantiate()
	popup.text = str(total_score)
	popup.global_position = pos + Vector2(0, -15)
	get_tree().root.add_child(popup)
	popup.popup("Score")
	
	enemies_killed += 1
	
	handle_combos(pos + Vector2(0, -15))
	
	
func on_player_turn_start():
	enemies_killed = 0
	handle_combos()
	
func handle_combos(pos: Vector2 = Vector2.ZERO):
	# Iterate through combos dictionary to find the highest combo that the player got, then assign it
	# to a variable
	var combo
	for i in combos:
		if enemies_killed >= combos[i]["Kills to Activate"]:
			combo = i
	
	if combo == current_combo:
		return
		
	# Combo takes effect, updating multiplier and label
	current_combo = combo
	score_multiplier = combos[combo]["Multiplier"]
		
	if score_multiplier != 1 and pos != Vector2.ZERO:
		var popup = SCORE_POPUP.instantiate()
		popup.text = "%s (%sX)" % [combos[combo]["Text"], score_multiplier]
		popup.global_position = pos + Vector2(0, -15)
		get_tree().root.add_child(popup)
		popup.popup("Combo")
		
		combo_sfx.pitch_scale = randf_range(0.8, 0.9)
		get_tree().get_first_node_in_group("audio_manager").add_audio(combo_sfx)
