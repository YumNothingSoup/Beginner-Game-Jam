extends Node2D

func _ready() -> void:
	Events.game_start.emit()
