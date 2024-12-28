extends Label

func _process(delta: float) -> void:
	text = "SCORE: " + str(GlobalData.score)
