class_name Pin
extends Area2D

# This vector aims towards the player
var directionVector: Vector2

# directionVector is multiplied by a velocity scalar in order to move
var movementVector:Vector2

# To be gotten from external source
var playerPosition:Vector2

# Whether it is the enemy's turn or not is given by...
var isTurn = false

# Enemy movement speed, made it an export variable for better testing
@export var velocity: float = 100

func _ready() -> void:
	Events.enemy_turn_started.connect(on_enemy_turn_start)
	Events.player_turn_started.connect(on_player_turn_start)
 
func _process(delta):
	playerPosition = get_tree().get_first_node_in_group("player").global_position
	
	if (isTurn):
		moveToPlayer(delta, velocity)
		animate()

func on_enemy_turn_start():
	isTurn = true
	
func on_player_turn_start():
	isTurn = false

# Locate player and move at constant rate to ehm
func moveToPlayer(delta, velocity):
	directionVector = self.position.direction_to(playerPosition)
	movementVector = directionVector * velocity
	self.position += movementVector * delta

# Update enemy's animations
func animate():
	if (movementVector.length() > 0):
		$enemyAnimatedGraphic.play()
	else: 
		$enemyAnimatedGraphic.stop()

	if movementVector.x != 0:
		if movementVector.x > 0:
			$enemyAnimatedGraphic.animation = "look_right"
		else:
			$enemyAnimatedGraphic.animation = "look_left"
	
	elif movementVector.y != 0:
		if movementVector.y > 0:
			$enemyAnimatedGraphic.animation = "look_down"
		else:
			$enemyAnimatedGraphic.animation = "look_up"

# eventlistener - if enemy collision box touches player's then end game

# eventlistener - if enemy collision box touches ball then remove this enemy
func touchBall():
	self.queue_free()
