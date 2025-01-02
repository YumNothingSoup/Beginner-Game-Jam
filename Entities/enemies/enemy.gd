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

@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var death_anim: AnimationPlayer = $DeathAnim

# Enemy movement speed, made it an export variable for better testing
@export var velocity: float = 100

# Score given when knocked down
@export var value: int = 1


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
func touchBall():
	# Check if score manager exists in the tree, then handle scoring
	var score_manager = get_tree().get_first_node_in_group("score_manager")
	if score_manager != null:
		score_manager.gain_score(value, global_position)
	
	collision_layer = 0
	collision_mask = 0
	death_animation()
	
func death_animation():
	sfx.pitch_scale = randf_range(0.9, 1)
	
	get_tree().get_first_node_in_group("audio_manager").add_audio(sfx)
	
	death_anim.play("death_anim")
	await death_anim.animation_finished
	self.queue_free()
