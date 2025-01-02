extends Node2D

@onready var score_label: RichTextLabel = %ScoreLabel
@onready var line_edit: LineEdit = %LineEdit
@onready var leaderboard_ui: LeaderboardUI = %LeaderboardUI

var id: String = "indie-game-dev-winte-normal-difficul-EZQl"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_label.text = "[center]SCORE: [color='BLUE']%s[/color]\nHIGHSCORE: [color='RED']%s[/color]" % [str(GlobalData.score), str(GlobalData.high_score)]
	if GlobalData.has_submitted == true:
		line_edit.editable = false
		line_edit.placeholder_text = "You have already submitted your score this run"
	match GlobalData.selected_difficulty:
		Enums.DIFFICULTY.EASY:
			id = "indie-game-dev-winte-easy-difficulty-S8qo"
			leaderboard_ui.scores_label.text = "Scores (EASY)"
		Enums.DIFFICULTY.MEDIUM:
			id = "indie-game-dev-winte-normal-difficul-EZQl"
			leaderboard_ui.scores_label.text = "Scores (NORMAL)"
		Enums.DIFFICULTY.HARD:
			id = "indie-game-dev-winte-hard-difficulty-c6Ge"
			leaderboard_ui.scores_label.text = "Scores (HARD)"
	leaderboard_ui.leaderboard_id = id
	leaderboard_ui.refresh_scores()

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")

func _on_line_edit_text_submitted(new_text: String) -> void:
	if GlobalData.has_submitted == true:
		return
	await Leaderboards.post_guest_score(id, GlobalData.score, new_text)
	GlobalData.has_submitted = true
	get_tree().reload_current_scene()

func _on_quit_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Scenes/menu/main_menu.tscn")
