extends Control

func Resume():
	get_tree().paused = false
	hide()

func Pause():
	get_tree().paused = true
	show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if !get_tree().paused:
			Pause()		
		elif get_tree().paused:
			Resume()

func _on_resume_pressed():
	Resume()

func _on_restart_pressed() -> void:
	Resume()
	get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()