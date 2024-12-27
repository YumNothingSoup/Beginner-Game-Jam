extends Node

@onready var enemy_turn_timer: Timer = %EnemyTurnTimer

#When the ball slows to a halt, it emits a signal. TurnManager will connect to that signal and call the
#function below
func start_enemy_turn():
	Events.enemy_turn_started.emit()
	enemy_turn_timer.start()
	
func _on_enemy_turn_timer_timeout() -> void:
	Events.player_turn_started.emit()
