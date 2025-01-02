extends Node2D

func _ready() -> void:
	MenuFx.play_game()
	Events.game_start.emit()
