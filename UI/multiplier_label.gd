extends Label

func update_label(message: String, multi: int):
	# Text will only show for combos and clears itself otherwise
	if message == "" or multi == 1:
		text = ""
		return
		
	text = "MULTIPLIER: %sX (%s)" % [multi, message]
