extends Sprite2D

var enemy_to_spawn: PackedScene

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)
	
func on_player_turn_start():
	var container = get_tree().get_first_node_in_group("enemy_container")
	
	if enemy_to_spawn == null or container == null:
		queue_free()
		return
	
	var enemy = enemy_to_spawn.instantiate()
	enemy.global_position = global_position
	container.add_child(enemy)
	queue_free()
	
