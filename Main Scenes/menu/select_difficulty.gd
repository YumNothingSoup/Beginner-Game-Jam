extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://Main Scenes/menu/main_menu.tscn")

func _on_easy_pressed() -> void:
	MenuFx.button_click()
	GlobalData.selected_difficulty = Enums.DIFFICULTY.EASY
	change_scene_to_game()

func _on_medium_pressed() -> void:
	MenuFx.button_click()
	GlobalData.selected_difficulty = Enums.DIFFICULTY.MEDIUM
	change_scene_to_game()

func _on_hard_pressed() -> void:
	MenuFx.button_click()
	GlobalData.selected_difficulty = Enums.DIFFICULTY.HARD
	change_scene_to_game()

func change_scene_to_game() -> void:
	if GlobalData.skip_cutscene == true:
		get_tree().change_scene_to_file("res://Main Scenes/game_area.tscn")
	else:
		get_tree().change_scene_to_file("res://scene_not_main/entry_to_game.tscn")


func _on_back_pressed() -> void:
	MenuFx.button_click()
	get_tree().change_scene_to_file("res://Main Scenes/menu/main_menu.tscn")
