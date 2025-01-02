extends Control

func _ready() -> void:
	MenuFx.play_menu()

func _on_start_game_pressed() -> void:
	MenuFx.button_click()
	get_tree().change_scene_to_file("res://Main Scenes/menu/select_difficulty.tscn")

func _on_settings_pressed() -> void:
	MenuFx.button_click()
	get_tree().change_scene_to_file("res://Main Scenes/menu/settings.tscn")

func _on_exit_pressed() -> void:
	MenuFx.button_click()
	get_tree().quit()
