extends Control
@onready var music: HSlider = %Music
@onready var sfx: HSlider = %SFX

func _ready():
	music.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Scenes/menu/main_menu.tscn")

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear_to_db(value))
	AudioServer.set_bus_mute(1, value <= 0.05)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear_to_db(value))
	AudioServer.set_bus_mute(2, value <= 0.05)
