extends Control



func _process(delta: float) -> void:
	If_esc_pressed()



func Resume():
	
	get_tree().paused= false
	self.visible = false

func Pause():
	get_tree().paused= true

func If_esc_pressed():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		Pause()
		self.visible = true
	if Input.is_action_just_pressed("esc") and get_tree().paused:
		Resume()
		self.visible = true
		


func _on_resume_pressed() :
	Resume()

func _on_restart_pressed() -> void:
	Resume()
	get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
