extends RigidBody2D
class_name BowlingBall

# Threshold to determine if the body is considered stationary
@export var velocity_threshold: float = 0.25

var has_stopped = false

func _physics_process(delta: float) -> void:
	if !has_stopped and is_stationary():
		emit_signal("ball_stopped")
		has_stopped = true

func launch_ball(direction: Vector2, force: float):
	has_stopped = false
	apply_impulse(direction * force)

func is_stationary() -> bool:
	# Check if both linear and angular velocities are below the threshold
	return linear_velocity.length() < velocity_threshold and abs(angular_velocity) < velocity_threshold

signal ball_stopped()
