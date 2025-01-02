extends Control


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
	get_tree().change_scene_to_file("res://scene_not_main/entry_to_game.tscn")
