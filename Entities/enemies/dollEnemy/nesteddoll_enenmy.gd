
class_name Doll_Enemy
extends Area2D


var Lives:int=3

# This vector aims towards the player
var directionVector: Vector2

# directionVector is multiplied by a velocity scalar in order to move
var movementVector:Vector2

# To be gotten from external source
var playerPosition:Vector2

# Whether it is the enemy's turn or not is given by...
var isTurn = false

# Enemy movement speed, made it an export variable for better testing
@export var velocity: float = 20

# Score given when knocked down
@export var value: int = 5

func _ready() -> void:
	Events.enemy_turn_started.connect(on_enemy_turn_start)
	Events.player_turn_started.connect(on_player_turn_start)
 
func _process(delta):
	playerPosition = get_tree().get_first_node_in_group("player").global_position
	
	animate()
	
	if (isTurn):
		moveToPlayer(delta, velocity)

func on_enemy_turn_start():
	isTurn = true
	
func on_player_turn_start():
	isTurn = false

# Locate player and move at constant rate to ehm
func moveToPlayer(delta, speed):
	directionVector = self.position.direction_to(playerPosition)
	movementVector = directionVector * speed
	self.position += movementVector * delta

# Update enemy's animations
func animate():
	if isTurn == true:
		$enemyAnimatedGraphic.play("morphed")
	else:
		$enemyAnimatedGraphic.play("standard")

	if movementVector.x != 0:
		if movementVector.x > 0:
			$enemyAnimatedGraphic.flip_h = false
		else:
			$enemyAnimatedGraphic.flip_h = true
	
	#elif movementVector.y != 0:
		#if movementVector.y > 0:
			#$enemyAnimatedGraphic.animation = "look_down"
		#else:
			#$enemyAnimatedGraphic.animation = "look_up"

# eventlistener - if enemy collision box touches player's then end game

# eventlistener - if enemy collision box touches ball then remove this enemy
func Doll_touch():
	var score_manager = get_tree().get_first_node_in_group("score_manager")
	if score_manager != null:
		score_manager.gain_score(value, global_position)
	Lives -=1
	Smaller()
	
func Smaller():
	if Lives == 2:
		velocity = 40
		$AnimationPlayer.play("small_1")
	if Lives == 1:
		velocity = 80
		$AnimationPlayer.play("small_2")
	if Lives == 0:
		self.queue_free()
