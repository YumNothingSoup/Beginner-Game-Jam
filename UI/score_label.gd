extends Label

func _process(_delta: float) -> void:
	text = "SCORE: %s\nHIGH SCORE: %s" % [str(GlobalData.score), str(GlobalData.high_score)]
