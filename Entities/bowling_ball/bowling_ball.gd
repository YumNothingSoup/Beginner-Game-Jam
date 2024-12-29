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

# Sprite (to hide the ball)
@onready var sprite_2d: Sprite2D = %Sprite2D

@onready var prediction_ray: RayCast2D = %PredictionRayCast
@onready var prediction_line: Line2D = %PredictionLine

@export var max_prediction_distance: float = 600

# Keep it low to prevent an infinite loop
var prediction_max_bounces: int = 3

var ball_direction: Vector2 = Vector2.ZERO
var speed: float = 0

var has_stopped = true
var can_throw = true

func _ready() -> void:
	Events.player_turn_started.connect(on_player_turn_start)
	
func _process(delta: float) -> void:
	# Reset line every frame
	prediction_line.clear_points()
	
	# Start drawing prediction line when aiming
	if Input.is_action_pressed("left_mouse") and can_throw:
		# Line starting point at the origin
		prediction_line.add_point(Vector2.ZERO)
		prediction_ray.global_position = prediction_line.global_position
		# Cast ray towards mouse direction
		var _max_prediction_distance = max_prediction_distance
		prediction_ray.target_position = (get_global_mouse_position() - global_position).normalized() * _max_prediction_distance
		prediction_ray.force_raycast_update()
		
		var previous_collision_point = null
		var bounces := 0
		
		while true:
			# Handles ending the line
			if not prediction_ray.is_colliding():
				var point = prediction_ray.global_position + prediction_ray.target_position
				prediction_line.add_point(prediction_line.to_local(point))
				break
			
			# If ray collides, draw a point at the point of collision
			var collider = prediction_ray.get_collider()
			var collision_point = prediction_ray.get_collision_point()
			
			prediction_line.add_point(prediction_line.to_local(collision_point))
			
			# Handles bouncing on collision
	
			var normal = prediction_ray.get_collision_normal()
			
			if normal == Vector2.ZERO:
				break
				
			# Disable previous collisions (prevents error when raycast collides with the same object over and over
			# instead ofbouncing
			if previous_collision_point != null and previous_collision_point is TileMapLayer:
				previous_collision_point.tile_set.set_physics_layer_collision_layer(1, 1)
				previous_collision_point.tile_set.set_physics_layer_collision_mask(1, 1)
			
			if previous_collision_point is TileMapLayer:
				previous_collision_point = collider
				previous_collision_point.tile_set.set_physics_layer_collision_layer(0, 0)
				previous_collision_point.tile_set.set_physics_layer_collision_mask(0, 0)
				
			
			# Keeps raycast length consistent along bounces
			var distance = prediction_ray.global_position.distance_to(collision_point)
			_max_prediction_distance = clampf(_max_prediction_distance - distance, 0, _max_prediction_distance)
			
			# Start new raycast starting from collision point
			prediction_ray.global_position = collision_point
			prediction_ray.target_position = prediction_ray.target_position.bounce(normal).normalized() * _max_prediction_distance
			prediction_ray.force_raycast_update()
			
			bounces += 1
			if bounces >= prediction_max_bounces:
				break
			
		
		#Re-enable collision upon exiting the loop
		if previous_collision_point != null and previous_collision_point is TileMapLayer:
				previous_collision_point.tile_set.set_physics_layer_collision_layer(1, 1)
				previous_collision_point.tile_set.set_physics_layer_collision_mask(1, 1)
				

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
	
	# Resets the ball to the center and hides it
	sprite_2d.hide()
	global_position = player.global_position
	speed = 0
	ball_direction = Vector2.ZERO
	collision_shape_2d.disabled = true
	hurtbox.monitoring = false
	
func on_player_turn_end():
	emit_signal("ball_stopped")
	has_stopped = true

func launch_ball(direction: Vector2, force: float):
	has_stopped = false
	can_throw = false
	sprite_2d.show()
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
