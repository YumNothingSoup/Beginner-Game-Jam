extends Label

func _ready() -> void:
	Events.player_turn_started.connect(display_turn_player)
	Events.enemy_turn_started.connect(display_turn_enemy)
	display_turn_player()
	
func display_turn_player():
	text = "PLAYER"
	
func display_turn_enemy():
	text = "PINS"
