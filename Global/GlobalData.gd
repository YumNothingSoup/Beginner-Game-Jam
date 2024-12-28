extends Node

var score: int = 0

func _ready() -> void:
	Events.player_died.connect(on_player_death)

func on_player_death():
	score = 0
