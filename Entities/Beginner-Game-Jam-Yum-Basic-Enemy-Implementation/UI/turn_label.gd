extends Label

func _ready() -> void:
	Events.player_turn_started.connect(display_turn_player)
	Events.enemy_turn_started.connect(display_turn_enemy)
	
func display_turn_player():
	text = "CURRENT TURN: PLAYER"
	
func display_turn_enemy():
	text = "CURRENT TURN: PINS"
