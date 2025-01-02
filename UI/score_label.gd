extends VBoxContainer

@onready var score_label: Label = %ScoreLabel
@onready var highscore_label: Label = %HighscoreLabel

func _process(_delta: float) -> void:
	score_label.text = str(GlobalData.score)
	highscore_label.text = str(GlobalData.high_score)
