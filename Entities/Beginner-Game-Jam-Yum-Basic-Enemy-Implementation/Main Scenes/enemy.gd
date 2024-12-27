extends RigidBody2D

# This vector aims towards the player
var directionVector: Vector2

# directionVector is multiplied by a velocity scalar in order to move
var movementVector:Vector2

# To be gotten from external source
var playerPosition:Vector2

# Whether it is the enemy's turn or not is given by...
var isTurn = false
 
func _process(delta):
	if (isTurn):
		var velocity = 100
		moveToPlayer(delta, velocity)
		animate()

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
func touchPlayer():
	pass

# eventlistener - if enemy collision box touches ball then remove this enemy
func touchBall():
	self.queue_free()
