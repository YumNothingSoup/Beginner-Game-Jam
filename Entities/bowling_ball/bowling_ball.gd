extends RigidBody2D
class_name BowlingBall

# Threshold to determine if the body is considered stationary
@export var velocity_threshold: float = 5
# Force applied when thrown
@export var throw_strength: float = 1000

@onready var player: CharacterBody2D = %Player

# Collisions
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var hurtbox: Area2D = %Hurtbox

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
	
func on_player_turn_start():
	can_throw = true
	
func on_player_turn_end():
	emit_signal("ball_stopped")
	has_stopped = true
	
	# Teleports the ball to player position, hides it, and disables collision
	PhysicsServer2D.body_set_state(
	get_rid(),
	PhysicsServer2D.BODY_STATE_TRANSFORM,
	Transform2D.IDENTITY.translated(player.global_position)
)
	hide()
	collision_shape_2d.disabled = true
	hurtbox.monitoring = false
	

func launch_ball(direction: Vector2, force: float):
	has_stopped = false
	can_throw = false
	show()
	collision_shape_2d.disabled = false
	hurtbox.monitoring = true
	apply_impulse(direction * force)

func is_stationary() -> bool:
	# Check if both linear and angular velocities are below the threshold
	return linear_velocity.length() < velocity_threshold and abs(angular_velocity) < velocity_threshold

signal ball_stopped()

#Upon hitting a pin, trigger their 'touchBall' function
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Pin:
		area.touchBall()
