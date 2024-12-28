extends CharacterBody2D
class_name BowlingBall

# When speed reaches the threshold or lower, the player's turn ends
@export var velocity_threshold: float = 5
# Starting speed when thrown
@export var throw_strength: float = 1000

# Lose this amount of speed every second
@export var speed_loss_over_time: float = 200

@onready var player: CharacterBody2D = %Player

# Collisions
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var hurtbox: Area2D = %Hurtbox

var ball_direction: Vector2 = Vector2.ZERO
var speed: float = 0

var has_stopped = true
var can_throw = true

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)

func _physics_process(delta: float) -> void:
	if !has_stopped and is_stationary():
		on_player_turn_end()
		
	if Input.is_action_just_released("left_mouse") and can_throw:
		# Launch ball at mouse direction
		launch_ball((get_global_mouse_position() - global_position).normalized(), throw_strength)
		
	# Handling movement
	velocity = ball_direction * speed * delta
	var collision = move_and_collide(velocity)
	
	# Bounce when it collides with an object
	if collision:
		ball_direction = velocity.bounce(collision.get_normal()).normalized()
		
	# Lose speed over time
	if speed > 0:
		speed -= speed_loss_over_time * delta
	
func on_player_turn_start():
	can_throw = true
	
func on_player_turn_end():
	emit_signal("ball_stopped")
	has_stopped = true
	
	# Resets the ball to the center and hides it
	hide()
	global_position = player.global_position
	speed = 0
	ball_direction = Vector2.ZERO
	collision_shape_2d.disabled = true
	hurtbox.monitoring = false
	

func launch_ball(direction: Vector2, force: float):
	has_stopped = false
	can_throw = false
	show()
	collision_shape_2d.disabled = false
	hurtbox.monitoring = true
	
	ball_direction = direction
	speed = force

func is_stationary() -> bool:
	# Check if speed is lower than the threshold
	return speed < velocity_threshold

#Upon hitting a pin, trigger their 'touchBall' function
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Pin:
		area.touchBall()
		
signal ball_stopped()
