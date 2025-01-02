extends Node

@onready var enemy_turn_timer: Timer = %EnemyTurnTimer
@onready var enemy_turn_sfx: AudioStreamPlayer2D = $EnemyTurnSFX

func _ready() -> void:
	Events.player_turn_started.emit()

func start_enemy_turn():
	Events.enemy_turn_started.emit()
	enemy_turn_sfx.play()
	enemy_turn_timer.start()
	
func _on_enemy_turn_timer_timeout() -> void:
	Events.player_turn_started.emit()

func _on_bowling_ball_ball_stopped() -> void:
	start_enemy_turn()
