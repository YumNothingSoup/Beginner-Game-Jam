extends Node2D

@onready var score_label: RichTextLabel = %ScoreLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var leaderboard_ui: LeaderboardUI = %LeaderboardUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "[center]SCORE: [color='BLUE']%s[/color]\nHIGHSCORE: [color='RED']%s[/color]" % [str(GlobalData.score), str(GlobalData.high_score)]
	if GlobalData.has_submitted == true:
		line_edit.editable = false
		line_edit.placeholder_text = "You have already submitted your score this run"

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")

func _on_line_edit_text_submitted(new_text: String) -> void:
	if GlobalData.has_submitted == true:
		return
	await Leaderboards.post_guest_score("indie-game-dev-winte-normal-difficul-EZQl", GlobalData.score, new_text)
	GlobalData.has_submitted = true
	get_tree().reload_current_scene()
